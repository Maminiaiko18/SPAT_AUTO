# Plan de fin des automatisations SPAT

**Échéance visée : lundi 9 novembre 2026**  
**Point de reprise : lundi 26 octobre 2026**  
**État au 28 octobre 2026 : WildFly, l’API Oracle et n8n répondent HTTP 200. `/api/v1/ready` confirme Oracle `SPAT_RO`. Le webhook n8n a réussi un cas réel (`VALIDE`) puis rejeté un prix erroné (`A_CORRIGER`), sans écriture métier. Les routes Tiers, utilisateurs et BED renvoient 401 sans jeton, ce qui confirme que leurs identités API sont chargées.**

## Où nous en sommes

| Objectif | Déjà présent dans le dépôt | État opérationnel constaté | Travail restant |
|---|---|---|---|
| Gestion utilisateurs | Rôles et formulaires historiques présents; `ApiUtilisateurServlet` ajoute lecture par référence, création, modification, désactivation et réactivation. Le code exige un compte de service `dg` actif, un jeton dédié et délègue chiffrement/historique au service EJB. La désactivation/réactivation conserve les règles historiques; aucune suppression permanente n’est exposée. | Le 28 octobre, GET sans jeton renvoie 401; aucun compte n’a été modifié. `HistoriqueBean.deleteUtilisateurs` reste un stub à `0`. | Tester avec le jeton utilisateur dans l’environnement local Postman; valider lecture et opérations d’écriture uniquement en recette, avec approbation métier. |
| Factures fournisseurs | Les entrées `Finances > Facture fournisseur > Saisie` et `Saisie N`, ainsi que `Facturer` depuis une fiche BL, utilisent les classes reconnues par le déclencheur n8n; la validation en lecture seule compare quantité restante et prix unitaire, puis s’affiche sur la fiche. | Essais webhook directs réussis (`VALIDE` / `A_CORRIGER`). WildFly redémarré avec URL webhook; API, n8n et SPAT répondent. Le résultat après insertion n’a pas encore été observé dans l’UI. Certaines listes BL/BC exposent encore un ancien lien vers `facture-fournisseur-saisie-multiple.jsp`, dont les classes ne sont pas reconnues par le déclencheur n8n. | Tester le parcours standard depuis la fiche BL; puis auditer l’ancien formulaire avant de promettre l’automatisation sur toutes les voies de saisie. Le webhook ne vise ni visa ni paiement. |
| BED / bordereau | `ApiBedServlet` expose lecture et modification de la date, l’année budgétaire, la désignation et le type (`TYPB1`/`TYPB2`). Un passage vers TYPB1 vérifie les BL, factures déjà visées et provisions; la route vérifie ACT0002 sur `FSBBED`, verrouille les brouillons non engagés et historise sur `BORDEREAUFF`. Tiers, factures/lignes, visa et engagement restent exclus. | Contrat linté; Ant compile 18 sources WAR; WAR redéployé le 28 octobre. GET sans jeton renvoie maintenant 401. Aucun BED n’a été lu ni modifié. | Tester les refus d’authentification et recetter les transitions sur des brouillons approuvés, sans déclencher visa ou engagement. |
| Tiers | `POST /api/tiers` valide le type, le format et les doublons; exige une attestation et deux fichiers multipart (NIF/STAT), les écrit sous `dossier.war/travaux` et les rattache au tiers dans la transaction Oracle via `ATTACHER_FICHIER`. | Déployé le 28 octobre avec sauvegarde et hash vérifié. POST sans jeton renvoie maintenant 401. Identité d’audit : `REFUSER=2100` (`cdev`), active et rôle `dg`. Aucun tiers n’a été créé. | Tester les formats invalides et la recette upload/transaction avec documents approuvés; l’attestation ne remplace pas une vérification humaine DGI/INSTAT. |

## Plan daté

### 26–27 octobre — cadrage et accès

