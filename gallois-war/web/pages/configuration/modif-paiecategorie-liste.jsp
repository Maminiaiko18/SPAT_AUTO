<%@page import="mg.cnaps.paie.Paiecategorie"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<!--FICHIER TOJO And-->
<%!
    UserEJB u;
%>
<%
    Paiecategorie p = new Paiecategorie();
    u = (user.UserEJB) session.getValue("u");
    PageUpdate pc = new PageUpdate(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    //pc.getFormu().getChamp("id").setVisible(false);
    pc.getFormu().getChamp("val").setLibelle("Valeur");
    pc.getFormu().getChamp("desce").setLibelle("Description");
    pc.getFormu().getChamp("taux").setLibelle("Taux cotisation");
    pc.preparerDataFormu();

%>
<div class="content-wrapper">
    <section class="content-header">
        <h1><a href="<%=(String) session.getValue("lien")%>?but=configuration/paiecategorie-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Modification cat&eacute;gorie paie</h1>
    </section>
    <section class="content">
        <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="paieavancement">
            <%
                out.println(pc.getFormu().getHtmlInsert());
            %>
            <input class="btn btn-warning" type="submit" name="Submit2" value="Modifier" class="submit">

            <input class="btn btn-danger" type="submit" name="Submit2" value="Supprimer" class="submit" onclick="acte.value = 'delete'">
            <input name="acte" type="hidden" id="acte" value="update">
            <input name="nomtable" type="hidden" id="nomtable" value="Paie_categorie">
            <input name="bute" type="hidden" id="bute" value="configuration/idvaldesce.jsp">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.paie.Paiecategorie">
        </form>
    </section>
</div>
