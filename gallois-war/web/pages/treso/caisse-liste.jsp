<%-- 
    Document   : caisse-liste
    Created on : 2 d�c. 2019, 10:00:59
    Author     : john
--%>

<%@page import="mg.spat.Caisse"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.*"%>

<% 
    try{
        Caisse billetage = new Caisse();
        //billetage.setNomTable("billetagelib");
        String listeCrt[] = {"id","val","desce","numero"};
        String listeInt[] = {};
        String libEntete[] = {"id","val","desce","numero"};
        PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

      pr.getFormu().getChamp("val").setLibelle("Valeur");
        pr.getFormu().getChamp("desce").setLibelle("Description");

        pr.setApres("treso/caisse-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listecaisse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des caisses</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/caisse-liste.jsp" method="post" name="listecaisse" id="listecaisse">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/caisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
                out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post">
        <input type="hidden" name="acte" id="acte" value="cloturermultiple">
        <input type="hidden" name="bute" id="bute" value="treso/cloture-liste.jsp">
        <div>
            <center>
            <label for="remarque">Remarque:</label>
            <input type="text" name="remarque" id="remarque">
            
            <label for="date cloture">Date:</label>
            <input type="text" class="datepicker" onkeydown="return searchKeyPress(event)" name="date" id="date" value="<%=Utilitaire.dateDuJour()%>">
            </center>
        </div>
        <br>
        
        <%
            String libEnteteAffiche[] = {"id","valeur","description","numero"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setNameActe("cloturermultiple");
            pr.getTableau().setNameBoutton("Colturer");
            out.println(pr.getTableau().getHtmlWithCheckbox());
            out.println(pr.getBasPage());
        %>
        </form>
        <% out.println(pr.getBasPage());
         %>
        
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
