<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.EngagementLib"%>

<%
    try{
        EngagementLib eng = new EngagementLib();
        eng.setNomTable("engagementchantierlib");
        String listeCrt[] = {"chantier"};
        String listeInt[] = {};
        String libEntete[] = {"id", "designation", "montant", "montantOP", "montantreste", "dispoavant", "dispoapres", "codeetablissementlib", "projetlib", "tierslib", "daty", "num", "objet", "duree"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        String id = request.getParameter("id");
        if (id != null) {
            pr.setAWhere(" and chantier = '" + id + "'");
        }
        pr.setApres("#");
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);
        String nom = request.getParameter("nom");
%>

<div class="box-body">
    <%
            String lienTableau[] = {pr.getLien() + "?but=depense/engagement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
              String libEnteteAffiche[] ={"Id", "D&eacute;signation", "Montant", "Montant d'ordre payement", "Disponibilit&eacute;", "Disponibilit&eacute; avant", "Disponibilit&eacute; apr&egrave;s", "Code &eacute;tablissement", "Projet", "Tiers", "Date", "No.", "Objet", "Dur&eacute;e"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            EngagementLib[] liste=(EngagementLib[]) pr.getTableau().getData();
            if(pr.getTableau().getHtml() != null){
                out.println(pr.getTableau().getHtml());
            }
            else
                {
                   %><center><h4>Pas de résultat</h4></center><%
            }
    %>
    <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=depense/engagement-saisie.jsp&idchantier="+id+"&nom="+nom%>" style="margin-right: 10px">Saisir contrat</a>
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