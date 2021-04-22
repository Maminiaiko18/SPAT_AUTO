<%@page import="ded.OrdonnerPayement"%>
<%@page import="ded.OrdonnerPayementData"%>
<%@page import="user.*"%> 
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    OrdonnerPayement a = new OrdonnerPayement();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("ded_Id").setLibelle("N° facture");
    pi.getFormu().getChamp("ded_Id").setAutre("readonly");
//    pi.getFormu().getChamp("destination").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("tiers").setAutre("readonly");

    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("numeroop").setVisible(false);
    pi.getFormu().getChamp("numerobed").setLibelle("Numéro BED");
    pi.getFormu().getChamp("remarque").setLibelle("Motif de paiement");
//    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("remarque").setType("textarea");

    pi.getFormu().getChamp("montant").setAutre("readonly");
    pi.getFormu().getChamp("idLigne").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet op = new TypeObjet();
    op.setNomTable("MODEPAIEMENT");
    liste[0] = new Liste("modepaiement", op, "desce", "id");

    TypeObjet liste2 = new TypeObjet();
    liste2.setNomTable("DESTINATION");
    liste[1] = new Liste("destination", liste2, "desce", "id");
    pi.getFormu().changerEnChamp(liste);
        
    OrdonnerPayementData opd = new OrdonnerPayementData(request.getParameter("id"),request.getParameter("ded_id"));
    if (request.getParameter("ded_id") != null && request.getParameter("ded_id").compareTo("") != 0) {
        pi.getFormu().getChamp("ded_id").setDefaut(request.getParameter("ded_id"));
        pi.getFormu().getChamp("remarque").setDefaut("Paiement facture(s) " + request.getParameter("ded_id"));

    }else{
        pi.getFormu().getChamp("ded_Id").setDefaut(opd.getIdfacture());
    }
    pi.getFormu().getChamp("montant").setDefaut(Utilitaire.formaterAr(opd.getMontant()));
    
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie BED</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="ded_op" id="ded_op" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="ded/bed-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="ded.OrdonnerPayement">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>