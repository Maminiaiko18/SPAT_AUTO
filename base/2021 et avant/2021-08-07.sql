alter table facture_client_fille add test number(10,2);
update facture_client_fille set test=quantite;
update facture_client_fille set quantite=null;
alter table facture_client_fille modify quantite number(10,3);
update facture_client_fille set quantite=test;
