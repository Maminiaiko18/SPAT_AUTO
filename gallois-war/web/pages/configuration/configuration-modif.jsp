
<%@page import="mg.cnaps.configuration.Configuration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    Configuration a;
    
%>
<%
    a = new Configuration();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    a=(Configuration) pi.getBase();
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("valmin").setLibelle("Min");
    pi.getFormu().getChamp("valmax").setLibelle("Max");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    
    pi.getFormu().getChamp("typeconfig").setVisible(false);
    pi.getFormu().getChamp("compte_credit").setVisible(false);
    
    pi.getFormu().getChamp("id").setVisible(true);
    pi.getFormu().getChamp("id").setAutre("readonly");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <div class="box">
                <div class="box">
                    <h1>Modification Configuration</h1>
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
                        <input name="bute" type="hidden" id="bute" value="configuration/configuration-modif.jsp?id=<%=request.getParameter("id") %>">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.configuration.Configuration">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var idElem = document.getElementById("id"); 
    idElem.type = "textbox";
    idElem.removeAttribute('readonly');
</script>