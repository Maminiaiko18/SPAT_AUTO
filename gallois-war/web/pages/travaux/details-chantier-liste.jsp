<%-- 
    Document   : details-chantier-liste
    Created on : 25 nov. 2020, 17:49:30
    Author     : ACER
--%>

<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.DetailChantierLib"%>
<% try{ 
    DetailChantierLib ec = new DetailChantierLib();
    
    String listeCrt[] = {"caracteristique","libellechantier","unite"};
    String listeInt[] = {};
    String libEntete[] = {"id","caracteristique","libellechantier","qte","pu","unite"};
    
    PageRecherche pr = new PageRecherche(ec, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.getFormu().getChamp("caracteristique").setLibelle("Désignation");
    pr.getFormu().getChamp("libellechantier").setLibelle("Chantier");
    pr.getFormu().getChamp("unite").setLibelle("Unité");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null) {
        pr.setAWhere(" and mere = '"+request.getParameter("id")+"'");
    }
    pr.setApres("travaux/details-chantier-liste.jsp");
    String[] colSomme = null;
   
    pr.creerObjetPage(libEntete, colSomme);
%>  
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Eléments du chantier</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/details-chantier-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux/details-chantier-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Désignation","Chantier","Quantité","Prix unitaire","Unité"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>