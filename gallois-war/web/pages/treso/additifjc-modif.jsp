<%-- 
    Document   : journalcaisse-modif
    Created on : 6 nov. 2019, 12:07:39
    Author     : Tin
--%>

<%@page import="mg.spat.AdditifJc"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    AdditifJc jc = new AdditifJc();
    PageUpdate pi = new PageUpdate(jc, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");

    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idjc").setLibelle("Journal caisse");
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("idjc").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification additif</h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
                    <%
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <div class="row">
                        <div class="col-md-11">
                            <button class="btn btn-warning pull-right" name="Submit2" type="submit">Enregistrer les modifications</button>
                        </div>
                        <br><br> 
                    </div>
                    <input name="acte" type="hidden" id="acte" value="update">
                    <input name="bute" type="hidden" id="bute" value="treso/additifjc-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="mg.spat.AdditifJc">
                    <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                    <input name="nomtable" type="hidden" id="nomtable" value="AdditifJc">
                </form>
            </div>
        </div>
    </div>
</div>
<%
    }catch(Exception ex){
        ex.printStackTrace();
    }
%>