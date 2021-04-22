<%-- 
    Document   : liaison-placement-saisie
    Created on : 22 nov. 2019, 15:17:36
    Author     : Asus
--%>

<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Liaisonplacement lp = new Liaisonplacement();
    PageInsert pi = new PageInsert(lp, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

   // pi.getFormu().getChamp("escale").setPageAppel("choix/listeEscaleChoix.jsp");
    affichage.Champ[] liste = new affichage.Champ[2];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("entite");
    liste[0] = new Liste("identite", mvt, "val", "id");
    
    TypeObjet mvt2 = new TypeObjet();
    mvt2.setNomTable("banque");
    liste[1] = new Liste("idbanque", mvt2, "val", "id");
    
   
    
    pi.getFormu().changerEnChamp(liste);
    pi.preparerDataFormu();
    
     pi.getFormu().getChamp("idbanque").setLibelle("Banque");
     pi.getFormu().getChamp("identite").setLibelle("Entité");
    
  //pi.getFormu().getChamp("val").setLibelle("Nom");
   /*   pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("typeQuais").setLibelle("type Quais");
     */
%>
<div class="content-wrapper">
    <h1>Saisie d'une Liaison Placement</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="placement/liaison-placement-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.placement.Liaisonplacement">
    </form>
</div>
