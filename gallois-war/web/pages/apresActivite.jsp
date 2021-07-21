<%@page import="facture.FactureClient"%>
<%@page import="mg.spat.exploitant.Activite"%>
<%@page import="user.UserEJB"%>
<%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
        String nomtable = null;
        String typeBoutton;
        String champReturn;
        String action = null;
        String id;
        String val;
    %>
    <% try{
        lien = (String) session.getValue("lien");
         u = (UserEJB) session.getAttribute("u");
        acte = request.getParameter("acte");
        bute = request.getParameter("bute");
        id = request.getParameter("id");
        
        if (acte.compareToIgnoreCase("facturer") == 0) {
            Activite a = new Activite();
            a.setId(id);
            FactureClient fc = a.facturer(u.getUser().getTuppleID(), null);
            val = fc.getId();
        %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=val%>");</script>
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