$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$workflowPath = Join-Path $repoRoot 'automation-api\n8n\workflows\validation-facture-fournisseur.json'
$n8nBase = 'http://127.0.0.1:5678'
$workflowName = 'SPAT - Validation facture fournisseur (lecture seule)'
Write-Host 'Tache locale de synchronisation n8n - version 2026-10-27a.'

if (-not (Test-Path -LiteralPath $workflowPath)) { throw "Workflow introuvable : $workflowPath" }
try {
    $health = Invoke-RestMethod -Uri "$n8nBase/healthz" -TimeoutSec 5
} catch {
    throw "n8n n'est pas joignable sur $n8nBase. Détail : $($_.Exception.Message)"
}

$secureKey = Read-Host 'Clé API n8n (saisie masquée ; Settings > n8n API)' -AsSecureString
if ($secureKey.Length -eq 0) { throw 'Clé API n8n manquante.' }
$bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureKey)
$apiKey = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
try {
    $headers = @{ 'X-N8N-API-KEY' = $apiKey }
    $apiBase = Read-Host 'URL de l’API SPAT vue depuis n8n [http://127.0.0.1:8088]'
    if (-not $apiBase) { $apiBase = 'http://127.0.0.1:8088' }
    $apiBase = $apiBase.TrimEnd('/')

    # Le health check seul ne prouve pas l'accès Oracle. Cette requête est en lecture seule.
    $localApiBase = 'http://127.0.0.1:8088'
    try {
        $apiHealth = Invoke-RestMethod -Uri "$localApiBase/api/v1/health" -TimeoutSec 5
    } catch {
        throw "L'API SPAT n'est pas joignable sur $localApiBase. Laissez tourner son terminal et vérifiez le journal de démarrage. Détail : $($_.Exception.Message). Aucun workflow n'a été importé."
    }
    if ($apiHealth.status -ne 'UP') { throw "L'API SPAT n'est pas UP. Demarrez-la avec la tache VS Code SPAT : demarrer API Oracle." }
    try {
        $apiReady = Invoke-RestMethod -Uri "$localApiBase/api/v1/ready" -TimeoutSec 20
    } catch {
        $readyError = $_.ErrorDetails.Message
        if (-not $readyError) { $readyError = $_.Exception.Message }
        throw "L'API répond mais n'est pas prête pour Oracle SPAT_RO. Vérifiez URL/JDBC, SPAT_RO et le journal API. Détail : $readyError. Aucun workflow n'a été importé."
    }
    if ($apiReady.status -ne 'UP') {
        throw "L'API répond mais la lecture Oracle SPAT_RO n'est pas prête. Aucun workflow n'a été importé."
    }
    $probeBody = @{
        idBonLivraison = 'BL-DEMO'
        idBonCommande = 'BC-DEMO'
        lignes = @(@{ idLigneLivraison = 'BLF-DEMO'; quantite = 1; prixUnitaire = 1 })
    } | ConvertTo-Json -Depth 8
    try {
        $probe = Invoke-RestMethod -Method Post -Uri "$localApiBase/api/v1/factures-fournisseurs/validation" -ContentType 'application/json' -Body $probeBody -TimeoutSec 25
    } catch {
        $statusCode = $null
        if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
            $statusCode = [int]$_.Exception.Response.StatusCode
        }
        $apiError = $_.ErrorDetails.Message
        if ($statusCode) {
            throw "La verification Oracle a echoue avec HTTP $statusCode. Consultez le journal du terminal API pour la cause detaillee. Reponse API : $apiError Aucun workflow n'a ete importe."
        }
        throw "La verification de l'API a echoue avant de recevoir une reponse HTTP. Verifiez que le service est joignable et consultez son journal. Detail : $($_.Exception.Message). Aucun workflow n'a ete importe."
    }
    if ($probe.statut -notin @('VALIDE', 'A_CORRIGER')) {
        throw "La lecture Oracle n'a pas retourne une reponse de validation reconnue. Aucun workflow n'a ete importe."
    }
    Write-Host "Lecture Oracle confirmee (resultat de controle : $($probe.statut))."

    $workflow = Get-Content -LiteralPath $workflowPath -Raw | ConvertFrom-Json
    $workflow.nodes | Where-Object { $_.name -eq 'Valider en lecture seule' } | ForEach-Object {
        $_.parameters.url = "$apiBase/api/v1/factures-fournisseurs/validation"
    }

    # Avoid a large, slow response from instances with many workflows. n8n supports cursor pagination;
    # a small page keeps each response bounded while still scanning the full inventory for duplicates.
    $existingWorkflows = @()
    $cursor = $null
    $page = 0
    do {
        $page++
        if ($page -gt 100) {
            throw "La liste n8n dépasse 100 pages. Aucun workflow ne sera modifié; vérifiez l’instance n8n."
        }
        $listUri = "$n8nBase/api/v1/workflows?limit=20"
        if ($cursor) {
            $listUri += "&cursor=$([Uri]::EscapeDataString([string]$cursor))"
        }
        try {
            $pageResult = Invoke-RestMethod -Uri $listUri -Headers $headers -TimeoutSec 30
        } catch {
            throw "La lecture de la liste n8n a échoué à la page $page après 30 secondes. Vérifiez l’accès API n8n et réessayez; aucun workflow ne sera modifié. Détail : $($_.Exception.Message)"
        }
        $existingWorkflows += @($pageResult.data)
        $cursor = $pageResult.nextCursor
        Write-Host "Inventaire n8n : page $page chargée; $($existingWorkflows.Count) workflows parcourus."
    } while ($cursor)

    $matches = @($existingWorkflows | Where-Object { $_.name -eq $workflowName })
    if ($matches.Count -gt 1) {
        throw "Plusieurs workflows nommés '$workflowName' existent. Aucun n'a été modifié. Vérifiez-les dans n8n."
    }
    if ($matches.Count -eq 1) {
        $current = Invoke-RestMethod -Uri "$n8nBase/api/v1/workflows/$($matches[0].id)" -Headers $headers -TimeoutSec 10
        $nodes = @($current.nodes)
        $existingWebhook = $nodes | Where-Object { $_.type -eq 'n8n-nodes-base.webhook' -and $_.parameters.path -eq 'spat/factures-fournisseurs/validation' } | Select-Object -First 1
        $existingRequest = $nodes | Where-Object { $_.type -eq 'n8n-nodes-base.httpRequest' -and $_.name -eq 'Valider en lecture seule' } | Select-Object -First 1
        $existingRequestUrl = if ($existingRequest) { [string]$existingRequest.parameters.url } else { '' }
        if ($nodes.Count -ne 3 -or -not $existingWebhook -or -not $existingRequest -or
            $existingWebhook.parameters.httpMethod -ne 'POST' -or
            $existingRequest.parameters.method -ne 'POST' -or
            $existingRequest.parameters.jsonBody -ne '={{$json.body}}' -or
            $existingRequestUrl -notmatch '/api/v1/factures-fournisseurs/validation$') {
            throw "Le workflow '$workflowName' existe (id $($current.id), actif=$($current.active)) mais sa structure ne correspond pas assez au flux SPAT attendu. Aucun changement effectué."
        }

        # Preserve the active webhook identity, then replace only this known SPAT workflow with the checked-in definition.
        $desiredWebhook = $workflow.nodes | Where-Object { $_.name -eq 'Recevoir la proposition' } | Select-Object -First 1
        $desiredRequest = $workflow.nodes | Where-Object { $_.name -eq 'Valider en lecture seule' } | Select-Object -First 1
        $desiredWebhook.id = $existingWebhook.id
        if ($existingWebhook.webhookId) { $desiredWebhook.webhookId = $existingWebhook.webhookId }
        $desiredRequest.id = $existingRequest.id
        $payload = @{
            name = $workflow.name
            nodes = $workflow.nodes
            connections = $workflow.connections
            settings = $workflow.settings
        } | ConvertTo-Json -Depth 100

        Write-Host "Mise a jour du workflow existant reconnu (id $($current.id)); son URL API et son noeud de reponse seront remplaces par la definition locale."
        $updated = Invoke-RestMethod -Method Put -Uri "$n8nBase/api/v1/workflows/$($current.id)" -Headers $headers -ContentType 'application/json' -Body $payload -TimeoutSec 20
        $updated = Invoke-RestMethod -Uri "$n8nBase/api/v1/workflows/$($current.id)" -Headers $headers -TimeoutSec 10
        if (-not $updated.active) {
            Invoke-RestMethod -Method Post -Uri "$n8nBase/api/v1/workflows/$($current.id)/activate" -Headers $headers -TimeoutSec 15 | Out-Null
        }
        Write-Host "Workflow existant synchronisé et actif : $workflowName (id $($current.id))."

        try {
            $webhookProbe = Invoke-RestMethod -Method Post -Uri "$n8nBase/webhook/spat/factures-fournisseurs/validation" -ContentType 'application/json' -Body $probeBody -TimeoutSec 30
        } catch {
            throw "Le workflow est synchronisé et actif, mais son webhook de production a échoué. Consultez Executions dans n8n. Détail : $($_.Exception.Message)"
        }
        if ($webhookProbe.statut -notin @('VALIDE', 'A_CORRIGER')) {
            throw "Le webhook actif n'a pas retourné de statut de validation reconnu. Vérifiez Executions dans n8n."
        }
        Write-Host "Webhook n8n vérifié (résultat de contrôle : $($webhookProbe.statut))."
        Write-Host 'Webhook de production : http://localhost:5678/webhook/spat/factures-fournisseurs/validation'
        return
    }

    $payload = @{
        name = $workflow.name
        nodes = $workflow.nodes
        connections = $workflow.connections
        settings = $workflow.settings
    } | ConvertTo-Json -Depth 100
    $created = Invoke-RestMethod -Method Post -Uri "$n8nBase/api/v1/workflows" -Headers $headers -ContentType 'application/json' -Body $payload -TimeoutSec 20
    if (-not $created.id) { throw "n8n n'a pas retourne l'identifiant du workflow cree." }

    try {
        Invoke-RestMethod -Method Post -Uri "$n8nBase/api/v1/workflows/$($created.id)/activate" -Headers $headers -TimeoutSec 15 | Out-Null
    } catch {
        Write-Warning "Le workflow a été importé (id $($created.id)), mais son activation a échoué. Activez-le dans l’interface n8n. Détail : $($_.Exception.Message)"
        throw
    }
    Write-Host "Workflow importé et activé : $workflowName (id $($created.id))."
    try {
        $webhookProbe = Invoke-RestMethod -Method Post -Uri "$n8nBase/webhook/spat/factures-fournisseurs/validation" -ContentType 'application/json' -Body $probeBody -TimeoutSec 30
    } catch {
        throw "Le workflow a été créé et activé, mais son webhook de production a échoué. Consultez Executions dans n8n. Détail : $($_.Exception.Message)"
    }
    if ($webhookProbe.statut -notin @('VALIDE', 'A_CORRIGER')) {
        throw "Le webhook actif n'a pas retourné de statut de validation reconnu. Vérifiez Executions dans n8n."
    }
    Write-Host "Webhook n8n vérifié (résultat de contrôle : $($webhookProbe.statut))."
    Write-Host 'Webhook de production : http://localhost:5678/webhook/spat/factures-fournisseurs/validation'
} finally {
    $apiKey = $null
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
    Remove-Variable headers -ErrorAction SilentlyContinue
}
