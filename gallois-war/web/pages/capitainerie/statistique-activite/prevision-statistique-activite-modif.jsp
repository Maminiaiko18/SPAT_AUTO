<%-- 
    Document   : prevision-statistique-activite-modif
    Created on : 30 nov. 2019, 11:42:00
    Author     : Tin
--%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%@ page import="mg.spat.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PrevisionStatistiqueActivite prev=new PrevisionStatistiqueActivite();
     PageUpdate pi = new PageUpdate(prev, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    pi.getFormu().getChamp("idclient").setPageAppel("choix/listeClientChoix.jsp");
   
    
    pi.getFormu().getChamp("idclient").setLibelle("Client");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("cumul").setLibelle("Cumul");
    pi.getFormu().getChamp("redevance_fixe").setVisible(false);
    pi.getFormu().getChamp("redevance_variable").setVisible(false);
    pi.getFormu().getChamp("autre").setVisible(false);
    
    
    pi.getFormu().getChamp("idclient").setAutre("readonly");
%>
    <div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/statistique-activite/prevision-statistique-activite-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.PrevisionStatistiqueActivite">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="prevision_statistique_activite">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>