- Confirmer les opérations attendues pour les utilisateurs, les tiers et les factures fournisseurs.
- BED confirmé par l’utilisateur. Confirmer si le type peut changer entre `TYPB1` (BED) et `TYPB2` (État de dépense), et quels champs enfants sont modifiables. Le visa et l’engagement sont des opérations financières distinctes.
- Obtenir l’URL JDBC depuis SQL Developer/SQL*Plus. Le mot de passe reste saisi dans le terminal masqué.
- Ouvrir l’instance n8n, générer une clé API et l’utiliser uniquement dans l’invite masquée.
- Confirmer l’environnement de recette et quelques identifiants métier de test non sensibles.

### 28–30 octobre — configuration et première recette

- Configurer les identités API sur WildFly via la tâche VS Code, après avoir identifié un compte DG actif; vérifier 401 sans jeton, 403 pour un profil non autorisé et 503 seulement si la configuration manque.
- Faire les cas négatifs sans écriture pour utilisateurs et Tiers, puis confirmer les entrées d’audit et les habilitations sur une base de recette.
- Recetter le webhook fournisseur avec une référence autorisée; garder ce parcours en lecture seule.
- Confirmer les champs BED supplémentaires éventuels (type et lignes) avant d’étendre le PUT déjà limité aux champs de base.

### 2–4 novembre — extensions et recette intégrée

- Étendre le périmètre Tiers seulement si la consultation, la mise à jour ou la désactivation sont explicitement nécessaires.
- Implémenter la réception API des pièces NIF/STAT et leur rattachement `ATTACHER_FICHIER.MERE` après génération de l’ID tiers; enregistrer l’attestation et l’identité du vérificateur dans une trace durable. Vérifier en recette le répertoire `dossier.war`, les permissions, types et limites de taille avant toute création réelle. Aucun service de vérification DGI/INSTAT n’a été identifié dans le dépôt.
- Étendre l’API BED aux transitions de type ou aux lignes uniquement après confirmation et avec validations métier spécifiques.
- Finaliser la recette des opérations utilisateurs avec un compte DG actif et vérifier les journaux/habilitations.
- Mettre à jour les contrats, exemples Postman et consignes VS Code pour chaque extension retenue.

### 5–6 novembre — recette et corrections

- Vérifier les réponses API, les cas invalides, les droits et l’absence de doublons.
- Faire une recette métier sur base de préproduction avec références approuvées; vérifier les changements d’état avec l’équipe métier.
- Corriger les écarts bloquants et vérifier le rollback du déploiement.

### 9 novembre — livraison

- Déployer les versions validées dans l’environnement convenu.
- Vérifier health checks, webhooks n8n, parcours SPAT et journaux sans exposer de secrets.
- Livrer les contrats, exemples, procédures de démarrage/arrêt et état des éventuelles limites restantes.

## Conditions de réussite

- Les paramètres manquants de périmètre (actions utilisateur, étendue tiers, type/champs BED) doivent être confirmés au plus tard le 27 octobre; l’échéance est déjà dépassée, ce qui met en risque la réalisation des écritures et la recette avant le 9 novembre.
- L’URL JDBC Oracle et l’accès administrateur/API n8n sont saisis localement; aucune valeur secrète n’est copiée dans Git ou le chat.
- Les opérations qui modifient les données SPAT sont testées en préproduction avant toute mise en production.
- Les règles de visa et les droits restent ceux du métier; aucune transition ou permission n’est inventée.

## Décisions à confirmer pour tenir l’échéance

1. **Utilisateurs :** le code existant confirme création, modification, désactivation et réactivation; la suppression est inachevée. Il reste à décider lesquelles de ces opérations seront exposées à l’automatisation et quels profils/identités pourront les appeler.
2. **Factures fournisseurs et tiers :** l’objectif facture est-il le contrôle après saisie déjà codé, ou aussi la création/modification automatisée? Pour les tiers, faut-il compléter la création avec consultation, recherche, mise à jour ou désactivation?
3. **BED :** peut-on modifier le type (`TYPB1` ou `TYPB2`), et quels champs du parent/lignes sont modifiables par quels rôles?

