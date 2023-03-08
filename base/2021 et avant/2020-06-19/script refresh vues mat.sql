
  
  CREATE OR REPLACE TRIGGER refreshclientmat
  after insert or update or delete ON dbspat.client
declare
       l_job number;
    begin
       dbms_job.submit( l_job, 'dbms_mview.refresh( "clientmat" );' );
  end;
  

    CREATE OR REPLACE TRIGGER refreshclientmat2
  after insert or update or delete ON userspat.client
declare
       l_job number;
    begin
       dbms_job.submit( l_job, 'dbms_mview.refresh( "clientmat" );' );
  end;
  
  
    CREATE OR REPLACE TRIGGER refreshclientmat3
  after insert or update or delete ON userspat.client
declare
       l_job number;
    begin
       dbms_job.submit( l_job, 'dbms_mview.refresh( "consignatairemat" );' );
  end;
  
      CREATE OR REPLACE TRIGGER refreshclientmat4
  after insert or update or delete ON dbspat.client
declare
       l_job number;
    begin
       dbms_job.submit( l_job, 'dbms_mview.refresh( "consignatairemat" );' );
  end;