<%@page import="mg.spat.stock.BonDeLivraison"%>
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

            if (acte.compareToIgnoreCase("insertBLDirect") == 0) {
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                PageInsert p = new PageInsert(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                BonDeLivraison bl = (BonDeLivraison) f;
                bl.setId("");
                String[] id = request.getParameterValues("id");
                String[] produit = request.getParameterValues("produit");
                String[] quantite = request.getParameterValues("quantite");
                val = u.saveBLAvecDetails(bl, id, produit, quantite);
            }
//            if (acte.compareToIgnoreCase("validerBL") == 0) {
//                    String idbl = request.getParameter("id");
//                    val = u.validerBL(idbl);
//            }
            //
            if (acte.compareToIgnoreCase("updateBL") == 0) {
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                Page p = new Page(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                BonDeLivraison bl = (BonDeLivraison) f;
                String[] idFille = new String[Utilitaire.stringToInt(request.getParameter("nb"))];
                if (request.getParameterValues("idFille") != null) {
                    idFille = request.getParameterValues("idFille");
                }
                String[] quantiteparpack = request.getParameterValues("quantiteparpack");
                String[] quantite = request.getParameterValues("quantite");
                val = u.updateBLAvecDetails(bl, idFille, quantiteparpack, quantite);
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



