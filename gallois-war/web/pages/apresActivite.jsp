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
            a.facturer(u.getUser().getTuppleID(), null);
        %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
        <%}
    }catch(Exception e){
        e.printStackTrace();
    }
    %>