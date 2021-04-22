<%@page import="bon.RegulBP"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    RegulBP a;
    
%>
<%
   String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new RegulBP();
    a.setNomTable("REGULBP_LIBCOMPLET");
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    a = (RegulBP) pi.getBase();
    
    pi.getFormu().getChamp("idbon").setLibelle("Bon Provisoire");
    pi.getFormu().getChamp("idbon").setValeurLibelle(a.getIdbonlib());
    pi.getFormu().getChamp("idbon").setAutre("readonly");
    pi.getFormu().getChamp("idbon").setPageAppel("choix/listeBonProvisoireChoix.jsp");
    
    
    pi.getFormu().getChamp("montant").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idbonlib").setVisible(false);
    pi.getFormu().getChamp("iduserlib").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification Régul BP</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
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
                        <input name="bute" type="hidden" id="bute" value="treso/regulBP-fiche.jsp?id=<%=request.getParameter("id") %>">
                        <input name="classe" type="hidden" id="classe" value="bon.RegulBP">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>