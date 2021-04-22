<%-- 
    Document   : historique-syndicat-liste
    Created on : 4 déc. 2019, 14:20:55
    Author     : john
--%>

<%@page import="mg.spat.HistoriqueSyndicat"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    HistoriqueSyndicat hs = new HistoriqueSyndicat();
    
    String nomTable = "historiquesyndicatlib";    
    if(request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0){
        nomTable = request.getParameter("table");
    }
    hs.setNomTable(nomTable);

    String[] champ = {"id", "idsyndicat", "idposte" , "idpersonnel" , "daty", "etat"};
    String[] libelle_comp = {"ID", "Syndicat", "Poste" , "Personnel" , "Date", "Etat"};
     
    String listeCrt[] = {"id","idsyndicat","idposte","idpersonnel"};
    String listeInt[] = {"etat"};
    String libEntete[] = {"id","idsyndicat","idposte","idpersonnel"};
    
    PageRecherche pr = new PageRecherche(hs, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setOrdre(" order by rang desc");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("syndicat/historique-syndicat-liste.jsp");
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
        <h1>Liste historique syndicat</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=syndicat/historique-syndicat-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("historiquesyndicatlib") == 0) {%>    
                        <option value="historiquesyndicatlib" selected>Tous</option>
                        <% } else { %>
                        <option value="historiquesyndicatlib" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("historiquesyndicatlibcree") == 0) {%>    
                        <option value="historiquesyndicatlibcree" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="historiquesyndicatlibcree" > Cr&eacute;&eacute; </option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("historiquesyndicatlibvalide") == 0) {%>    
                        <option value="historiquesyndicatlibvalide" selected> Valid&eacute; </option>
                        <% } else { %>
                        <option value="historiquesyndicatlibvalide" > Valid&eacute; </option>
                        <% } %>
                        
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=syndicat"
                    + "/historique-syndicat-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
//            String libEnteteAffiche[] = {"Id","Syndicat","Poste","Personnel"};
//            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().construire_libelle(champ, libelle_comp);
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





