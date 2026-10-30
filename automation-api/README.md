# Service autonome de validation des factures fournisseurs

Service Spring Boot indépendant du WAR/EJB SPAT. Le premier incrément reçoit une proposition, lit la vue Oracle `SPAT_CAPITAINERIE.AS_BONDELIVRAISON_FILLEQTE_RES` et signale les lignes introuvables, les quantités supérieures au reste à facturer et les prix unitaires différents. Il ne crée ni facture, ni table, et n'écrit jamais dans SPAT.

## Prérequis et démarrage

- JDK 21 et Maven 3.9+
- Un compte Oracle **en lecture seule** (par exemple le compte SPAT_RO) et l'URL JDBC adéquate

Configurer `SPAT_RO_JDBC_URL`, `SPAT_RO_DB_USER`, `SPAT_RO_DB_PASSWORD` et `SPAT_RO_DB_ENABLED=true` dans l'environnement du processus. Aucun secret ne doit être placé dans Git. Démarrer depuis ce dossier avec `mvn spring-boot:run` ; le service écoute sur `http://localhost:8088`.

Sans configuration Oracle, `/api/v1/health` reste disponible et l'endpoint de validation répond `503 Service Unavailable` plutôt que de produire une validation fictive.

## Build et déploiement SPAT (Windows)

Depuis la racine du workspace, `scripts/build-spat-war.ps1` reconstruit l'EJB et le WAR, puis prépare les dépendances runtime déjà utilisées par le SPAT déployé. `scripts/deploy-spat-wildfly.ps1` remplace `spat.war` dans le dossier WildFly configuré, conserve une sauvegarde et restaure l'ancienne application si le déploiement échoue. Les paramètres `WildFlyHome`, `NetBeansHome` et `WarPath` peuvent être passés aux scripts si les installations utilisent d'autres chemins.

Ces scripts préparent et déploient le WAR SPAT ; ils ne démarrent pas l'API Spring Boot ni n8n. Leur activation et les variables locales Oracle/webhook restent à configurer séparément.

### Démarrage local depuis VS Code

Pour enregistrer les identifiants Oracle une seule fois et démarrer automatiquement l'API à chaque ouverture de session Windows, lancer `Tasks: Run Task`, puis choisir `SPAT : configurer Oracle et le démarrage automatique (première fois)`. Le script demande l'URL JDBC et le mot de passe du compte de lecture seule `SPAT_RO` (saisie masquée), puis crée une tâche Windows pour démarrer l'API au prochain démarrage de session. Le mot de passe est stocké dans un fichier local ignoré par Git et chiffré par Windows DPAPI pour le compte courant; il n'est pas écrit en clair dans le dépôt.

Après la configuration initiale, l'API démarre en arrière-plan avec Windows. Pour la démarrer manuellement, choisir `SPAT : démarrer API (Oracle)`; cette tâche relit la configuration chiffrée sans redemander les identifiants. Pour retirer le démarrage automatique, supprimer la tâche planifiée `SPAT Facture Automation API` dans le Planificateur de tâches Windows.

Pour démarrer automatiquement WildFly (et donc le WAR qui héberge les API SPAT Tiers et Utilisateurs), lancer une seule fois la tâche VS Code `SPAT : activer le démarrage automatique WildFly`. Elle démarre WildFly à l'ouverture de session avec Java 8, utilisé par l'installation WildFly 10 sur ce poste. La tâche vérifie d'abord si `/spat/` répond déjà et évite un deuxième démarrage. Elle lance le serveur en arrière-plan; le journal de démarrage est écrit dans `automation-api/target/wildfly-autostart.log`. Pour désactiver le démarrage, supprimer la tâche planifiée `SPAT WildFly`.

Après démarrage de l'API, choisir `SPAT : vérifier et activer workflow n8n (synchronisation)`. Cette tâche demande la clé API n8n avec saisie masquée, vérifie le health check puis exécute une requête de validation avec des références de démonstration pour confirmer l'accès Oracle en lecture seule. L'instance n8n locale est attendue sur `http://127.0.0.1:5678`; l'URL API par défaut est `http://127.0.0.1:8088` (adapter si n8n tourne en conteneur). Si le workflow de même nom existe déjà, le script ne le met à jour que s'il reconnaît son webhook SPAT et son appel de validation; il remplace alors sa définition par le flux local (URL corrigée et réponse JSON), conserve l'identité du webhook, publie la version corrigée puis vérifie le webhook de production avec les références de démonstration. Si cette identité n'est pas confirmée, il s'arrête sans modifier le workflow.

Les erreurs d'accès SQL renvoient un JSON `503` avec le code `ORACLE_QUERY_FAILED`; la trace technique reste dans le journal du service et n'est pas exposée au client. Un JSON invalide ou une requête qui ne respecte pas le contrat renvoie un JSON `400`.

## API

`GET /api/v1/health` vérifie que l'application répond. `GET /api/v1/ready` vérifie en plus la connexion Oracle par `SELECT 1 FROM dual`; l'import n8n s'arrête tant que ce contrôle ne renvoie pas `UP`.