La date cible de cadrage du 27 octobre est dépassée; toute décision manquante met maintenant en risque la livraison du 9 novembre, surtout pour les écritures BED et la gestion des comptes utilisateurs.

## Vérifications techniques effectuées le 26 octobre

- `mvn -DskipTests package` : `BUILD SUCCESS` avec Java 21.
- `mvn test` : 3 tests, 0 échec, 0 erreur, 0 ignoré; couvre seulement `InvoiceValidationService`.
- Vérification finale après démarrage : `GET /healthz` n8n = 200; `GET /rest/workflows` et `GET /api/v1/workflows` = 401 sans authentification. L’API 8088 et SPAT 8080 = injoignables. Une seconde instance n8n démarrée par erreur a été arrêtée; le processus n8n d’origine est conservé.
- Aucune recette Oracle, aucune activation n8n et aucun test d’écriture SPAT effectués.

## Reprise opérationnelle du 26 octobre 2026

- `http://127.0.0.1:8080/spat/` répond HTTP 200 et `http://127.0.0.1:5678/healthz` répond HTTP 200. `http://127.0.0.1:8088/api/v1/health` refuse la connexion : lancer la tâche VS Code `SPAT : démarrer API (Oracle)` pour saisir les paramètres localement et démarrer ce service.
- Les variables Oracle ne sont pas définies au niveau utilisateur ou machine Windows; le script demande les identifiants à chaque démarrage et ne persiste pas le mot de passe. La clé n8n est également demandée de façon masquée par le script d’import.
- Aucun workflow n8n n’a été importé/activé ni aucune création de tiers exécutée pendant cette reprise.
- Le CLI Postman a indiqué que ses skills étaient obsolètes; `postman skills update` a été exécuté depuis `automation-api/` conformément au guide du dépôt.

## Reprise opérationnelle du 27 octobre 2026

- L’API tiers a été compilée par Ant, assemblée avec les 86 JAR runtime de l’ancienne application et le JAR `gallois-ejb.jar`, puis déployée dans WildFly. Le script a confirmé le marqueur de déploiement et HTTP 200 sur `/spat/`; l’ancien WAR est conservé dans `C:\wildfy-officiel\wildfly-10.0.0.Final\standalone\codex-deploy-backups\spat.war-20261026-154749`.
- Le WAR actif contient le code compilé avec les contrôles NIF/STAT. Un appel sans authentification à `POST /spat/api/tiers` renvoie HTTP 503 `{"error":"API non configuree sur le serveur"}` avant d’atteindre la validation des données : l’API n’est pas encore configurée et aucun accès Oracle/écriture n’a eu lieu.
- Le code exige les variables de processus WildFly `SPATERP_API_TOKEN` et `SPATERP_API_USER`. La seconde doit correspondre à un `REFUSER` que `MapUtilisateurServiceDirection` résout dans `utilisateurrole`, puis le contrôle hérité applique `ACT0001` à `tiers`. Aucun secret ne doit être écrit dans Git ni communiqué dans le chat. Après configuration, le contrôle sans jeton doit donner 401; le test d’un NIF mal formé avec jeton doit donner 400 avant l’accès au DAO.
- Le script `scripts/deploy-spat-wildfly.ps1` a été adapté au déploiement actuel sous forme d’archive WAR, avec sauvegarde/retour arrière, et pointe maintenant vers `gallois-war/dist/gallois-war-ready.war`.
- Contrôle de disponibilité refait le 27 octobre : `8080/spat/`, `8088/api/v1/health` et `5678/healthz` sont injoignables. Redémarrer les processus appropriés avant la recette, puis vérifier leurs health checks au même moment que les tests API.
- Routes observées dans les sources actuelles : création tiers `POST /api/tiers`; API facture client et import Excel; API de validation fournisseurs `POST /api/v1/factures-fournisseurs/validation`. Aucune route utilisateur ou bordereau n’a été trouvée dans l’inventaire actuel.
- Priorité restante avant recette : configurer l’identité API Tiers dans le processus WildFly avec un `REFUSER` existant et autorisé; confirmer une référence fournisseur réelle de préproduction pour valider le workflow n8n; arrêter le périmètre opérationnel utilisateur (lecture/création/modification de rôles/désactivation) et BED (type, champs, transitions, rôles).

