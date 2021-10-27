create view etatcaisseBP as
select cast(sum(debit) as NUMBER(30, 3)) as montant,idcategorie
from journalcaisse j
    join facture_fournisseur_mere ff on ff.id=j.IDPLACEMENT
where idcategorie ='CATGFF002' and ff.ETAT=11 and j.ETAT=11
    group by idcategorie;