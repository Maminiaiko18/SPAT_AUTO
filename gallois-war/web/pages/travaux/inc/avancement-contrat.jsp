<%@page import="avancement.AvancementContrat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageRecherche"%>
<%  
    AvancementContrat lv = new AvancementContrat();
    lv.setNomTable("avancement_contrat_etat_lib");
    String listeCrt[] = {"daty", "pourcentage", "observation", "etatLib"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"daty", "pourcentage", "observation", "etatLib"};

    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    
    pr.setAWhere(" and idcontrat = '" + request.getParameter("id") + "'");
    pr.setOrdre(" order by daty desc");
    String[] colSomme = null;
    pr.setNpp(2000);
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="box box-primary">
    <h1>Avancement contrat</h1>
    <% if (pr.getRs().getResultat().length > 0) { %>
    <%
        String libelleAffiche[] = {"Date", "pourcentage", "observation", "etat"};
        pr.getTableau().setLibelleAffiche(libelleAffiche);
    %>
    <div style="margin-right: 15px; margin-left: 15px">
        <% out.println(pr.getTableau().getHtml());%>    
    </div>
    <% } else { %>
        <h3>Pas de r&eacute;sultat!</h3>
    <% }%>
    <br/>
</div>