## Build local de l’API utilisateurs — 27 octobre 2026

- La compilation Ant complète a réussi avec l’exécutable Ant inclus dans NetBeans 17 et le fichier temporaire `automation-api/target/spat-user-api-build.properties` (`BUILD SUCCESSFUL`). Elle a compilé la dépendance EJB et les 16 sources WAR.
- L’assemblage Ant `dist` a réussi. `gallois-war/dist/gallois-war.war` fait 37 121 119 octets et contient `mg/port/api/servlet/ApiUtilisateurServlet.class` et `mg/port/api/model/UtilisateurApiRequest.class`.
- Aucune mise à jour du WAR actif, aucun redémarrage WildFly et aucune écriture SPAT n’ont été effectués pendant cette étape. Le service doit encore être configuré avec son jeton dédié et un compte `dg` actif, puis déployé/recetté en préproduction.
- La synchronisation n8n facture fournisseur reste active et vérifiée par le webhook selon le retour du 27 octobre; il reste à la tester sur une référence métier réelle autorisée.

## Jalons révisés jusqu’au 9 novembre 2026

- **27 octobre** : configurer l’API Tiers localement, faire les tests non écrivants NIF/STAT; revalider les processus API 8088 et n8n 5678; enregistrer les décisions de périmètre utilisateur/BED.
- **28–30 octobre** : recette intégrée facture fournisseur avec références autorisées de préproduction; corriger les anomalies; finaliser le contrat tiers et les droits de service.
- **2–4 novembre** : implémenter les opérations utilisateurs et bordereaux après cadrage explicite; préserver les contrôles SPAT existants et journaliser les écritures.
- **5–6 novembre** : tests de contrat et de droits; recette des écritures uniquement sur préproduction, avec rollback et références approuvées.
- **9 novembre** : déploiement de livraison, vérification des quatre parcours et remise des procédures/configuration.

Le chemin critique est maintenant l’accès local aux variables WildFly et aux identifiants de recette, puis les décisions de droits/transitions. Tant que les décisions BED/utilisateurs ne sont pas confirmées, aucune permission ou transition financière ne doit être inventée.

## Reprise après rétablissement de l’API — 27 octobre 2026

- Contrôle direct effectué : `GET http://127.0.0.1:8088/api/v1/ready` = HTTP 200, `status=UP`, Oracle `SPAT_RO` joignable, `oracleCode=OK`.
- Contrôle direct effectué : `GET http://127.0.0.1:5678/healthz` = HTTP 200 et `GET http://127.0.0.1:8080/spat/` = HTTP 200.
- L’échec précédent était lié à l’API/Oracle indisponible au moment de la tentative; le script d’import avait arrêté avant toute modification du workflow.
- Prochaine action immédiate : lancer `scripts/import-n8n-workflow.ps1` dans le terminal intégré de VS Code; saisir la clé n8n dans son invite masquée; confirmer que le workflow existant est synchronisé/actif et que le webhook répond.
- À la suite de cette vérification, reprendre le développement des routes utilisateurs et BED; l’identité API Tiers et ses vérifications d’écriture restent à configurer/recetter.
- Nouvelle tentative : Oracle a répondu à la sonde (résultat de contrôle `A_CORRIGER`), mais l’énumération n8n `GET /api/v1/workflows?limit=250` a expiré après 10 s avant toute modification. Le script a été corrigé pour paginer 20 workflows par requête, attendre jusqu’à 30 s par page et arrêter proprement si n8n ne répond pas. Syntaxe PowerShell vérifiée; n8n et l’API/Oracle répondent toujours HTTP 200. Relancer la tâche VS Code de synchronisation.
- Résultat de la relance : l’inventaire a trouvé 3 workflows, le workflow SPAT existant a été synchronisé et activé, et son webhook de production a répondu `A_CORRIGER` à la sonde fictive. La brique technique facture/n8n est intégrée; la recette métier réelle reste à faire.

