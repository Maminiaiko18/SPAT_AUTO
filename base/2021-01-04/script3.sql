alter table ordonnerpayement add destination varchar(150);
alter table ordonnerpayement add modepaiement  varchar(150);
alter table ordonnerpayement add foreign key (modepaiement) references modepaiement(id);