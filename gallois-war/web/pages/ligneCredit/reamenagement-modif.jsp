<%@page import="lignecredit.Reamenagement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
    UserEJB u = (user.UserEJB) session.getValue("u");
    Reamenagement a = new Reamenagement();
    a.setNomTable("REAMENAGEMENTLIB");
    String lien = (String) session.getValue("lien");
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien(lien);
    
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.getFormu().getChamp("idLigneDepart").setLibelle("Ligne D&eacute;part");
    pi.getFormu().getChamp("idLigneArrive").setLibelle("Ligne Arriv&eacute;");
    pi.getFormu().getChamp("idLigneDepart").setAutre("readonly");
    pi.getFormu().getChamp("idLigneDepart").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLigneDepart;idLigneDepartlibelle;idLigneDepartlibelle;idLigneDepartlibelle");
    pi.getFormu().getChamp("idLigneArrive").setAutre("readonly");
    pi.getFormu().getChamp("idLigneArrive").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLigneArrive;idLigneArrivelibelle;idLigneArrivelibelle;idLigneArrivelibelle");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("idLigneDepartLib").setVisible(false);
    pi.getFormu().getChamp("idLigneArriveLib").setVisible(false);

    a = (Reamenagement) pi.getBase();

    pi.getFormu().getChamp("idLigneDepart").setValeurLibelle(a.getIdLigneDepartLib());
    pi.getFormu().getChamp("idLigneArrive").setValeurLibelle(a.getIdLigneArriveLib());
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification r&eacute;am&eacute;nagement</h1>
                <form action="<%=lien%>?but=apresTarif.jsp&id=<%=request.getParameter("id")%>" method="post" name="modif">
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
                    <input name="bute" type="hidden" id="bute" value="ligneCredit/reamenagement-fiche.jsp?id=<%=request.getParameter("id")%>">
                    <input name="classe" type="hidden" id="classe" value="lignecredit.Reamenagement">
                    <input name="nomtable" type="hidden" id="nomtable" value="reamenagement">
                </form>
            </div>
        </div>
    </div>
</div>          
<%
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>