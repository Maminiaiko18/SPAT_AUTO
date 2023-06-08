<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.EngagementLib"%>

<%
    EngagementLib eng = new EngagementLib();
    eng.setNomTable("LIAISONENGAGEMENTFF");
    String listeCrt[] = {"idfacturefournisseur"};
    String listeInt[] = {};
    String libEntete[] = {"id", "designation", "montant", "montantOP", "montantreste", "dispoavant", "dispoapres","montantengager" ,"codeetablissementlib", "projetlib", "tierslib", "daty", "num"};
    PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("#");
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
    System.out.println("taille : "+nombreLigne);
%>

<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=depense/engagement-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
          String libEnteteAffiche[] ={"Id", "D&eacute;signation", "Montant", "Montant d'ordre payement", "Disponibilit&eacute;", "Disponibilit&eacute; avant", "Disponibilit&eacute; apr&egrave;s","Montant engag&eacute;", "Code &eacute;tablissement", "Projet", "Tiers", "Date", "No."};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        EngagementLib[] liste=(EngagementLib[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
        }
        else
            {
               %><center><h4>Aucune donn&eacute;e trouv&eacute;</h4></center><%
        }
    %>
            

   

</div>