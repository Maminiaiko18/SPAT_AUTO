
<%@page import="mg.spat.Chantier"%>
<%@page import="mg.spat.Contrat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        Contrat c = new Contrat();
        c.setNomTable("CONTRATSAISIE");
        PageInsert pi = new PageInsert(c, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        String classe = "mg.spat.Contrat";
        String butApresPost = "travaux/contrat-fiche-nouveau.jsp";
        String nomTable = "contrat";
        String idchantier = request.getParameter("idchantier");
         Chantier contrat_base = new Chantier();
        c.setNomTable("chantierlibelle");
        Chantier contrat = (Chantier) contrat_base.getById(idchantier, "chantierlibelle", null);
        affichage.Liste[] listes = new affichage.Liste[1];

        TypeObjet type = new TypeObjet();
        type.setNomTable("unitecontrat");
        listes[0] = new Liste("unite", type, "VAL", "id");

        pi.getFormu().changerEnChamp(listes);

        pi.getFormu().getChamp("idchantier").setDefaut(idchantier);
        pi.getFormu().getChamp("idchantier").setValeurLibelle(contrat.getIdtravaux());
        
        pi.getFormu().getChamp("codeetablissement").setDefaut(contrat.getCodeetablissement());
        pi.getFormu().getChamp("codeetablissement").setValeurLibelle(contrat.getCodeetablissementlib());
        
        pi.getFormu().getChamp("montant").setDefaut(String.valueOf(contrat.getMontant()));
        pi.getFormu().getChamp("projet").setDefaut(contrat.getProjet());
        pi.getFormu().getChamp("projet").setValeurLibelle(contrat.getProjetlib());

        pi.getFormu().getChamp("idchantier").setPageAppel("choix/listeChantierChoix.jsp");
        pi.getFormu().getChamp("idchantier").setAutre("readonly");
        pi.getFormu().getChamp("idtiers").setPageAppel("choix/listeTiersChoix.jsp");
        pi.getFormu().getChamp("idtiers").setAutre("readonly");
        pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("idLC").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLC;idLClibelle;idLClibelle;idLClibelle");
        pi.getFormu().getChamp("idLC").setAutre("readonly");

        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("droit_entree").setVisible(false);
        pi.getFormu().getChamp("redevance_fixe").setVisible(false);
        pi.getFormu().getChamp("devise").setVisible(false);
        pi.getFormu().getChamp("redevance_variable").setVisible(false);
        pi.getFormu().getChamp("droit_port").setVisible(false);
        pi.getFormu().getChamp("typedroitport").setVisible(false);
        pi.getFormu().getChamp("redevance_domaniale").setVisible(false);
        pi.getFormu().getChamp("redevance_locative").setVisible(false);
        pi.getFormu().getChamp("pipeline").setVisible(false);
        pi.getFormu().getChamp("typeduree").setVisible(false);
        pi.getFormu().getChamp("duree").setVisible(false);

        pi.getFormu().getChamp("idchantier").setLibelle("Chantier");
        pi.getFormu().getChamp("idtiers").setLibelle("Tiers");
        pi.getFormu().getChamp("date_signature").setLibelle("Date signature");
        pi.getFormu().getChamp("debut_contrat").setLibelle("D&eacute;but contrat");
        pi.getFormu().getChamp("unite").setLibelle("Unit&eacute;");
        pi.getFormu().getChamp("codeetablissement").setLibelle("Code &Eacute;tablissement");
        pi.getFormu().getChamp("idLC").setLibelle("Budget");
        pi.getFormu().getChamp("idLC").setVisible(false);
        pi.getFormu().getChamp("fin_contrat").setLibelle("Fin contrat");

        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <h1 align="center">Saisie contrat</h1>
            <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
                <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    out.println(pi.getFormu().getHtmlInsert());
                %>
                <input name="acte" type="hidden" id="nature" value="insert">
                <input name="bute" type="hidden" id="bute" value="<%= butApresPost%>">
                <input name="classe" type="hidden" id="classe" value="<%= classe%>">
                <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable%>">
            </form>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
