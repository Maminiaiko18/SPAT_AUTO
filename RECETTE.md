
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

- PUT /api/utilisateurs/2520 (sans codeEtablissement, avec teluser) : 500 'La modification du compte a echoue'. Log serveur : exception LOGIN DEJA UTILISE dans HistoriqueBean.updateUtilisateurs (ligne 267) alors que le login est inchange. Transaction annulee. Cause a analyser (regression possible de la correction de l'injection SQL).
- Limite : le 500 generique masque une erreur metier (login deja utilise) qui devrait etre un 409.

- Analyse : le diff de la correction SQL (commit 50b4e350) conserve la logique d'origine. Hypothese revisee : l'appel de updateUtilisateurs dans ApiUtilisateurServlet.doPut passe peut-etre un mauvais argument (iduser/refUser). A verifier.

- PUT /api/utilisateurs/2520 apres correction (HistoriqueBean ligne 255, iduser au lieu de refUser) : 200 MODIFIE. Vue UTILISATEURROLE : 1 ligne pour test.recette. Connexion dans le site : encore refusee, cause en cours d'analyse (traitement du mot de passe ?).

## Cause confirmee du refus de connexion (test.recette)
- La connexion lit la vue UTILISATEURVUE (jointure utilisateur.ADRUSER = direction.IDDIR). ADRUSER etait vide : 0 ligne dans la vue, d'ou l'exception testeValide (tableau vide, message '0').
- Defaut API : la creation n'impose pas adruser, et le PUT reecrit toute la ligne avec les champs absents a vide (adruser, codeetablissement effaces).
- Correctifs possibles : rendre adruser obligatoire (ou le valider contre DIRECTION) a la creation, et faire que le PUT ne modifie que les champs fournis.

- Reparation par SQL du compte de test 2520 (base de test confirmee par l'encadreur) : adruser = DIR00002 et codeetablissement = CODE000021 (valeurs du compte cdev), pour compenser le defaut de l'API (champs ecrases par le PUT, adruser absent a la creation).
- Resultat connexion test.recette apres reparation : (ok/echec).

## Utilisateurs - connexion validee - 2026-11-04
- Connexion de test.recette (role redacteur) reussie apres reparation de adruser et codeetablissement.
- Menus visibles : uniquement le module Capitainerie. Le compte cdev (role admin/dg) voit tous les modules : les droits dependent bien du role attribue a la creation.
- Constat : l'API cree un compte exploitable seulement si teluser et adruser sont renseignes (valides dans LOG_PERSONNEL et DIRECTION), et le PUT ecrase les champs absents.
