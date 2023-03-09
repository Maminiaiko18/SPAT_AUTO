


--creer
CREATE VIEW ETATORDONNERPAYEMENT_creer as
SELECT * FROM ETATORDONNERPAYEMENT    WHERE etat = 1; 
--N_PAY
CREATE VIEW ETATORDONNERPAYEMENT_N_PAY as
SELECT * FROM ETATORDONNERPAYEMENT op
 WHERE     op.id NOT IN (SELECT jc.IDORDRE
                              FROM journalcaisse jc
                             WHERE jc.IDORDRE = op.id)
          AND op.ETAT >= 11;
--paye_lib
CREATE VIEW ETATORDONNERPAYEMENT_paye_lib as   
SELECT op.* FROM ETATORDONNERPAYEMENT op
         JOIN journalcaisse jc ON jc.IDORDRE = op.id
    WHERE jc.ETAT >= 11 AND op.ETAT >= 11;
    
--annule

CREATE VIEW ETATORDONNERPAYEMENT_annule as   
SELECT * FROM ETATORDONNERPAYEMENT op
    WHERE etat = 0;

