    <%-- 
    Document   : liste-mouvement
    Created on : 27 nov. 2020, 09:48:48
    Author     : Finaritra
--%>

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
    MouvementLibComplet mvt = new MouvementLibComplet();
    PageConsulte pc = new PageConsulte(mvt, request, u);
    mvt = (MouvementLibComplet) pc.getBase();
    MouvementLibComplet[] mouvements = mvt.getMouvementMemeEscale(null);
    String listeCrt[] = {"id", "nomnavire", "escale", "consignataire"};
    String listeInt[] = {"date_depart", "datearrivee"};
    String libEntete[] = {"id", "escale", "nomnavire", "desceconsignataire", "valcargaison", "valquaisprovenance", "valpaysprovenance", "valquaisdestination", "valpaysdestination", "datearrivee", "heure", "date_depart", "heure_depart", "duree", "descemvt","etatlib"};

    PageRecherche pr = new PageRecherche(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur(u);
    pr.setLien((String) session.getValue("lien"));
    pr.setOrdre("ORDER BY escale desc,id desc");
     /*pr.getFormu().getChamp("datearrivee1").setLibelle("Date d'arriv&eacute;e Min");
    pr.getFormu().getChamp("datearrivee2").setLibelle("Date d'arriv&eacute;e Max");
    pr.getFormu().getChamp("Date_depart1").setLibelle("Date de d&eacute;part Min");
    pr.getFormu().getChamp("Date_depart2").setLibelle("Date de d&eacute;part Max"); 
    pr.getFormu().getChamp("valconsignataire").setLibelle("Consignataire");
    pr.getFormu().getChamp("valquaisdestination").setLibelle("Localisation");
    pr.getFormu().getChamp("valcargaison").setLibelle("Cargaison");
    pr.getFormu().getChamp("nomnavire").setLibelle("Nom du Navire");
    pr.getFormu().getChamp("quaisdestination").setLibelle("Quai");*/
     
    pr.setApres("capitainerie/mouvement-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

    TableauRecherche tr = new TableauRecherche(mouvements, libEntete);
    pr.setTableau(tr);
%>
    <%
        String lienTableau[] = {pr.getLien() + "?but=capitainerie/mouvement-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        
        String libEnteteAffiche[]= {"id", "Escale", "Navire", "Consignataire", "Cargaison", "Quai provenance", "Pays provenance", "Quai destination", "Pays destination", "Date d'arriv&eacute;e", "Heure d'arriv&eacute;e", "Date de d&eacute;part", "Heure de d&eacute;part", "Dur&eacute;e (en j)", "Type mouvement","Etat"};
       pr.getTableau().setLibeEntete(libEnteteAffiche);
        //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
    %>
    <%} catch(Exception e){e.printStackTrace();}%>