<%-- 
    Document   : onglet-exemple
    Created on : 9 mars 2023, 11:28:01
    Author     : BICI
--%>
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="test.*" %>

<%
    JournalCaisseLibComplet t = new JournalCaisseLibComplet();
    t.setNomTable("OPPaiementJCUnion");
    String id = request.getParameter("id");
    String listeCrt[] = {"id"};
    String listeInt[] = {};
    String libEntete[] = {"idordre", "numeroop", "dateSaisie", "dateEffet", "tierslib", "debit"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("treso/inc/ordonnerpaiement.jsp");
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=ded/ordonnerpayement-fiche.jsp"};
        String colonneLien[] = {"idordre"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String urlLienAffiche[] = {"id"};
        pr.getTableau().setUrlLien(colonneLien);
        pr.getTableau().setUrlLienAffiche(urlLienAffiche);
        String libEnteteAffiche[] =  {"ID", "Numero OP", "Date saisie", "Date effet", "Tiers", "Montant"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        JournalCaisseLibComplet[] liste=(JournalCaisseLibComplet[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
        }
        else
            {
               %><center><h4>Aucune donn�e trouv�</h4></center><%
        }

        if(liste != null) {
            if(liste[0].getEtat()==ConstanteEtat.getEtatValider()) {
        %>
            <a class="btn btn-info pull-warning" href="${pageContext.request.contextPath}/Paie?action=imprimerBP&id=<%=id%>" style="margin-right: 10px">Imprimer Bordereaux</a>
        <% } else { %>
            <a class="btn btn-info pull-warning" href="${pageContext.request.contextPath}/Paie?action=imprimerBP&id=<%=id%>" style="margin-right: 10px" disabled>Imprimer Bordereaux</a>
        <% }
        }
    %>
</div>