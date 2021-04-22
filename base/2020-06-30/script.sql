create or replace view MVTLIBCOMPLETANALYSEUNIONDATE as
select m.*,date_depart-datearrivee as difference from MVTLIBCOMPLETANALYSEUNION1 m;