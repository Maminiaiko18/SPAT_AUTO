<%@page import="bean.ClassMAPTable"%>
<%@page import="user.UserEJB"%>
<html>
    <% 
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
        String nomtable = null;
        String champReturn;
        
        
        try{
            nomtable = request.getParameter("nomtable");        
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            bute = request.getParameter("bute");          
            Object temp = null;
            String[] rajoutLien = null;
            String classe = request.getParameter("classe");
            ClassMAPTable t = null;
            String val = "";
            String id = request.getParameter("id");
            champReturn = request.getParameter("champReturn");
            System.err.println("LE LIEN  ---------- "+lien);
            
            if (acte.compareToIgnoreCase("valider") == 0) {     // VISER
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
                t.setNomTable(nomtable);
                System.out.println(nomtable + " ::: " + request.getParameter("id"));
                System.out.println("classename: " + t.getClassName());
                ClassMAPTable o = (ClassMAPTable) u.validerObject(t);
                temp = t;
                val = o.getTuppleID();
    %>
    <script language="JavaScript"> document.location.replace("<%=bute%>?champReturn=<%=champReturn%>&param=1&id=<%=val%>");</script>
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
