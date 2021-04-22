<%-- 
    Document   : lignecredit-modif
    Created on : 9 févr. 2021, 09:19:55
    Author     : andya
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="lignecredit.LigneCredit"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%
   String titre ="Modification ligne de credit",
   bute ="budget/lignecredit-fiche.jsp&id="+request.getParameter("id"),
   classe="lignecredit.LigneCredit",
   nomtable = "LIGNECREDIT";
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u;
    LigneCredit a = new LigneCredit();    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet d = new TypeObjet();
    d.setNomTable("TypeLingeCredit");
    liste[0] = new Liste("idtypelingecredit", d, "val", "id");   
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("idTypeLingeCredit").setLibelle("Type linge credit");
    pi.getFormu().getChamp("Designation").setLibelle("Désignation");
    pi.getFormu().getChamp("Creditinitial").setLibelle("Crédit initial");
    pi.getFormu().getChamp("Annee").setLibelle("Année");
    
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

