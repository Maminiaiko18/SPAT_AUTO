<%-- 
    Document   : asBonDeCommande-modif
    Created on : 8 déc. 2020, 09:28:55
    Author     : Sanda
--%>
<%@page import="mg.spat.Liberer"%>
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
    Liberer base = new Liberer();
    base.setNomTable("libererlib");
    PageUpdate pi = new PageUpdate(base, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
      
    pi.getFormu().getChamp("idengagementlib").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
            
    pi.getFormu().getChamp("idengagement").setLibelle("Engagement");
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    
    pi.getFormu().getChamp("idengagement").setAutre("readonly");
    pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp", "idengagement;idengagementlibelle");
    
    pi.preparerDataFormu();
    base = (Liberer)pi.getBase();
%>

<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification liberer</h1>
                <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="liberer" id="liberer" data-parsley-validate>
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
                    <input name="bute" type="hidden" id="bute" value="depense/liberer-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="<%= base.getClass().getName() %>">
                    <input name="nomtable" type="hidden" id="nomtable" value="liberer">
                    
                </form>
            </div>
        </div>
    </div>
</div>                    
<script>
    $('#idengagementlibelle').val('<%= Utilitaire.champNull(base.getIdengagementlib()) %>');
    $('label[for="id"]').html('');
</script>        