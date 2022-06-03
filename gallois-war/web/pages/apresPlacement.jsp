<%@page import="mg.spat.exploitant.AdminActivite"%>
<%@page import="mg.spat.placement.Placement"%>
<%@page import="user.UserEJB"%>
<%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String nomtable = null;
        String typeBoutton;
        String champReturn;
        String action = null;
        String id;
    %>
    <% try{
        lien = (String) session.getValue("lien");
        u = (UserEJB) session.getAttribute("u");
        acte = request.getParameter("acte");
        id = request.getParameter("id");
        
        
        if (acte.compareToIgnoreCase("viserEtRendreEffectif") == 0) {
           Placement.viserEtRendreEffectif(null, u.getUser().getTuppleID(), id);
           
        %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=placement/placement-fiche.jsp&id=<%=id%>");</script>
        <%}


    } catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
        history.back();</script>
        <%
                return;
            }
        %>