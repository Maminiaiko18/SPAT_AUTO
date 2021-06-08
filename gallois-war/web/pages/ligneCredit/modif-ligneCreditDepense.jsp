<%@page import="lignecredit.LigneCredit"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    LigneCredit a;
    String lien;
    
%>
<%
    a = new LigneCredit();
    a.setNomTable("ligneCreditDepense");
    lien = (String) session.getValue("lien");
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien(lien);
    pi.getFormu().getChamp("Etat").setVisible(false);
    pi.getFormu().getChamp("Quantite").setLibelle("Quantité");
    pi.getFormu().getChamp("Annee").setLibelle("Année");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification ligne credit dépense</h1>
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
                    <input name="bute" type="hidden" id="bute" value="ligneCredit/modif-ligneCreditDepense.jsp?id=<%=request.getParameter("id")%>">
                    <input name="classe" type="hidden" id="classe" value="lignecredit.LigneCredit">
                    <input name="nomtable" type="hidden" id="nomtable" value="ligneCreditDepense">
                </form>
            </div>
        </div>
    </div>
</div>