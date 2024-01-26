<%-- 
    Document   : placement-banquecaisse-saisie
    Created on : 26 janv. 2024, 12:13:13
    Author     : Valiah Karen
--%>

<%@page import="mg.spat.placement.PlacementBanqueCaisse"%>
<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PlacementBanqueCaisse lp = new PlacementBanqueCaisse();
    PageInsert pi = new PageInsert(lp, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

   // pi.getFormu().getChamp("escale").setPageAppel("choix/listeEscaleChoix.jsp");
    affichage.Champ[] liste = new affichage.Champ[2];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("banque");
    liste[0] = new Liste("val", mvt, "val", "id");
    
    TypeObjet mvt2 = new TypeObjet();
    mvt2.setNomTable("caisse");
    liste[1] = new Liste("desce", mvt2, "val", "id");
    
   
    
    pi.getFormu().changerEnChamp(liste);
    pi.preparerDataFormu();
    
     pi.getFormu().getChamp("val").setLibelle("Banque");
     pi.getFormu().getChamp("desce").setLibelle("Caisse");
    
  //pi.getFormu().getChamp("val").setLibelle("Nom");
   /*   pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("typeQuais").setLibelle("type Quais");
     */
%>
<div class="content-wrapper">
    <h1>Saisie liaison caisse et banque</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="placement/placement-banquecaisse-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.placement.PlacementBanqueCaisse">
    </form>
</div>
