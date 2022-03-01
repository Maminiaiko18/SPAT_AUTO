<%-- 
    Document   : asBonDeCommande-modif
    Created on : 8 déc. 2020, 09:28:55
    Author     : Sanda
--%>
<%@page import="mg.spat.Engagement"%>
<%@page import="elementchantier.ElementChantier"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageUpdate" %>

<%
    Engagement base = new Engagement();
    base.setNomTable("engagementlib");
    PageUpdate pi = new PageUpdate(base, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("projetlib").setVisible(false);
    pi.getFormu().getChamp("codeetablissementlib").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idLClib").setVisible(false);
    
            
    pi.getFormu().getChamp("designation").setLibelle("Désignation");
    pi.getFormu().getChamp("codeetablissement").setLibelle("Code établissement");
    pi.getFormu().getChamp("projet").setLibelle("Projet");
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.getFormu().getChamp("disponible").setLibelle("Disponible");
    pi.getFormu().getChamp("dispoavant").setLibelle("Disponible avant");
    pi.getFormu().getChamp("dispoapres").setLibelle("Disponible après");
    pi.getFormu().getChamp("compte").setVisible(false);
    pi.getFormu().getChamp("idLC").setLibelle("Budget");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    
    
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp", "projet;projetlibelle");
    
    pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
    pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp", "codeEtablissement;codeEtablissementlibelle");
    
    pi.getFormu().getChamp("idLC").setAutre("readonly");
    pi.getFormu().getChamp("idLC").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLC;idLClibelle;idLClibelle;idLClibelle");
    
    pi.preparerDataFormu();
    base = (Engagement)pi.getBase();
%>

<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-8 col-md-offset-2">
            <div class="box">
                <h1>Modification engagement</h1>
                <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="engagement" id="engagement" data-parsley-validate>
                    <%
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <div class="row">
                        <div class="col-md-11">
                            <button class="btn btn-warning pull-right" name="Submit2" type="submit">Modifier</button>
                        </div>
                        <br><br> 
                    </div>
                    
                    <input name="acte" type="hidden" id="nature" value="update">
                    <input name="bute" type="hidden" id="bute" value="depense/engagement-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="<%= base.getClass().getName() %>">
                    <input name="nomtable" type="hidden" id="nomtable" value="engagement">
                    
                </form>
            </div>
        </div>
    </div>
</div>                    
<script>
    $('#projetlibelle').val('<%= Utilitaire.champNull(base.getProjetlib()) %>');
    $('#codeEtablissementlibelle').val('<%= Utilitaire.champNull(base.getCodeEtablissementlib()) %>');
    $('#idLC').val('<%= Utilitaire.champNull(base.getIdLClib()) %>');
    $('label[for="id"]').html('');
</script>        