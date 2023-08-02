<%@page import="mg.spat.Liberer"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%@page import="mg.spat.Mouvement"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="affichage.PageConsulte"%>
<%
    try{
        UserEJB u = (user.UserEJB) session.getValue("u");
        Liberer mvt = new Liberer();
        mvt.setNomTable("liberer");
        String listeCrt[] = {"idengagement"};
        String listeInt[] = {};
        String libEntete[] = {"id", "remarque", "montant"};

        PageRecherche pr = new PageRecherche(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.creerObjetPage(libEntete, null);
        String libEnteteAffiche[]= {"Id", "Remarque", "Montant"};
        pr.getTableau().setLibeEntete(libEnteteAffiche);
        pr.getTableau().setLien(new String[]{pr.getLien()+"?but=depense/liberer-fiche.jsp"});
        pr.getTableau().setColonneLien(new String[]{"id"});
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);

%>
        <% if(pr.getTableau().getData() != null && pr.getTableau().getData().length > 0){ %>
            <% out.println(pr.getTableau().getHtml()); %>
        <% } else { %>
            <center><h4>Pas de r&eacute;sultat</h4></center>
        
<%
          }  }
    catch(Exception e){
        e.printStackTrace();
    }
%>