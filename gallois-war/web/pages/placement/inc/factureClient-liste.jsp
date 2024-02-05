
<%@page import="facture.FactureClient"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="test.*" %>

<%
    FactureClient t = new FactureClient();
    t.setNomTable("FACTURECLIENTMSUM");
    String listeCrt[] = {"idPlacement"};
    String listeInt[] = {};
    String libEntete[] = {"id","nomclt", "code", "montant", "montanttva","montantttc","montantttcvrai"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("placement/inc/factureClient-liste.jsp");
    pr.setAWhere(" and idplacement = '"+ request.getParameter("id")+"'");
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String urlLienAffiche[] = {"id"};
        pr.getTableau().setUrlLien(colonneLien);
        pr.getTableau().setUrlLienAffiche(urlLienAffiche);
        String libEnteteAffiche[] =  {"ID","Tiers", "Code", "Montant HT","Montant TVA", "Net a payer","Montant TTC"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        FactureClient[] liste=(FactureClient[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
        }
        else
            {
               %><center><h4>Aucune donnee trouve</h4></center><%
        }
    %>
</div>