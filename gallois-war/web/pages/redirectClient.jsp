<%
    String lien=(String)session.getValue("lien");
    
    String idClient=request.getParameter("cli");
    if(idClient.compareTo("clt1")==0){ %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=capitainerie/statistique-activite/statistique-mictsl-saisie.jsp?idClient=<%=idClient%>");</script>
    <%}else if(idClient.compareTo("0120093")==0){%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=capitainerie/statistique-activite/statistique-ptp-saisie.jsp?idClient=<%=idClient%>");</script>
    <%}else if(idClient.compareTo("0120047")==0){%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=capitainerie/statistique-activite/statistique-smmc-saisie.jsp?idClient=<%=idClient%>");</script> 
    <%}%>
%>