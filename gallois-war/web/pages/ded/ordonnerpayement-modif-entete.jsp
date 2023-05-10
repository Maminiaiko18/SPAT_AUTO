<%@page import="bean.CGenUtil"%>
<%@page import="avoir.AvoirFC"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="ded.OrdonnerPayementData"%>
<%@page import="user.*"%> 
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    String idavoir = request.getParameter("idAvoir");
    
    
    OrdonnerPayement a = new OrdonnerPayement();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    

    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("ded_Id").setVisible(false);
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("tiers").setAutre("readonly");

    pi.getFormu().getChamp("daty").setVisible(false);
    pi.getFormu().getChamp("numeroop").setVisible(false);
    pi.getFormu().getChamp("remarque").setLibelle("Motif de paiement");
    pi.getFormu().getChamp("remarque").setType("textarea");

    pi.getFormu().getChamp("montant").setAutre("readonly");
    pi.getFormu().getChamp("idLigne").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("numerobed").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet op = new TypeObjet();
    op.setNomTable("MODEPAIEMENTBQ");
    liste[0] = new Liste("modepaiement", op, "desce", "id");

    TypeObjet liste2 = new TypeObjet();
    liste2.setNomTable("DESTINATION");
    liste[1] = new Liste("destination", liste2, "desce", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
 
    pi.preparerDataFormu();
    OrdonnerPayement base = (OrdonnerPayement)pi.getBase();
%>
<div class="content-wrapper">
    <h1>Modification Entette Ordre de payer</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="ded_op" id="ded_op" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="enteteOP">
        <input name="bute" type="hidden" id="bute" value="ded/ordonnerpayement-fiche.jsp">
        <input name="id" type="hidden" id="id" value="<%= base.getId()%>">
        <input name="classe" type="hidden" id="classe" value="ded.OrdonnerPayement">
        <input name="nomtable" type="hidden" id="nomtable" value="ordonnerpayement">
        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >

    </form>
</div>
<script>
    $('#tierslibelle').val('<%= base.getTiers()%>');
</script>        
<%}catch(Exception e){
    e.printStackTrace();
}%>