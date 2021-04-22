<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import = "user.*" %>
<%@page import = "utilitaire.*" %>
<%@page import = "bean.*" %>
<%@page import = "java.sql.SQLException" %>
<%@page import = "affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
        String nomtable;
        String typeBoutton;
    %>
    <%
        try {
            nomtable = request.getParameter("nomtable");
            typeBoutton = request.getParameter("type");
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            bute = request.getParameter("bute");
            Object temp = null;
            String[] rajoutLien = null;
            String classe = request.getParameter("classe");
            ClassMAPTable t = null;
            String tempRajout = request.getParameter("rajoutLien");
            String val = "";

            String rajoutLie = "";
            if (tempRajout != null && tempRajout.compareToIgnoreCase("") != 0) {
                rajoutLien = utilitaire.Utilitaire.split(tempRajout, "-");
            }

            if (acte.compareToIgnoreCase("insertBC") == 0) {
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                PageInsert p = new PageInsert(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                BonDeCommande bc = (BonDeCommande) f;
                String[] id = request.getParameterValues("produit");
//                String[] quantiteparpack = request.getParameterValues("quantiteparpack");
                String[] pu = request.getParameterValues("pu");
                String[] quantite = request.getParameterValues("quantite");
                String[] remarque = request.getParameterValues("remarque");
                String[] unite = request.getParameterValues("unite");
                String[] tva = request.getParameterValues("tva");
                val = u.saveBCAvecDetails(bc, id, pu, quantite,remarque,unite,tva);
            }
//            if (acte.compareToIgnoreCase("generateOPByBC") == 0) {
//                String idbc = request.getParameter("id");
//                val = u.generateOPByBC(idbc);
//            }
            //
            if (acte.compareToIgnoreCase("updateBC") == 0) {
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                Page p = new Page(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                BonDeCommande bc = (BonDeCommande) f;
                String[] idFille = request.getParameterValues("idFille");
                String[] produit = request.getParameterValues("produit");
                String[] remarque = request.getParameterValues("rm");
                String[] pu = request.getParameterValues("pu");
                String[] quantite = request.getParameterValues("quantite");
                val = u.updateBCAvecDetails(bc, idFille, pu, quantite,produit,remarque);
            }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=val%>");</script>
    <%

    } catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert('<%=e.getMessage()%>');
        history.back();</script>
        <%
                return;
            }
        %>
</html>



