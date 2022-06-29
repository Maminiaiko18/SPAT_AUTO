<%@page import="bean.ClassMAPTable"%>
<%@page import="user.UserEJB"%>
<%@page import="facture.BonProvisoire"%>
<html>
    <% 
        UserEJB u = null;
        String acte = null;
        String lien = null;
       
        try{ 
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            String id = request.getParameter("id");
       
            if (acte.compareToIgnoreCase("payer") == 0) {    
            BonProvisoire.payer(null, id);
    %>
      <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/bon-provisoire-fiche.jsp&id=<%=id%>");</script>
    <% 
            }
        }   
        catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
        history.back();</script>
        <%
                return;
            }
        %>

    %>
</html>
