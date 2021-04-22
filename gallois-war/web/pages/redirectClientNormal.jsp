<%
    String lien=(String)session.getValue("lien");
    
    String idClient=request.getParameter("cli");
    if(idClient.compareTo("clt1")==0){ %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=capitainerie/statistique-activite/statistiqueNormal-mictls-saisie.jsp?idClient=<%=idClient%>");</script>
    <%}else if(idClient.compareTo("0120093")==0){%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=capitainerie/statistique-activite/statistiqueNormal-ptp-saisie.jsp?idClient=<%=idClient%>");</script>
    <%}else if(idClient.compareTo("0120047")==0){%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=capitainerie/statistique-activite/statistiqueNormal-smmc-saisie.jsp?idClient=<%=idClient%>");</script> 
    <%}%>
%>