`POST /api/v1/factures-fournisseurs/validation` accepte :

```json
{
  "idBonLivraison": "BL...",
  "idBonCommande": "BC...",
  "lignes": [
    { "idLigneLivraison": "BLF...", "quantite": 2, "prixUnitaire": 1500 }
  ]
}
```

La réponse porte `statut` (`VALIDE` ou `A_CORRIGER`) et les écarts par ligne. Une ligne est identifiée dans la vue par `ID`, `NUMBL` et `IDBONDECOMMANDEMERE`. Les champs lus sont le reste à facturer et le prix unitaire. Le prix est comparé exactement : aucune tolérance non approuvée n'est inventée.

## n8n

Le workflow exporté est `n8n/workflows/validation-facture-fournisseur.json`. Il utilise le mode de réponse `responseNode` : le Webhook reçoit le POST, le nœud HTTP appelle l'API, puis `Respond to Webhook` renvoie le résultat. Importer ce fichier dans n8n, configurer l'URL du service via la variable `SPAT_AUTOMATION_API_URL`, puis activer le workflow après validation des identifiants de connexion et du mode d'accès de l'instance.

Lancer `mvn test` dans ce dossier pour exécuter les tests unitaires de règles de validation.

## Postman (tests HTTP locaux)

La spécification, la collection et l'environnement local vivent dans `postman/`. Démarrer l'API avec la configuration Oracle souhaitée, puis exécuter depuis ce dossier :

```powershell
postman spec lint postman/specs/facture-automation-api.yaml --issueType syntax --no-report-events
postman collection lint "postman/collections/SPAT Facture Automation API" --fail-severity warning
postman environment lint postman/environments/Local.environment.yaml --fail-severity warning
postman collection run "postman/collections/SPAT Facture Automation API" -e postman/environments/Local.environment.yaml --no-report-events
```

La requête de validation contient des identifiants `BL-DEMO`/`BC-DEMO`/`BLF-DEMO`. Remplacez-les par des références de préproduction autorisées pour tester une vraie ligne. Sans Oracle activé, le test vérifie seulement que l'API renvoie le `503` explicite prévu ; cela ne valide pas les colonnes de la vue Oracle.

L'initialisation Postman locale est faite. Le CLI a utilisé une session invitée, donc la liaison cloud créée par `postman init` est temporaire ; les fichiers locaux de `postman/` restent dans le dépôt. N'envoyez pas (`postman workspace push`) d'artefacts vers un workspace partagé sans avoir choisi le bon compte/workspace et demandé l'accord de publication.

## API Tiers du WAR SPAT

Le contrat de la route existante `POST /api/tiers` est documenté dans `postman/specs/spaterp-tiers-api.yaml`, avec une collection sous `postman/collections/SPAT Tiers API/`. Cette route crée réellement un tiers dans SPAT. Son jeton Bearer et ses paramètres de recette sont dans l'environnement local ignoré par Git `postman/environments/SPAT Local.environment.yaml`; n'y mettre qu'un jeton de recette et ne pas exécuter la requête sur la production.

La route dépend de `SPATERP_API_TOKEN` et `SPATERP_API_USER` dans l'environnement du processus WildFly. `SPATERP_API_USER` doit correspondre à un `REFUSER` existant, résolu par `MapUtilisateurServiceDirection`; la méthode héritée `ClassMAPTable.createObject` appelle ensuite la restriction `ACT0001` sur `tiers`. Le compte d'audit choisi pour configurer les API est `REFUSER=2100` (`cdev`), actif et de rôle `dg` dans `SPAT_CAPITAINERIE.UTILISATEURROLE`. Avec la règle historique actuelle, l'absence de ligne de restriction est considérée comme autorisée.

La collection contient la requête réelle `Créer un tiers` et deux cas négatifs (`Rejeter NIF invalide`, `Rejeter STAT invalide`). Ces deux derniers attendent le HTTP 400 et le message de format correspondant; ils utilisent un `TYPECLIENT` sentinelle inexistant pour éviter une insertion accidentelle si une validation de format régresse. La collection doit être exécutée uniquement contre une instance de recette configurée, jamais en production. Recherche, lecture, mise à jour et désactivation restent hors contrat tant que leur besoin métier n'est pas confirmé.

**Vérification NIF/STAT :** l'API impose les longueurs numériques (10 chiffres pour le NIF, 17 pour le STAT), rejette les doublons dans `TIERS`, exige une attestation de vérification et reçoit les deux justificatifs comme fichiers multipart. Elle les enregistre sous `dossier.war/travaux` et les rattache au nouvel ID dans `ATTACHER_FICHIER` au sein de la transaction Oracle; les fichiers acceptés sont PDF, JPEG ou PNG jusqu'à 10 Mo chacun. L'API ne vérifie pas directement l'authenticité auprès de la DGI/INSTAT : l'attestation engage l'appelant et l'action est historisée par l'identité SPAT configurée. La permission et la persistance du répertoire doivent être confirmées en recette avant toute création réelle.

