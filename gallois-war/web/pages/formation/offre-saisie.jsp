<%-- 
    Document   : offreformation-saisie
    Created on : 13 oct. 2015, 11:54:20
    Author     : user
--%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.log.LogService"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.cnaps.formation.FormOffreFormation"%>
<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="affichage.PageInsert"%>
<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        FormOffreFormation a = new FormOffreFormation();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

        affichage.Champ[] liste = new affichage.Champ[4];

        LogService ser = new LogService();
        ser.setNomTable("LOG_SERVICE");
        liste[0] = new Liste("log_service", ser, "libelle", "id");

        TypeObjet cat = new TypeObjet();
        cat.setNomTable("FORM_CATEGORIE");
        liste[1] = new Liste("form_categorie", cat, "val", "id");

        TypeObjet t = new TypeObjet();
        t.setNomTable("form_type");
        liste[2] = new Liste("id_type", t, "val", "id");
        
        TypeObjet tc = new TypeObjet();
        tc.setNomTable("form_type_cout");
        liste[3] = new Liste("id_type_cout", tc, "val", "id");
        
        
        pi.getFormu().changerEnChamp(liste);
        
        pi.getFormu().getChamp("log_service").setLibelle("Service");
        pi.getFormu().getChamp("log_service").setVisible(false);
        pi.getFormu().getChamp("id_formateur").setLibelle("Formateur");
        pi.getFormu().getChamp("form_categorie").setLibelle("Cat&eacute;gorie");
        pi.getFormu().getChamp("form_categorie").setVisible(false);
        pi.getFormu().getChamp("id_type").setLibelle("Type de formation");
        pi.getFormu().getChamp("date_debut").setLibelle("Date d&eacute;but");
        pi.getFormu().getChamp("date_fin").setLibelle("Date fin");
        pi.getFormu().getChamp("lieu").setLibelle("Lieu");
        pi.getFormu().getChamp("remarque").setLibelle("Intitulé");
        pi.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
        pi.getFormu().getChamp("id_type_cout").setLibelle("Type coût");
        pi.getFormu().getChamp("cout_offre").setLibelle("Co&ucirc;t (Ariary)");
        pi.getFormu().getChamp("etablissement").setLibelle("Etablissement");
        pi.getFormu().getChamp("etat").setVisible(false);
    //    pi.getFormu().getChamp("exercice").setLibelle("Exercice");
        pi.getFormu().getChamp("iduser").setVisible(false);
        pi.getFormu().getChamp("id_formateur").setPageAppel("choix/formFormateurChoix.jsp");
        pi.getFormu().getChamp("etablissement").setPageAppel("choix/formetablissementChoix.jsp");

        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Offres de formation</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="offre" id="offre" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="formation/offre-liste.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormOffreFormation">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% } %>
