<%-- 
    Document   : rubrique-facture-fournisseur-modif
    Created on : 9 févr. 2021, 09:45:28
    Author     : andya
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="rubrique.RubriqueFactureFournisseur"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%
   String titre ="Modification rubrique facture fournisseur",
   bute ="facture/rubrique-facture-fournisseur-fiche.jsp&id="+request.getParameter("id"),
   classe="rubrique.RubriqueFactureFournisseur",
   nomtable = "rubriquefacturefournisseur";
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u;
    RubriqueFactureFournisseur a = new RubriqueFactureFournisseur();
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] listeUnit = new affichage.Champ[1];
    TypeObjet branche=new TypeObjet();
    branche.setNomTable("natureoperation");
    listeUnit[0]=new Liste("designation",branche,"val","id");
    pi.getFormu().changerEnChamp(listeUnit);
    pi.getFormu().getChamp("designation").setLibelle("Nature opération");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1 class="text-center"><%= titre  %></h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="acte" value="update">
                    <input name="bute" type="hidden" id="bute" value="<%= bute  %>">
                    <input name="classe" type="hidden" id="classe" value="<%= classe  %>">
                    <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable  %>">
                </form>
            </div>
        </div>
    </div>
</div>