Dans Postman, la requête `Créer un tiers` utilise `Body > form-data` avec `payload` (texte JSON), `nifDocument` et `statDocument` (fichiers). Renseignez le jeton et les deux chemins de fichiers dans l'environnement local `SPAT Local`; n'ajoutez pas d'en-tête `Content-Type` manuel, Postman doit générer la frontière multipart. Gardez le jeton dans un gestionnaire local et jamais dans Git ou dans le chat.

Pour n'exécuter que les contrôles négatifs et éviter la requête de création, après démarrage de WildFly et configuration du jeton dans l'environnement local Postman :

```powershell
postman collection run "postman/collections/SPAT Tiers API" `
  -e "postman/environments/SPAT Local.environment.yaml" `
  -i "Rejeter NIF invalide" `
  -i "Rejeter STAT invalide" `
  --no-report-events
```

## API utilisateurs du WAR SPAT

Le contrat est dans `postman/specs/spaterp-utilisateurs-api.yaml`; l’implémentation source est `gallois-war/src/java/mg/api/servlet/ApiUtilisateurServlet.java`. Elle expose `GET /api/utilisateurs/{refuser}`, `POST /api/utilisateurs`, `PUT /api/utilisateurs/{refuser}`, puis les actions `POST /api/utilisateurs/{refuser}/desactiver` et `/reactiver`. La suppression permanente n’est pas exposée, car la méthode historique correspondante retourne toujours `0`.

Cette API privilégiée utilise deux variables WildFly distinctes des identifiants Tiers : `SPATERP_USER_API_TOKEN` et `SPATERP_USER_API_REFUSER`. Le `REFUSER` configuré doit appartenir à un compte actif de rôle `dg`; les changements sont historisés sous cette identité. Ne stocker aucun jeton dans Git ou dans ce document. Le compte de service ne peut ni se désactiver ni se modifier lui-même.

Les routes de création et de modification écrivent dans SPAT. La création exige `loginuser`, `pwduser`, `nomuser` et `idrole`; `codeEtablissement` est facultatif. La modification exige également `pwduser`, car la méthode historique met à jour son chiffrement à chaque modification. Les réponses ne retournent jamais le mot de passe. La route ne doit être déployée et appelée que sur une base de recette approuvée avant tout usage en production.

Au 27 octobre 2026, le WAR contenant les deux classes de cette API a été déployé dans WildFly. Son endpoint a répondu HTTP 503 tant que `SPATERP_USER_API_TOKEN` et `SPATERP_USER_API_REFUSER` n’étaient pas configurées dans le processus serveur. Le déploiement a depuis été vérifié avec un retour HTTP 200 sur `/spat/`. Les opérations utilisateurs ne sont pas encore configurées ni recettées; configurez un compte de service DG dédié et validez les opérations sur une base de recette avant usage.

## Limites opérationnelles

Le schéma et les colonnes de la vue ont été vérifiés avec `SPAT_RO` le 2026-10-16 : propriétaire `SPAT_CAPITAINERIE`, identifiants `ID`, `NUMBL` et `IDBONDECOMMANDEMERE`, reste `QUANTITERESTE`, prix unitaire `PU`. La requête SQL référence donc la vue avec son propriétaire. Le compte Oracle doit être techniquement limité en lecture seule ; `@Transactional(readOnly = true)` ne remplace pas cette restriction.

## API BED

Le contrat est `postman/specs/spaterp-bed-api.yaml`; le servlet est `gallois-war/src/java/mg/api/servlet/ApiBedServlet.java`. `GET` lit les champs principaux. `PUT` modifie `daty`, `anneebudgetaire`, `designation` et le type (`TYPB1` BED ou `TYPB2` État de dépense), uniquement pour un BED à l’état créé et non engagé. Le passage vers TYPB1 contrôle les factures liées et refuse un bon de livraison, une facture déjà visée, une provision ou l’absence de facture. La ligne est verrouillée durant l’édition; `ACT0002` est vérifié sur `FSBBED` et l’historique est écrit sur `BORDEREAUFF`. Tiers, factures/lignes, visa et engagement ne sont pas modifiables par cette route.

Le 28 octobre 2026, le contrat a passé `postman spec lint`, les 18 sources WAR ont compilé avec Ant et le WAR complet a été déployé dans WildFly après sauvegarde du précédent. Le servlet répond actuellement 503 sans configuration. Aucun BED n’a été lu ou modifié.

## Configuration locale des identités WildFly

La tâche VS Code `SPAT : configurer les identités API WildFly (première fois)` demande le REFUSER d’un compte DG actif et trois jetons distincts, masqués. Elle les enregistre dans `automation-api/local/spat-wildfly-api-credentials.xml`, protégé par DPAPI pour le compte Windows courant et exclu de Git. Arrêtez l’instance WildFly déjà ouverte, puis utilisez `SPAT : démarrer WildFly avec API`; cette tâche transmet les variables uniquement au processus WildFly et affiche ses journaux dans le terminal. Elle refuse de démarrer si le port 8080 est déjà occupé.
