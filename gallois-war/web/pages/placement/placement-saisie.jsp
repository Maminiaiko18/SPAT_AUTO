
<%@page import="mg.spat.Caisse"%>
<%@page import="mg.spat.placement.Placement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Placement pj = new Placement();
    //pj.setNomTable("placementordre");
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    pi.getFormu().getChamp("date_placement").setLibelle("Date placement");
    pi.getFormu().getChamp("date_placement").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_echeance").setLibelle("Date échéance");

    pi.getFormu().getChamp("banque").setLibelle("Banque");
    pi.getFormu().getChamp("numero").setLibelle("Référence");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[3];
    
    TypeObjet mvt = new TypeObjet();
//    mvt.setNomTable("v_liaisonplacement");
    mvt.setNomTable("entite");
    liste[0] = new Liste("entite", mvt, "VAL", "id");
    

//    Caisse caisse = new Caisse();
//    caisse.setNomTable("caisse");
//    liste[1] = new Liste("numero", caisse, "VAL", "id");
    
    TypeObjet b = new TypeObjet();
    b.setNomTable("BANQUE");
    liste[1] = new Liste("banque", b, "VAL", "id");

    /*Caisse caisse = new Caisse();
    caisse.setNomTable("caisse");
    liste[1] = new Liste("numero", caisse, "VAL", "id");*/
    TypeObjet op = new TypeObjet();
    op.setNomTable("DEVISE");
    liste[2] = new Liste("iddevise", op, "desce", "id");

    pi.getFormu().changerEnChamp(liste);
    
//    pi.getFormu().getChamp("iddevise").setAutre("onblur=\"dependanteChampUneValeur(this.value, 'montantdevise', 'coursdevise', 'fin.Coursdevise', 'iddevise', 'iddevise', 'montant','daty','desc');\"");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
//    pi.getFormu().getChamp("montantdevise").setLibelle("Montant devise");
    pi.getFormu().getChamp("montantdevise").setVisible(false);
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un placement</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="placement/placement-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.placement.Placement">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>