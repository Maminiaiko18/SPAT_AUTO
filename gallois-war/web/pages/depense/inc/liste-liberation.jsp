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
    String id = request.getParameter("id");
    Liberer mvt = new Liberer();
    mvt.setNomTable("libererlib");
    PageConsulte pc = new PageConsulte(mvt, request, u);
    mvt = (Liberer) pc.getBase();
    String listeCrt[] = {"idengagement"};
    String listeInt[] = {};
    String libEntete[] = {"id", "idengagementlib", "montant"};

    PageRecherche pr = new PageRecherche(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur(u);
    pr.setLien((String) session.getValue("lien"));

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

%>
    <%
        String libEnteteAffiche[]= {"Id", "Engagement", "Montant"};
       pr.getTableau().setLibeEntete(libEnteteAffiche);
        //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
    %>
    <%} catch(Exception e){e.printStackTrace();}%>