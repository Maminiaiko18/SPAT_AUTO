<%-- 
    Document   : bondelivraison-liste
    Created on : 25 nov. 2020, 17:50:42
    Author     : ASUS
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<% 
    
    BonDeLivraison lv = new BonDeLivraison();
    //lv.setNomTable("ST_BONDLIVRAISON_VALIDER"); 
    lv.setNomTable("as_bondelivraison_MttCpl");
	if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            lv.setNomTable(request.getParameter("etat"));
        }
    String libEntete[] = {"id", "daty", "id_bc", "montant","montanttva","montantttc","montantfactttc","montantpaye","rap"};
    String listeCrt[] = {"id_bc"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("stock/bc/inc/bondelivraison-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
        <%  String lienTableau[] = {pr.getLien() + "?but=stock/bl/bondelivraison-fiche.jsp", pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
            String colonneLien[] = {"id","id_bc"};
            String[] urlLienMultiple = {"id","id_bc"};
            String[] urlLienAffiche = {"id","id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);           
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Date", "N° BC", "Montant","TVA","Montant TTC","Montant facturé","Montant payé","RAP"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>  
