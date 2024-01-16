<%@page import="mg.spat.RegulFFBP"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    RegulFFBP regul = new RegulFFBP();
    PageUpdate pi = new PageUpdate(regul, request, (user.UserEJB) session.getValue("u"));

    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("id").setAutre("readonly");
    pi.getFormu().getChamp("idbp").setLibelle("Bon provisoire");
    pi.getFormu().getChamp("idbp").setPageAppel("choix/bonprovisoire-tous.jsp");
    pi.getFormu().getChamp("idff").setLibelle("Facture fournisseur");
    pi.getFormu().getChamp("idff").setAutre("readonly");
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.preparerDataFormu();
%> 

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="">
                <div class="box">
                    <h1>Modification Regularisation Facture via Bon provisoire</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
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
                        <input name="bute" type="hidden" id="bute" value="facture/regulFFBP-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.RegulFFBP">
                        <input name="nomtable" type="hidden" id="nomtable" value="regulFFBP">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
