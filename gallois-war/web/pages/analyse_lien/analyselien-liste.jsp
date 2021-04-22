<%-- 
    Document   : budget-activites-liste
    Created on : 21 janv. 2020, 16:13:46
    Author     : Asus
--%>


<%@page import="service.UploadService"%>
<%@page import="mg.spat.Quais" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
     try{
    AnalyseLien ff = new AnalyseLien();
    
    
    String listeCrt[] = {"id","page","idUtilisateur","titre"};
    String listeInt[] = {};
    String libEntete[] = {"id","page","idUtilisateur","titre"};
    String colDefaut[] ={"id","page","idUtilisateur","titre"};
    String somDefaut[] = {};
    
    PageRechercheGroupe pr = new PageRechercheGroupe(ff, request, listeCrt, listeInt, 3, colDefaut, somDefaut, 4, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));  
    
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("idUtilisateur").setLibelle("Utilisateur"); 
    
    pr.setApres("analyse_lien/analyselien-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage();%>
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des D&eacute;penses du budget</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=analyse_lien/analyselien-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>	
 
            
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=analyse_lien/analyselien-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
          
            String libEnteteAffiche[] = {"Id","Page","Utilisateur","Titre"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%
}catch(Exception e){
    e.printStackTrace();
}%>