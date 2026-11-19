# Guide de recette manuelle

Faire ces essais uniquement sur une base de test/préproduction autorisée, jamais sur la production. Garder les jetons et mots de passe dans les variables locales/Postman; ne pas les copier dans Git, un ticket ou un mail.

## 0. Installer l’historique partagé des erreurs API

La source est la table Oracle `SPAT_CAPITAINERIE.SPATERP_API_ERROR_LOG`. Elle conserve l’heure, le nom de l’API, la route regroupée, la méthode et le statut HTTP, sans le corps de la requête ni les jetons.

1. Après le feu vert, demander au DBA/encadreur d’exécuter `automation-api/db/001_api_error_log.sql`, puis `automation-api/db/002_api_error_log_writer.sql` une seule fois sur la base de test. Le premier accorde `SELECT` à `SPAT_RO`; le second crée un compte d’audit dédié avec `INSERT` uniquement et demande son mot de passe sans l’afficher. Ne donne aucun droit d’écriture à `SPAT_RO`.
2. La configuration actuelle de WildFly `standalone.xml` ne contient qu’`ExampleDS` en H2; aucune datasource Oracle n’y est déclarée. Les API du WAR n’utilisent donc pas de datasource Oracle WildFly déclarée dans ce fichier. Le journal utilise le compte `SPAT_API_AUDIT_WRITER` limité à l’insertion, plutôt que le compte métier.
3. Après création du compte d’audit par le DBA, lancer `scripts/configure-api-error-audit.ps1` depuis la racine du dépôt. Il stocke le mot de passe localement via DPAPI dans `automation-api/local/spat-ro-connection.xml`, ignoré par Git. Redémarrer Spring Boot avec `scripts/start-automation-api.ps1` et WildFly avec sa tâche habituelle; les deux chargent `SPAT_API_AUDIT_*`.
4. Vérifier les grants et le quota avec `automation-api/db/003_verify_api_error_log_grants.sql` en compte DBA. Le compte Spring ne doit avoir que `CREATE SESSION` et `INSERT` sur la table; `SPAT_RO` doit avoir `SELECT` uniquement.
5. Rebâtir puis déployer le WAR de recette avec la procédure du dépôt pour inclure le filtre WAR. Le filtre utilise directement JDBC avec `SPAT_API_AUDIT_JDBC_URL`, `SPAT_API_AUDIT_DB_USER` et `SPAT_API_AUDIT_DB_PASSWORD`; il ne réutilise pas la connexion métier `UtilDB`. Les scripts de démarrage activent `SPAT_API_AUDIT_ENABLED=true` seulement si le fichier local contient le compte d’audit et si la variable n’a pas été forcée à `false`. Les réponses API sous `/api/*` de statut 400 ou supérieur sont capturées.
6. Lancer un contrôle négatif sans écriture, par exemple `Rejeter demande invalide` ou `Rejeter sans jeton` dans la collection DASE. Puis vérifier la ligne avec une requête de lecture :

```sql
SELECT ERROR_AT, SERVICE_NAME, HTTP_METHOD, ENDPOINT, HTTP_STATUS, ERROR_CODE, SUMMARY
FROM SPAT_CAPITAINERIE.SPATERP_API_ERROR_LOG
WHERE ERROR_AT >= SYSTIMESTAMP - INTERVAL '1' DAY
ORDER BY ERROR_AT DESC;
```

Résultat attendu : une ligne `spat-war`, méthode et route correspondantes, statut HTTP 400/401 et code `HTTP_400`/`HTTP_401`. Pour les autres API, utiliser une requête négative déjà prévue dans leur collection. Ne pas fabriquer une erreur avec une vraie création/modification.

Après que le DBA a créé la table et accordé `SELECT`, la même vérification est disponible dans PowerShell/SQL*Plus avec le compte lecture seule :

```powershell
cd C:\Users\mamin\Desktop\spaterp-develop-vrai
.\automation-api\scripts\verify-api-error-log.ps1
```

Le script demande le mot de passe dans l’invite SQL*Plus, lit le nombre de lignes des dernières 24 heures puis affiche les 50 dernières. Pour une autre base, passer un connect string sans mot de passe, par exemple `-ConnectString 'SPAT_RO@//serveur:1521/XEPDB1'`. Il ne crée ni ne modifie de données.

## 1. Vérifier le changement DASE

