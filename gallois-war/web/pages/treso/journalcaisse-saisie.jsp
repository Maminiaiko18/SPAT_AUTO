<%@page import="avoir.AvoirFF"%>
<%@page import="avoir.AvoirFC"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="mg.spat.MvtcaisseOrdonnerpayementFacture"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.placement.Placement"%>
<%@page import="mg.spat.placement.DetailsPlacements"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="utilitaire.Constante" %>
<%@ page import="affichage.PageInsert" %>
<%@ page import="affichage.Liste" %>
<%@page import="mg.spat.FactureAnalyse"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        JournalCaisse pj = new JournalCaisse();

        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        
        FactureAnalyse facture = new FactureAnalyse();
        String idfact = request.getParameter("idFacture");
        

        if (idfact != null) {
            boolean checkFact = idfact.startsWith(Constante.fcPrefix);
            FactureAnalyse temporaire = new FactureAnalyse();
            String v = request.getParameter("vue");
            if (v != null) {
                temporaire.setNomTable(v);
            } else {
                temporaire.setNomTable("ANALYSEGLOBALEFACTURE_ANALYSE");
            }
            if (checkFact) {
                temporaire.setNmfact(idfact);
            }
            else {
                temporaire.setId(idfact);
            }
            
            FactureAnalyse[] liste = (FactureAnalyse[]) CGenUtil.rechercher(temporaire, null, null, null, "");
            if (liste != null && liste.length > 0) {
                facture = liste[0];
            }
            double reste = checkFact ? facture.getReste() : facture.getMontantreste();
            String client = checkFact ? facture.getClient() : facture.getTiers();
            
            pi.getFormu().getChamp("libelle").setDefaut(facture.getDesignation());
            pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr("" + reste));

            pi.getFormu().getChamp("idplacement").setDefaut("" + facture.getNmfact());
            pi.getFormu().getChamp("tiers").setDefaut(client);
            pi.getFormu().getChamp("idplacement").setDefaut(idfact);
            
            
        }
        
        
        
        

        affichage.Liste[] liste = new affichage.Liste[5];

        TypeObjet esc = new TypeObjet();
        esc.setNomTable("CAISSE_LIB");
        liste[0] = new Liste("caisse", esc, "VAL", "id");
        TypeObjet cheque = new TypeObjet();
        cheque.setNomTable("TYPECHEQUE");
        liste[1] = new Liste("idTypeCheque", cheque, "VAL", "id");

        TypeObjet op = new TypeObjet();
        op.setNomTable("DEVISE");
        liste[2] = new Liste("iddevise", op, "desce", "id");

        liste[2].setDefaultSelected("Ar");

        TypeObjet mode = new TypeObjet();
        mode.setNomTable("MODEPAIEMENT");
        liste[3] = new Liste("idmode", mode, "desce", "id");
        
        TypeObjet banq = new TypeObjet();
        banq.setNomTable("BANQUE");
        liste[4] = new Liste("idbanque", banq, "VAL", "id");
        
        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("dateSaisie").setVisible(false);
        pi.getFormu().getChamp("typemvt").setVisible(false);

        pi.getFormu().getChamp("idbanque").setLibelle("Banque");
        pi.getFormu().getChamp("idmode").setLibelle("Mode");
        pi.getFormu().getChamp("dateEffet").setLibelle("Date Effet");
        pi.getFormu().getChamp("numPiece").setLibelle("Numéro pièce");
        pi.getFormu().getChamp("libelle").setLibelle("Libellé");
        
        pi.getFormu().getChamp("debit").setLibelle("Sortie");
        pi.getFormu().getChamp("credit").setLibelle("Entrée");
        pi.getFormu().getChamp("idtypecheque").setLibelle("Type");
        pi.getFormu().getChamp("iddevise").setLibelle("Devise");
        pi.getFormu().getChamp("numcheque").setLibelle("Numero chèque");
        pi.getFormu().getChamp("idordre").setLibelle("Ordre");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("designation").setVisible(false);
        pi.getFormu().getChamp("dateEffet").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("idTypeCheque").setDefaut(Constante.typeCheque);
        
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("idordre").setPageAppel("choix/listeOrdonnerPayementChoix.jsp");
        pi.getFormu().getChamp("idordre").setAutre("readonly");

        pi.getFormu().getChamp("idplacement").setAutre("readonly");
        
        pi.getFormu().getChamp("idplacement").setLibelle("Placement");

        if (request.getParameter("id") != null) {

            if (request.getParameter("id") != null && request.getParameter("id").compareTo("") != 0) {
                pi.getFormu().getChamp("idordre").setDefaut(request.getParameter("id"));
                MvtcaisseOrdonnerpayementFacture ordre = new MvtcaisseOrdonnerpayementFacture(request.getParameter("id"));
                ordre.setNomTable("JOURNALCAISSE_INFO");
                MvtcaisseOrdonnerpayementFacture preremplie = ordre.getOrdre(null);
                pi.getFormu().getChamp("idordre").setValeurLibelle(preremplie.getRemarque());
                pi.getFormu().getChamp("tiers").setValeurLibelle(preremplie.getNomfournisseur());
                pi.getFormu().getChamp("tiers").setDefaut(preremplie.getIdfournisseur());
                pi.getFormu().getChamp("idmode").setDefaut(preremplie.getModepaiement());
                pi.getFormu().getChamp("debit").setDefaut("" + Utilitaire.formaterAr("" + preremplie.getReste()));

            }
            OrdonnerPayement[] ord = (OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, null, " and id = '" + request.getParameter("id") + "'");
            if (ord.length > 0) {
                pi.getFormu().getChamp("designation").setDefaut(ord[0].getRemarque());
                pi.getFormu().getChamp("libelle").setDefaut(ord[0].getRemarque());

                pi.getFormu().getChamp("idordre").setDefaut(ord[0].getId());
                pi.getFormu().getChamp("idordre").setValeurLibelle(ord[0].getRemarque());
                pi.getFormu().getChamp("idmode").setDefaut(ord[0].getModepaiement());
                if (request.getParameter("entree") != null) {
                    pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr("" + ord[0].getMontant()));

                } else {
                    pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr("" + ord[0].getMontant()));
                }
                
                if(ord[0].getDed_Id()!=null && ord[0].getDed_Id().startsWith("AVRFC")){
                    AvoirFC av = new AvoirFC();
                    av = (AvoirFC) av.getById(ord[0].getDed_Id(), null, null);
                    pi.getFormu().getChamp("idplacement").setDefaut(av.getIdfacture());
                }
            }
        }
        if (request.getParameter("idplacement") != null) {
            String idplacement = (String) request.getParameter("idplacement");
            pi.getFormu().getChamp("idplacement").setDefaut(idplacement);
            pi.getFormu().getChamp("idplacement").setValeurLibelle(idplacement);
            Placement placement = new Placement();
            placement.setId(idplacement);
            if (request.getParameter("param") != null && request.getParameter("param").equalsIgnoreCase("sortie")) {
                Placement pl = placement.getPlacement(null);
                pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr("" + pl.getMontant()));
            } else {
                DetailsPlacements dp = placement.getDetailsPlacement(null);
                pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr("" + dp.getMontant_terme()));
            }
        }

        pi.getFormu().getChamp("idplacement").setLibelle("Source");
        
        String idAvoir = request.getParameter("idAvoir");
        if(idAvoir!=null && !idAvoir.isEmpty()){
            AvoirFC avoir = new AvoirFC();
            avoir = (AvoirFC) avoir.getById(idAvoir, "AvoirFC_montant", null);
                if(avoir == null){
                    throw new Exception("Avoir introuvable ou non visé");
                }
            pi.getFormu().getChamp("libelle").setDefaut("Paiement avoir via facture client - " + idAvoir);
            pi.getFormu().getChamp("idplacement").setDefaut(idAvoir);
            pi.getFormu().getChamp("idplacement").setAutre("readonly");
            pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr(avoir.getMontantreste()));
            pi.getFormu().getChamp("tiers").setDefaut(avoir.getTiers());
        }
        String idAvoirFF = request.getParameter("idAvoirFF");
        if(idAvoirFF!=null && !idAvoirFF.isEmpty()){
            AvoirFF avoirFF = new AvoirFF();
            avoirFF = (AvoirFF) avoirFF.getById(idAvoirFF, "AvoirFF_montant", null);
            if(avoirFF == null){
                throw new Exception("Avoir introuvable ou non visé");
            }
            pi.getFormu().getChamp("libelle").setDefaut("Paiement avoir via facture client - " + idAvoir);
            pi.getFormu().getChamp("idplacement").setDefaut(idAvoirFF);
            pi.getFormu().getChamp("idplacement").setAutre("readonly");
            pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr(avoirFF.getMontantreste()));
            pi.getFormu().getChamp("tiers").setDefaut(avoirFF.getTiers());
        }
        /*if(idfact!=null){
            pi.getFormu().getChamp("idplacement").setDefaut(null);
        }*/
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
%>
<div class="content-wrapper">
    <h1>Saisie d'un journal caisse</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="treso/recette-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.allosakafo.fin.MvtCaisse">
        <!--<input name="nomtable" type="hidden" id="nomtable" value="journalcaisse">-->
    </form>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
    history.back();
</script>

<% }%>