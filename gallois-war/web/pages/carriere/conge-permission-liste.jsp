<%-- 
    Document   : conge-permission-liste
    Created on : 29 nov. 2019, 09:58:00
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.InfoCongePermission"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    InfoCongePermission info = new InfoCongePermission();
    info.setNomTable("infoCongePermission");
    String listeCrt[] = {"id","idPersonnel","disponibilite","objet","idPermission","date_debut_conge","date_fin_conge","date_debut_permission","date_fin_permission","nombre","nombrepermission"};
    String listeInt[] = {"date_debut_conge","date_fin_conge","date_debut_permission","date_fin_permission","nombre","nombrepermission"};
    String libEntete[] = {"id","idPersonnel","disponibilite","objet","idPermission","date_debut_conge","date_fin_conge","date_debut_permission","date_fin_permission","nombre","nombrepermission"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/conge-permission-liste.jsp");
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
        <h1>Liste conge permission</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/conge-permission-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/conge-permission-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Nom","Prenom","Adresse","Numero cin","Numero matricule","Poste","Direction","Anciennete poste","Situation matrimoniale","Date de naissance","Date d'embauche"};
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



