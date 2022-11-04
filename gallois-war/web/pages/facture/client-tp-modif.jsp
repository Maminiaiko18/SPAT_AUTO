<%@page import="mg.spat.ClientTP"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ClientTP client = new ClientTP();
    client.setNomTable("client_tp");
    PageUpdate pi = new PageUpdate(client, request, (user.UserEJB) session.getValue("u"));

    pi.getFormu().getChamp("valide").setVisible(false);
//    pi.getFormu().getChamp("cdclt").setLibelle("ID");
    pi.getFormu().getChamp("cdclt").setPageAppel("choix/listeClientDBspatChoix.jsp");
    pi.getFormu().getChamp("cdclt").setAutre("readonly");
    pi.getFormu().getChamp("dttp").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("dttp").setLibelle("Date");
    pi.getFormu().getChamp("tp").setLibelle("TP");
    
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.preparerDataFormu();
    client = (ClientTP)pi.getBase();
    pi.getFormu().getChamp("cdclt").setValeurLibelle(client.getCdclt());
%> 

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="">
                <div class="box">
                    <h1>Modification TP client</h1>
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
                        <input name="bute" type="hidden" id="bute" value="facture/client-tp-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.ClientTP">
                        <input name="nomtable" type="hidden" id="nomtable" value="client_tp">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>