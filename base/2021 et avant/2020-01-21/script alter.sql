alter table conge add etat number(10);
alter table permission add etat number(10);


alter table permission drop constraint FK_PERSPERMISSION;