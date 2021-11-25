 
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.Caisse"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="affichage.PageInsert" %>
<%@ page import="affichage.Liste" %>
<%@page import="mg.spat.FactureAnalyse"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        JournalCaisse pj = new JournalCaisse();
        
        FactureAnalyse facture = new FactureAnalyse();
        if(request.getParameter("idFacture") != null){
            FactureAnalyse temporaire = new FactureAnalyse();
            temporaire.setNomTable("ANALYSEGLOBALEFACTURE_ANALYSE");
            String v= request.getParameter("vue");
            if (v!=null)  temporaire.setNomTable(v);
            if(temporaire.getNomTable().compareTo("ANALYSEGLOBALEANTSIKA")==0){
                temporaire.setId(request.getParameter("idFacture"));
            }
            temporaire.setNmfact(request.getParameter("idFacture"));
            
            
            FactureAnalyse[] liste = (FactureAnalyse[]) CGenUtil.rechercher(temporaire, null, null, null, "");
            if(liste != null && liste.length >0){
                facture = liste[0];
            }
        }
        
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));

        pi.getFormu().getChamp("idTypeCheque").setVisible(false);
        pi.getFormu().getChamp("numpiece").setVisible(false);
        pi.getFormu().getChamp("tiers").setDefaut(facture.getClient());
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeClientChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("designation").setDefaut(facture.getDesignation());
        pi.getFormu().getChamp("datesaisie").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("datesaisie").setVisible(false);
        pi.getFormu().getChamp("dateeffet").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("numcheque").setLibelle("Numero du cheque"); 
        if(facture.getNomTable().compareTo("ANALYSEGLOBALEANTSIKA")==0){
            pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr(""+facture.getMontantreste()));
            pi.getFormu().getChamp("idplacement").setDefaut(""+facture.getId());
        }else{
            pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr(""+facture.getReste()));
            pi.getFormu().getChamp("idplacement").setDefaut(""+facture.getNmfact());
        }
        
        pi.getFormu().getChamp("idplacement").setAutre("readonly");
        pi.getFormu().getChamp("idplacement").setLibelle("Source");
        pi.getFormu().getChamp("credit").setLibelle("Montant du chèque");
        
        pi.getFormu().getChamp("debit").setVisible(false);
        pi.getFormu().getChamp("remarque").setDefaut(" ");
        // pi.getFormu().getChamp("tiers").setLibelle("Client émetteur");
        pi.getFormu().getChamp("idordre").setVisible(false);
        pi.getFormu().getChamp("tiers").setLibelle("Client emetteur");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("dateeffet").setLibelle("Date effet");
        pi.getFormu().getChamp("typemvt").setVisible(false);
        

        affichage.Champ[] liste = new affichage.Champ[3];
        Caisse esc = new Caisse();
        esc.setNomTable("caisse_banque");
        liste[0] = new Liste("caisse", esc, "VAL", "id");

        TypeObjet op = new TypeObjet();
        op.setNomTable("DEVISE");
        liste[1] = new Liste("iddevise", op, "desce", "id");
        TypeObjet mode = new TypeObjet();
        mode.setNomTable("modepaiement");
        liste[2] = new Liste("idmode", mode, "desce", "id");

        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("caisse").setLibelle("Banque");
        pi.getFormu().getChamp("iddevise").setLibelle("Devise");
        pi.getFormu().getChamp("iddevise").setDefaut("Ar");
        pi.getFormu().getChamp("idmode").setLibelle("mode de paiement");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'une recette</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert"> 
        <input name="bute" type="hidden" id="bute" value="treso/journalcaisse-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.JournalCaisse">
    </form>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>