## Déploiement WildFly et état du 28 octobre 2026

- Le 27 octobre, le WAR contenant l’API utilisateurs a été déployé avec succès dans `C:\wildfy-officiel\wildfly-10.0.0.Final`. L’ancienne archive est sauvegardée dans `standalone\codex-deploy-backups\spat.war-20261027-162519`; `/spat/` répondait HTTP 200.
- La route `GET /spat/api/utilisateurs/1` a répondu HTTP 503 avec `API utilisateurs non configurée sur le serveur`. Les variables `SPATERP_USER_API_TOKEN` et `SPATERP_USER_API_REFUSER` restent à configurer dans le processus WildFly. Aucune donnée n’a été lue ni modifiée par cette requête.
- Le premier assemblage du nouveau WAR a échoué au déploiement; le mécanisme a restauré la version précédente et SPAT est revenu à HTTP 200. Le journal identifiait l’absence de `bean/ClassMAPTable` dans le classpath déployé.
- Le script de build a été corrigé pour reconstruire l’EJB, extraire les bibliothèques du WAR déployé (archive ou dossier), fournir ces bibliothèques à la compilation WAR et créer les entrées ZIP avec des séparateurs `/`. Le build final a validé les 86 bibliothèques runtime et la présence de `bean/ClassMAPTable.class`; le déploiement suivant a réussi et `/spat/` a répondu HTTP 200.
- Au contrôle du 28 octobre, les ports locaux 8080 (WildFly), 8088 (API Oracle) et 5678 (n8n) ne répondaient pas. Aucun processus n’a été démarré pendant ce contrôle.
- Restent à faire : redémarrer les services, configurer les variables dédiées API utilisateurs et tiers, faire la recette facture sur une vraie référence autorisée, puis préciser les règles BED non établies (transition de type, champs enfants et rôles). Aucune écriture SPAT de recette n’a été exécutée dans cette reprise.

## Mise à jour opérationnelle après reprise — 28 octobre 2026

- Un contrôle ultérieur le même jour confirme que WildFly/SPAT `8080/spat/`, l’API Oracle `8088/api/v1/ready` et n8n `5678/healthz` répondent HTTP 200. Le workflow facture fournisseur reste actif selon la dernière synchronisation; sa sonde fictive a répondu `A_CORRIGER`.
- `ApiBedServlet` a été ajouté, compilé dans le WAR complet avec 86 JAR runtime, vérifié par lint OpenAPI puis déployé. Une sauvegarde du WAR précédent se trouve sous `C:\wildfy-officiel\wildfly-10.0.0.Final\standalone\codex-deploy-backups\spat.war-20261028-104627`.
- Les routes Tiers, utilisateurs et BED renvoient HTTP 503 sans leurs variables WildFly. Aucun compte, tiers ou BED n’a été modifié.
- Les tâches VS Code `SPAT : configurer les identités API WildFly (première fois)` et `SPAT : démarrer WildFly avec API` sont prêtes. La configuration locale demande un REFUSER DG actif et trois jetons distincts masqués; DPAPI protège le fichier pour le compte Windows courant et `.gitignore` exclut `automation-api/local/`.
- Pour obtenir un REFUSER DG actif depuis SQL*Plus connecté à SPAT :

  ```sql
  SELECT REFUSER, LOGINUSER, NOMUSER, IDROLE
  FROM UTILISATEURROLE
  WHERE LOWER(IDROLE) = 'dg'
  ORDER BY REFUSER;
  ```

  `UTILISATEURROLE` exclut déjà les comptes désactivés. Après configuration, arrêter WildFly dans son terminal actuel et lancer la tâche VS Code qui le redémarre avec les identités.
