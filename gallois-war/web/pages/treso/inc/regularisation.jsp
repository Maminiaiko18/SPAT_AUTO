
<%@page import="java.util.Date"%>
<%@page import="bon.RegulBP"%>
<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String condition = "";
        RegulBP ff = new RegulBP();       
        ff.setNomTable("regulbp_libcomplet");
        String libEntete[] = {"id","montant", "daty", "iduserlib"};
        String listeCrt[] = { "idbon","montant"};
        String listeInt[] = {""};
        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/inc/regularisation.jsp");
        String[] colSomme = null;
        if(request.getParameter("id") != null){
            condition = "and idbon='"+request.getParameter("id")+"'";
        }
        pr.setAWhere(condition);
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
    <section class="content-header">
        <h1>Liste régularisation</h1>
    </section>
    <section class="">
        <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="tarif" id="tarif">
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/regulBP-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id", "montant", "daty", "idUser"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            if(pr.getTableau().getHtml() != null){
                out.println(pr.getTableau().getHtml());   
            }else{%>
            <center><h3>Aucun résultat</h3></center>
            <%}
            
        %>
        </form>
    </section>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>