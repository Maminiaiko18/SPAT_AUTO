<%@page import="mg.spat.Client"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Client client = new Client();
    client.setNomTable("client");
    //placement.setNomTable("placementordre");
    PageUpdate pi = new PageUpdate(client, request, (user.UserEJB) session.getValue("u"));

    pi.getFormu().getChamp("cdclt").setLibelle("ID");
    pi.getFormu().getChamp("cdcat").setLibelle("000");
    pi.getFormu().getChamp("cdcat").setAutre("readonly");
    pi.getFormu().getChamp("nomclt").setLibelle("Nom");
    pi.getFormu().getChamp("adrclt").setLibelle("Adresse");
    pi.getFormu().getChamp("nmsttclt").setLibelle("STAT");
    pi.getFormu().getChamp("telclt").setLibelle("Telephone");
    pi.getFormu().getChamp("faxclt").setLibelle("Fax");
    pi.getFormu().getChamp("nmcin").setLibelle("CIN");
    pi.getFormu().getChamp("nif").setLibelle("NIF");
    pi.getFormu().getChamp("rc").setLibelle("RC");
    
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.preparerDataFormu();
%> 

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="">
                <div class="box">
                    <h1>Modification client</h1>
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
                        <input name="bute" type="hidden" id="bute" value="facture/client-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Client">
                        <input name="nomtable" type="hidden" id="nomtable" value="client">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
