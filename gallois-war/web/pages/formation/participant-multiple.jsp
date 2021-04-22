<%@page import="bean.ClassMAPTable"%>
<%@page import="user.UserEJB"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<%
    String[] val = request.getParameterValues("id");
    String idformation = request.getParameter("idformation");
    String nomTable = request.getParameter("nomTable");
    UserEJB u = (user.UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    String bute = request.getParameter("bute");
    String acte = request.getParameter("acte");
    ClassMAPTable t = null;
    Object temp = null;
    String retour = "";

    try {
	if (acte.compareToIgnoreCase("insert") == 0) {
	    temp = u.ajoutParticipantMultiple(idformation, val, nomTable);
	    if (temp != null) {
		retour = temp.toString();
	    }

	}
	if (acte.compareToIgnoreCase("enlever") == 0) {
	    temp = u.enleverParticipantMultiple(idformation, val, nomTable);
	    if (temp != null) {
		retour = temp.toString();
	    }
	}
    } catch (Exception e) {
	e.printStackTrace();
	retour = "true";
%>
<script>
    alert("<%=e.getMessage()%>");
</script>
<%}%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&retour=<%=retour%>&premier=false");</script>