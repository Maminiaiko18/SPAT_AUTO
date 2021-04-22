<%-- 
    Document   : diplome-saisie
    Created on : 6 oct. 2015, 11:15:04
    Author     : user
--%>
<%@page import="mg.cnaps.formation.FormEtablissement"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageInsert"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FormEtablissement a = new FormEtablissement();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
	
	pi.getFormu().getChamp("specialisation").setLibelle("Spécialisation");
	pi.getFormu().getChamp("date_anciennete").setLibelle("Date de Création");
	pi.getFormu().getChamp("date_anciennete").setVisible(false);
	
	affichage.Champ[] liste = new affichage.Champ[1];

    TypeObjet m = new TypeObjet();
    m.setNomTable("pays");
    liste[0] = new Liste("pays", m, "VAL", "ID");
	pi.getFormu().changerEnChamp(liste);
    
	
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center"> Etablissement Saisie</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="etablissement" id="etablissement"  data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="configuration/etablissement-saisie.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormEtablissement">
    </form>
</div>
