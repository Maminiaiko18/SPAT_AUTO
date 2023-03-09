
ALTER TABLE client_tp ADD CONSTRAINT client_tp_cdclt_U unique(cdclt);

ALTER TABLE client_quit ADD CONSTRAINT client_quit_cdclt_U unique(cdclt);

