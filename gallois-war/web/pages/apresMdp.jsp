<%-- 
    Document   : apresFacture
    Created on : 15 janv. 2021, 11:38:49
    Author     : Tsiory
--%>
<%@page import="historique.MapUtilisateurServiceDirection"%>
<%@page import="historique.UtilisateurUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="facture.FactureClient"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Date" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String id, lien, bute, bute2, classe, acte, mdp;
    %>
<%
try {
        mdp = request.getParameter("mdp");
        id = request.getParameter("id");
        bute2 = request.getParameter("bute2");
        bute = request.getParameter("bute");
        classe = request.getParameter("classe");
        acte = request.getParameter("acte");
        u = (UserEJB) session.getAttribute("u");
        lien = (String) session.getValue("lien");
            
        MapUtilisateurServiceDirection uI = new UtilisateurUtil().testeValide(u.getUser().getLoginuser(), mdp, null, null);
        if(uI != null) {
            %>
                <form action="<%=lien%>?but=<%=bute%>" method="POST" id="form-apresMdp">
                    <input type="hidden" name="bute" value="<%=bute2%>">
                    <input type="hidden" name="classe" value="<%=classe%>">
                    <input type="hidden" name="acte" value="<%=acte%>">
                    <input type="hidden" name="id" value="<%=id%>">
                </form>
                <script>
                    document.getElementById("form-apresMdp").submit();
                </script>
            <%
        }
} catch (Exception e) {
    e.printStackTrace();
%>
        <script language="JavaScript"> 
            alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
            history.back();
        </script>
<%
        return;
    }
%>
</html>
