<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@page import="mg.spat.RemboursementPlacement"%>
<%@page import="mg.spat.Caisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    RemboursementPlacement pj = new RemboursementPlacement();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
     
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    
    pi.getFormu().getChamp("idplacement").setPageAppel("choix/listePlacementChoix.jsp");
    pi.getFormu().getChamp("idplacement").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idplacement").setLibelle("Placement");
    pi.getFormu().getChamp("montantplace").setLibelle("Montant plac&eacute;");
    pi.getFormu().getChamp("interet").setLibelle("Int&eacute;r&ecirc;t net");
    pi.getFormu().getChamp("interetBrut").setLibelle("Int&eacute;r&ecirc;t brut");
    //pi.getFormu().getChamp("ircm").setLibelle("IRCM");
    pi.getFormu().getChamp("etat").setVisible(false);
       
    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("caisse");
    liste[0] = new Liste("caisse", mvt, "VAL", "id");
   
    pi.getFormu().changerEnChamp(liste);
  
    if(request.getParameter("idplacement") != null){
        PlacementLibComplet[] data = (PlacementLibComplet[]) CGenUtil.rechercher(new PlacementLibComplet(), null, null, " and id='"+request.getParameter("idplacement")+"'");
        pi.getFormu().getChamp("idplacement").setDefaut(request.getParameter("idplacement"));
        pi.getFormu().getChamp("montantplace").setDefaut(Utilitaire.formaterAr(data[0].getMontant()));
        pi.getFormu().getChamp("interet").setDefaut(Utilitaire.formaterAr(data[0].getInteret_net()));
        pi.getFormu().getChamp("interetBrut").setDefaut(Utilitaire.formaterAr(data[0].getInteret_recevoir()));
        pi.getFormu().getChamp("IRCM").setDefaut(Utilitaire.formaterAr(data[0].getIrcm()));
        pi.getFormu().getChamp("caisse").setDefaut(data[0].getIdcaisse());
    }

    if(request.getParameter("disable") != null){
        pi.getFormu().getChamp("interet").setAutre("readonly");
        pi.getFormu().getChamp("interetBrut").setAutre("readonly");
        pi.getFormu().getChamp("IRCM").setAutre("readonly");
        pi.getFormu().getChamp("montantplace").setAutre("readonly");
    }

    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un Remboursement placement</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="placement/remboursement-placement-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.RemboursementPlacement">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>