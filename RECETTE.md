
## DASE - workflow n8n (mode controle) - 2026-11-03
- Sans jeton : 403 (attendu 403) OK
- Faux jeton : 403 (attendu 403) OK
- Demande valide : 200, valide=true, ecrit=false (attendu) OK
- Quantite a 0 : 400 avec erreur sur lignes[0].qte (attendu) OK
- Mode creation : NON TESTE (base de test non confirmee)

## DASE - API SPAT directe - 2026-11-03
- GET /api/demandes-achat/ID sans jeton : 401 (attendu 401) OK
- GET /api/demandes-achat/ID avec faux jeton : 401 (attendu 401) OK
- GET /api/demandes-achat sans identifiant : 400 (remarque : refus avant controle du jeton, sans fuite de donnees)
- Lecture avec le vrai jeton : NON TESTEE
- Creation (POST) : NON TESTEE (base de test non confirmee)

## Utilisateurs - lecture seule - 2026-11-03
- Sans jeton : 401 (attendu 401) OK
- Faux jeton : 401 (attendu 401) OK
- Bon jeton, compte inexistant : 404 (attendu 404) OK
- Reference non numerique : 400 (attendu 400) OK
- Ecritures (creation, modification, desactivation, reactivation) : NON TESTEES (base de test non confirmee)

## Environnement de test - 2026-11-03
- Base Oracle locale (service XEPDB1, schema SPAT_CAPITAINERIE), meme machine pour WildFly et automation-api
- Base confirmee comme base de test par l'encadreur : ecritures autorisees
- Donnees de test marquees TEST-RECETTE-2026-11-03

## Confidentialite par etablissement (analyse du code)
- Prioritaire.makeListConfidentiality filtre les listes par prefixe du code etablissement de l'utilisateur connecte (regles PRIORITAIRE, ETAT=11, par utilisateur ou role).
- L'API DASE ne reproduit pas ce controle : elle peut creer une DASE sur un etablissement que l'utilisateur de service ne verrait pas dans l'interface.
- Amelioration possible : verifier le droit de l'utilisateur de service sur l'etablissement demande avant l'ecriture. Non realisee avant la cloture.

## Utilisateurs - creation - 2026-11-04
- Creation du compte test.recette (role redacteur, etablissement CODE000021) : 201 Created, refuser 2520, etat ACTIF.
- Donnee de test conservee (pas de route de suppression).