1. Dans VS Code, ouvrir `Terminal > Run Task` et démarrer WildFly avec la tâche `SPAT : démarrer WildFly avec API`. Vérifier que l'application répond à `http://127.0.0.1:8080/spat/` et que l'identité DASE est configurée.
2. Ouvrir `automation-api/postman/environments/SPAT Local.environment.yaml` dans Postman. Compléter localement `baseUrl`, `daseApiToken`, la date, l'établissement et le projet avec les valeurs de recette fournies par l'encadreur. Laisser `enableDaseCreation` différent de `true` au départ.
3. Importer/ouvrir la collection `automation-api/postman/collections/SPAT DASE API/` et envoyer d'abord `Rejeter sans jeton` et `Rejeter demande invalide`. Résultats attendus : HTTP 401 puis HTTP 400. Ces requêtes ne doivent rien créer.
4. Pour vérifier la création normale, passer `enableDaseCreation` à `true` uniquement dans l'environnement local de recette, puis envoyer `Creer DASE de recette`. Résultat attendu : HTTP 201 et une ligne dans la réponse. Envoyer ensuite `Lire DASE de recette`; résultat attendu : HTTP 200 et le même identifiant. La création écrit réellement dans la base de recette.
5. Pour contrôler le garde-fou ajouté, reproduire une ligne que SPAT rejetait silencieusement avec une demande identifiée clairement comme test. Utiliser une valeur de recette volontairement rejetée par la règle SPAT connue de ton encadreur. Résultat attendu : la création échoue (HTTP 500), le journal WildFly indique le nombre de lignes attendu/relues, et aucune demande partielle ne subsiste. Vérifier ce dernier point dans SPAT ou avec le responsable de la recette avant de poursuivre. Ne pas inventer de référence réelle pour provoquer le rejet.
6. Réinitialiser `enableDaseCreation` à une valeur autre que `true` après l'essai.

La collection est aussi exécutable avec Postman CLI depuis `automation-api` :

```powershell
postman collection run "postman/collections/SPAT DASE API" `
  -e "postman/environments/SPAT Local.environment.yaml" `
  -i "Rejeter sans jeton" `
  -i "Rejeter demande invalide" `
  --no-report-events
```

Ces deux contrôles négatifs sont sûrs sans activer la création. La requête de création ne doit être lancée qu'en recette et après validation des références.

## 2. Importer et essayer le rapport quotidien d’erreurs API

Le fichier `automation-api/n8n/workflows/rapport-quotidien-erreurs-api-17h.json` est désactivé à l'import. Il lit la table d’historique et reprend les identifiants de connexion Oracle et SMTP présents dans le JSON `Mail anomalie tiers`; n8n pourra demander de remapper les connexions si l'import se fait dans une autre instance. La connexion Oracle de n8n doit pouvoir faire `SELECT` sur la table (le script accorde ce droit à `SPAT_RO`). Le destinataire du JSON est provisoirement réglé sur l’adresse `fromEmail` du modèle joint pour éviter d’envoyer un essai au responsable; confirme que c’est bien ton adresse avant tout essai.

1. Dans n8n, importer ce fichier depuis `Workflows > Import from File`.
2. Vérifier les connexions Oracle et SMTP, l'adresse destinataire et le fuseau `Indian/Antananarivo`. Le déclencheur est réglé à 17 h, minute 00. Garder le workflow désactivé pendant les vérifications.
3. Générer une erreur contrôlée avec une requête négative de recette, puis vérifier qu'une ligne existe dans `SPATERP_API_ERROR_LOG`. Utiliser `Execute Workflow` pour valider la lecture et l’envoi du rapport; pour éviter un mail de test au responsable, remplacer temporairement `toEmail` par ta propre adresse.
4. Vérifier le sujet, l’heure, le nombre, la route et les statuts reçus. Restaurer ensuite le destinataire prévu et activer le workflow après validation. Vérifier dans n8n que le prochain déclenchement est à 17 h, heure de Madagascar. Le modèle n’envoie pas de mail si aucune erreur n’a été enregistrée ce jour-là.

La table conserve l’historique; le rapport quotidien filtre les erreurs depuis minuit jusqu’au moment d’exécution en heure de Madagascar. Les identifiants/corps des requêtes ne sont pas conservés. Prévoir avec le DBA une politique de rétention/archivage si la table doit être limitée dans le temps.

## 3. Retour arrière

Si la recette échoue, désactiver le workflow d’envoi s'il a été activé. Pour arrêter la collecte sans supprimer l’historique, arrêter les services puis, dans la même fenêtre PowerShell qui lance les deux scripts, exécuter `$env:SPAT_API_AUDIT_ENABLED='false'` avant `.scripts\start-automation-api.ps1` et le démarrage WildFly. Les deux scripts respectent cette valeur et laissent la journalisation désactivée. Pour réactiver plus tard, fermer cette fenêtre puis relancer les scripts depuis une nouvelle fenêtre après avoir vérifié la configuration locale. La table peut rester en place pour préserver les erreurs déjà collectées.

Ne lance pas `git restore` sur `ApiDaseServlet.java` ou `README.md` pour cette seule fonction : ces fichiers contiennent aussi la correction DASE précédente. Une suppression de la table effacerait l’historique et n’est pas nécessaire pour désactiver la collecte.
