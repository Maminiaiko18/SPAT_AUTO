<%-- 
    Document   : analyselien-modif
    Created on : 14 janv. 2020, 08:58:01
    Author     : Asus
--%>



<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    AnalyseLien analyse = new AnalyseLien();
    analyse.setNomTable("analyselien");
    PageUpdate pi = new PageUpdate(analyse, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    //pi.getFormu().getChamp("pavillon").setPageAppel("choix/listePaysChoix.jsp");
  pi.getFormu().getChamp("PAGE").setAutre("readonly");
  pi.getFormu().getChamp("IDUTILISATEUR").setAutre("readonly");
  pi.getFormu().getChamp("LIEN").setAutre("readonly");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
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
                        <input name="bute" type="hidden" id="bute" value="analyse_lien/analyselien-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="bean.AnalyseLien">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="analyselien">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

