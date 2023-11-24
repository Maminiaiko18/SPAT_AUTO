<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.Contrat"%>
<%
    try{
        Contrat contrat = new Contrat();
        contrat.setNomTable("CONTRATLIBCPLT");
        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id", "nom", "objet", "date_signature", "debut_contrat", "fin_contrat", "duree", "valunite", "lclib", "projetlib", "codeetablissementlib"};
        PageRecherche pr = new PageRecherche(contrat, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        String id = request.getParameter("id");
        pr.setAWhere(" and idchantier = '" + id + "'");
        pr.setApres("#");
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
            String lienTableau[] = {pr.getLien() + "?but=travaux/contrat-fiche-nouveau.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            String libEnteteAffiche[] ={"id", "Tiers", "objet", "date signature", "d&eacute;but contrat", "fin contrat", "dur&eacute;e", "unit&eacute;", "budget", "projet", "code etablissement"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            if(pr.getTableau().getHtml() != null){
                out.println(pr.getTableau().getHtml());
            }
            else
                {
                   %><center><h4>Pas de r&eacute;sultat</h4></center><%
            }
    %>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>