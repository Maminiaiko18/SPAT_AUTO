
<%@page import="bean.ClassMAPTable"%>
<%@page import="user.UserEJB"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<html>
    <%
        System.out.println("niditra tao @visa-multiple");
        String[] val = request.getParameterValues("id");

        if (val == null || val.length == 0) {
            throw new Exception("Vous devez  cocher au moins un element");
        }

        String table = request.getParameter("table");
        System.out.println("TABLE=" + table + " NOMBRE=" + val.length + " ACTE=" + request.getParameter("acte") + " CLASSE=" + request.getParameter("classe"));

        String nomTableRejet = request.getParameter("nomTableRejet");
        String nomTableCategorieRejet = request.getParameter("nomTableCategorieRejet");
        UserEJB u = (user.UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        String bute = request.getParameter("bute");
        String classe = request.getParameter("classe");
        String acte = request.getParameter("acte");
        String[] ids = request.getParameterValues("id");

        ClassEtat t = null;
        System.out.println(" mbola niditra tao @visa-multiple");
        try {
            System.out.println("acte====" + acte);
            if (acte.compareToIgnoreCase("viser") == 0) {
                System.out.println("Miditra ato");
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.viserObjectMultiple(t, val);
            }
            if (acte.compareToIgnoreCase("marquerLu") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.marquerLuMultiple(t, val);
            }
            /*if (acte.compareToIgnoreCase("immoGroupage") == 0) {
                System.out.println("GROUPAGE:"+val.length);
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.grouperImmo(val);
                System.out.println("VITA NY Groupage:"+val.length);
            }*/
 /*if (acte.compareToIgnoreCase("viserImmoGrouper") == 0) {
                //System.out.println("VISER IMMO MULTIPLE");
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.viserImmoGrouper(val);
                System.out.println("VITA NY AMORTISSEMENT-NY :"+val.length);
            }*/
 /*if (acte.compareToIgnoreCase("viserImmoMultiple") == 0) {
                System.out.println("VISER IMMO MULTIPLE");
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.viserImmoMultiple(val);
                System.out.println("VITA NY AMORTISSEMENT-NY :"+val.length);
            }*/
 /*if (acte.compareToIgnoreCase("rejeter") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                u.rejeterObjectMultiple(t, val, nomTableRejet, nomTableCategorieRejet);
            }
            if (acte.compareToIgnoreCase("annuler") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                u.annulerOPPrestation(val);
            }
            if (acte.compareToIgnoreCase("editerOp") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.editerOpMultiple(t,val);
            }*/
            if (acte.compareToIgnoreCase("cloturer") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.cloturerObjectMultiple(t, val);
            }

            if (acte.compareToIgnoreCase("annuler") == 0) {
                System.out.println("ANNULERRRRRRRR -----------");
                t = (ClassEtat) (Class.forName(classe).newInstance());
                t.setNomTable(table);
                u.annulerObjectMultiple(t, ids);
            }

            if (acte.compareToIgnoreCase("facturer") == 0) {
                mg.spat.exploitant.AdminActivite act = new mg.spat.exploitant.AdminActivite();
                act.findactivite(val);
                facture.FactureClient fc = act.facturer(u.getUser().getTuppleID());
                if (fc != null) {
                    bute += "&id=" + fc.getId();
                }
            }
            /*if (acte.compareToIgnoreCase("insertFB") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                RecetteService service = new RecetteService();
                service.createFraisBancaireFromVirement(val, u.getUser().getTuppleID());
            
            }
            //declaration TVA
            if (acte.compareToIgnoreCase("declarer-tva") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                DeclarationTVAService.declarerTVA(val);
            }
            if (acte.compareToIgnoreCase("annuler-tva") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                DeclarationTVAService.annulerTVA(val);
            }
            if (acte.compareToIgnoreCase("classer-tva") == 0) {
                t = (ClassEtat) (Class.forName(classe).newInstance());
                DeclarationTVAService.classerTVA(val);
            }
            if (acte.compareToIgnoreCase("amortir") == 0) {
               String a=request.getParameter("annee");
               if(a!=null && a.compareToIgnoreCase("")!=0)
               {
                   u.genererEcritureAmmortissementAnnuel(val, a);
               }
            }*/
    %><script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&table=<%=table%>");</script><%
    } catch (Exception e) {
        e.printStackTrace();

    %>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();</script>
        <%
                return;
            }
        %>

</html>