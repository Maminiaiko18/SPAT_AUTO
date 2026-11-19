# Note de livraison SPAT

## Objet de cette branche

La branche `livraison` rassemble les contrôles d’automatisation intégrés à SPAT et les contrôles métier du BED. Les contrôles n8n sont appelés après l’enregistrement et affichent un résultat sur la fiche concernée; ils informent l’utilisateur sans bloquer ni annuler l’enregistrement.

## Fonctionnalités incluses

- Validation de propositions de factures fournisseurs par l’API Spring Boot, en lecture seule sur Oracle : quantités, reste à facturer et prix unitaires.
- Contrôles n8n intégrés aux parcours du site SPAT pour les factures, les tiers, les utilisateurs, les DASE et les BED.
- API de gestion des utilisateurs et API SPAT pour les tiers, les DASE et les BED.
- Historique Oracle des réponses API en erreur et workflow n8n de rapport quotidien XML prévu à 17 h, heure `Indian/Antananarivo`.

## Environnement et sécurité

- Oracle 21c XE de recette : service `XEPDB1`, schéma applicatif `SPAT_CAPITAINERIE`.
- WildFly 10 héberge le WAR SPAT; l’API Spring Boot est un service séparé et n8n tourne localement.
- Les secrets et fichiers locaux DPAPI ne doivent pas être publiés dans Git. Le compte de lecture du rapport et le compte d’écriture du journal ont des usages distincts.
- Les essais métier sont effectués sur la base de test confirmée par l’encadreur.

## État de recette connu

- Le WAR a été compilé depuis `livraison`, déployé dans WildFly avec conservation d’une sauvegarde de l’ancien déploiement, puis vérifié avec HTTP 200 sur `/spat/`.
- Le WAR déployé contient les services n8n facture, tiers, utilisateurs, BED et DASE.
- Le contrôle BED de l’API Spring Boot a répondu `VALIDE` lors de la vérification locale.
- L’utilisateur a confirmé les essais sur le site pour la facture, les tiers, les utilisateurs et la DASE. La recette de bout en bout du bandeau BED sur le site reste à confirmer.
- L’utilisateur a confirmé que le workflow quotidien d’erreurs envoie le rapport XML testé. Son état d’activation automatique doit être vérifié directement dans n8n.

## Limites

- La plupart des contrôles utilisateurs, DASE et BED portent surtout sur le format; les contrôles métier sont plus poussés pour la facture, les doublons de tiers et la cohérence du BED.
- Les contrôles intégrés au site interviennent après l’enregistrement. Ils signalent le résultat sans empêcher l’opération.
- Le rapport quotidien ne contient que les erreurs présentes dans la source Oracle du journal; il n’annule pas les écritures métier et ne remplace pas les journaux applicatifs.

## Points restant à confirmer

- Terminer le test du bandeau BED dans le site avec une facture de la base de recette non encore rattachée à un BED.
- Confirmer dans n8n que le workflow quotidien est activé et que le destinataire final est correct.
- Contrôler les grants Oracle et les sauvegardes selon la procédure DBA du dépôt avant toute utilisation hors recette.
