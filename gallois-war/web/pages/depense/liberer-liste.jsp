<%@page import="mg.spat.Liberer"%>
<%@page import="affichage.PageRecherche"%>
<% 
    Liberer bon = new Liberer(); 
    String nomtable = "libererlib";
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            nomtable = request.getParameter("etat");
        }	    
    bon.setNomTable(nomtable);        
    String listeCrt[] = {"id", "idengagementlib"};
    String listeInt[] = {};
    String libEntete[] = {"id", "idengagementlib", "montant"};
    PageRecherche pr = new PageRecherche(bon, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
   
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("idengagementlib").setLibelle("Engagement");
    

    pr.setApres("depense/liberer-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=depense/liberer-liste.jsp" method="post" name="absence" id="absence">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("libererlib") == 0) {%>    
                        <option value="libererlib" selected>Tous</option>
                        <% } else { %>
                        <option value="libererlib" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("libererlibC") == 0) {%>
                        <option value="libererlibC" selected>Créé</option>
                        <% } else { %>
                        <option value="libererlibC">Créé</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("libererlibV") == 0) {%>
                        <option value="libererlibV" selected>Visé</option>
                        <% } else { %>
                        <option value="libererlibV">Visé</option>
                        <% } %>

                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
            
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=depense/liberer-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID", "Engagement", "Montant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
