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
    a.setNomTable("LIGNECREDITRECETTE");
    lien = (String) session.getValue("lien");
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien(lien);
    pi.getFormu().getChamp("Etat").setVisible(false);
    pi.getFormu().getChamp("Quantite").setVisible(false);
    pi.getFormu().getChamp("Annee").setLibelle("Ann�e");
    pi.getFormu().getChamp("compteG").setVisible(false);    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification ligne credit recette</h1>
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
                    <input name="bute" type="hidden" id="bute" value="ligneCredit/modif-ligneCreditRecette.jsp?id=<%=request.getParameter("id")%>">
                    <input name="classe" type="hidden" id="classe" value="lignecredit.LigneCredit">
                    <input name="nomtable" type="hidden" id="nomtable" value="ligneCreditRecette">
                </form>
            </div>
        </div>
    </div>
</div>