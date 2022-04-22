<%-- 
    Author     : Michel
--%>
<%@page import="bean.CGenUtil"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageUpdate"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    try{
        String 
                acte = "modifierEntete",
                but = "apresFacture.jsp",
                table = "Factureclient",
                classe = "facture.FactureClient",
                bute = "facture/factureclient-fiche-vaovao.jsp",
                titre = "Modification entête facture client"
        ;
        FactureClient o = new FactureClient();
        o.setNomTable("FACTURECLIENT_LIBCOMPLET");
        PageUpdate pi = new PageUpdate(o, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        
        o =(FactureClient)pi.getBase();
        
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("designation").setLibelle("Note explicative");
        
        pi.getFormu().getChamp("tiers").setPageAppel("choix/clientCategorieChoix.jsp", "tiers;tierslibelle");
       
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        
        pi.getFormu().getChamp("armateur").setPageAppel("choix/listeArmateurTBDChoix.jsp");
         pi.getFormu().getChamp("armateur").setAutre("readonly");
        
        pi.getFormu().getChamp("type").setVisible(false);
        pi.getFormu().getChamp("tva").setVisible(false);
        pi.getFormu().getChamp("remarque").setVisible(false);
        pi.getFormu().getChamp("date_echeance").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idprevision").setVisible(false);
        pi.getFormu().getChamp("idcategorie").setVisible(false);
        pi.getFormu().getChamp("idProvision").setVisible(false);
        pi.getFormu().getChamp("deviseMere").setVisible(false);
        pi.getFormu().getChamp("estDDPMICTSL").setVisible(false);
        pi.getFormu().getChamp("codePrestation").setVisible(false);
        pi.getFormu().getChamp("code").setVisible(false);
        pi.getFormu().getChamp("estMictsl").setVisible(false);
        pi.getFormu().getChamp("tierslib").setVisible(false);
        pi.getFormu().getChamp("categorielib").setVisible(false);
        pi.getFormu().getChamp("typelib").setVisible(false);
        pi.getFormu().getChamp("armateurlib").setVisible(false);
        
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1><%= titre %></h1>
                    <form action="<%=pi.getLien()%>?but=<%= but %>" method="post" name="starticle" id="starticle">
                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="nature" value="<%= acte %>">
                    <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                    <input name="nomtable" type="hidden" id="nomtable" value="<%= table %>">
                    <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</div>
<script>
    var designation = document.getElementById("designation");
    var textarea = document.createElement("textarea");
    textarea.name = "designation";
    textarea.id = "designation";
    textarea.className = "form-control";
    textarea.style.height = "100px";
    textarea.value = designation.value;
    designation.parentNode.replaceChild(textarea, designation);
    
    document.getElementById("tiers").value = "<%= Utilitaire.champNull(o.getTiers()) %>";
    document.getElementById("tierslibelle").value = "<%= Utilitaire.champNull(o.getTierslib()) %>";

</script>
    <%
    }catch(Exception e){
e.printStackTrace();
}
    %>