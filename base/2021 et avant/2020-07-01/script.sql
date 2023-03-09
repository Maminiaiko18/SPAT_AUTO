drop view RECAP_CAISSE;
CREATE OR REPLACE FORCE VIEW RECAP_CAISSE AS 
  select
        jc.dateeffet as daty,
        case
            when cb.id is null then cp.desce
            else cb.desce
        end as libelle,
        jc.numpiece as numero_compte,
		cast(jc.credit - jc.debit as number(20,2)) as montant
    from journalcaisse jc
        left join CAISSE_BANQUE cb on cb.id = jc.caisse
        left join CAISSE_PHYSIQUE cp on cp.id = jc.caisse;
 
 
	drop view POSTEDESTINATAIRELIBCOMPLET;
	CREATE OR REPLACE FORCE VIEW POSTEDESTINATAIRELIBCOMPLET  AS 
	 select
		   p.id,
		   p.quai,
		   case when interne = 1 then 'National' else 'International' end as interne,
		   q.val as valquais,
		   q.DESCE as descequais,
		   q.TYPEQUAIS,
		   q.PROFONDEUR,
		   q.LONGUEUR,
		   q.TIRANT,
		   q.PAYS as paysquais,
		   p1.val as valpays,
		   p1.DESCE as descepays,
		   tq.val as valtypequais,
		   tq.DESCE as descetypequais

	from POSTEDESTINATAIRE p
			 left join quais q on q.id = p.QUAI
			 left join pays p1 on p1.id = q.PAYS
			 left join TYPEQUAIS tq on tq.ID=q.TYPEQUAIS;
 
