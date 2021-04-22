<%-- 
    Document   : journalcaisse-modif
    Created on : 6 nov. 2019, 12:07:39
    Author     : Tin
--%>

<%@page import="mg.spat.ClientFactureCategorieClient"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ClientFactureCategorieClient jc = new ClientFactureCategorieClient();
    PageUpdate pi = new PageUpdate(jc, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet typeObjet = new TypeObjet();
    typeObjet.setNomTable("Type_fact_cat_client");
    liste[0] = new Liste("idtype_fact_cat_client", typeObjet, "val", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idClient").setPageAppel("choix/listeClientChoix.jsp");

    pi.getFormu().getChamp("idClient").setLibelle("Client");
    pi.getFormu().getChamp("Idtype_fact_cat_client").setLibelle("Type facture");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Saisie Facture Client</h1>
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
                        <input name="bute" type="hidden" id="bute" value="facturation/client-fact-liste.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.ClientFactureCategorieClient">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="Client_fact_cat_client">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
