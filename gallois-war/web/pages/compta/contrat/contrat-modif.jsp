<%-- 
    Document   : contrat-modif
    Created on : 2 déc. 2019, 08:25:33
    Author     : rajao
--%>
<%@page import="mg.spat.compta.Contrat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Contrat contrat=new Contrat();
        PageUpdate pi = new PageUpdate(contrat, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        UserEJB u = (UserEJB) session.getAttribute("u");
        
        pi.getFormu().getChamp("idTiers").setLibelle("Tiers");
        pi.getFormu().getChamp("date_signature").setLibelle("Date de signature");
        
        pi.getFormu().getChamp("debut_contrat").setLibelle("Date de début de contrat");
       
        pi.getFormu().getChamp("fin_contrat").setLibelle("Date de fin de contrat");
        pi.getFormu().getChamp("droit_entree").setLibelle("Droit d'entrée");
        pi.getFormu().getChamp("redevance_fixe").setLibelle("Redevance domaniale");
        pi.getFormu().getChamp("redevance_variable").setLibelle("Redevance variable");
        pi.getFormu().getChamp("droit_port").setLibelle("Droit de port");
        
        affichage.Champ[] liste = new affichage.Champ[3];

           TypeObjet mn = new TypeObjet();
           mn.setNomTable("unite");
           liste[0] = new Liste("client_concessionnaire", mn, "val", "id");

           TypeObjet mn1 = new TypeObjet();
           mn1.setNomTable("unite");
           liste[1] = new Liste("unite", mn1, "val", "id");

           TypeObjet mn2 = new TypeObjet();
           mn2.setNomTable("devisedemat");
           liste[2] = new Liste("devise", mn2, "val", "id");

           pi.getFormu().changerEnChamp(liste);

           pi.setLien((String) session.getValue("lien"));
           pi.preparerDataFormu();
    
        
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="compta/contrat/contrat-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.compta.Contrat">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function calculRedevence() {
        var domaniale = jQuery('#redevance_domaniale').val();
        var locative = jQuery('#redevance_locative').val();
        var pipeline = jQuery('#pipeline').val();

        if (jQuery.isNumeric(domaniale) && jQuery.isNumeric(locative)  && jQuery.isNumeric(pipeline)) {
            var montant = Number(domaniale)+Number(locative)+Number(pipeline);
            jQuery('#redevance_fixe').val(montant);
            
        }
    }
    
    
    jQuery(document).ready(function () {
        
        jQuery('#redevance_domaniale').keyup(function () {
            calculRedevence();
        });
         jQuery('#redevance_locative').keyup(function () {
            calculRedevence();
        });
         jQuery('#pipeline').keyup(function () {
            calculRedevence();
        });
        
    });

    
    
    
</script>             



<% }catch(Exception e)
    {
        
    }
%>
