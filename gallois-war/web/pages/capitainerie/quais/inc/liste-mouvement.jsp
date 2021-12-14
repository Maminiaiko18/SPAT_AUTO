    <%-- 
    Document   : liste-mouvement
    Created on : 27 nov. 2020, 09:48:48
    Author     : Finaritra
--%>

<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
      try{
    MouvementLibComplet mouvement = new MouvementLibComplet();

    String escale = request.getParameter("id");
    //String listeCrt[] = {"id","escale","nomnavire", "valconsignataire", "valcargaison", "valquaisdestination","datearrivee", "date_depart","quaisdestination"};
//    String listeCrt[] = {"desceconsignataire","idprevision"};
String listeCrt[] = {"desceconsignataire","escale"};
    String listeInt[] = {"date_depart","datearrivee"};
    String libEntete[] = {"id", "escale", "nomnavire", "desceconsignataire", "valcargaison", "valquaisprovenance", "valpaysprovenance", "valquaisdestination", "valpaysdestination", "datearrivee", "heure", "date_depart", "heure_depart", "duree", "descemvt","etatlib"};
    PageRecherche pr = new PageRecherche(mouvement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("capitainerie/mouvement-liste.jsp");
    pr.setOrdre(" order by  escale desc, id desc");
    pr.setAWhere(" and escale = '"+ escale +"'");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listemouvement.submit();
    }
</script>
    <section class="content">
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/mouvement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Escale", "Navire", "Consignataire", "Cargaison", "Quai provenance", "Pays provenance", "Quai destination", "Pays destination", "Date d'arrivée", "Heure d'arrivée", "Date de départ", "Heure de départ", "Dur&eacute;e (en h)", "Type mouvement","Etat"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
        %>
    </section>
      <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>