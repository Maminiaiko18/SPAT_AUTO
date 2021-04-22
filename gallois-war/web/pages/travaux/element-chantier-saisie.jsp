<%@page import="elementchantier.ElementChantier"%>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.PageInsert" %>
<%@ page import="affichage.Liste" %>
<%
    ElementChantier a = new ElementChantier();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[1];    
    TypeObjet unite = new TypeObjet();
    unite.setNomTable("unite");
    liste[0] = new Liste("unite", unite, "val", "id");
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie Element Chantier</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="elementchantier" id="elementchantier" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="travaux/element-chantier-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="elementchantier.ElementChantier">
    </form>
</div>