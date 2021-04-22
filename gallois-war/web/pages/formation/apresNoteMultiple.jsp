<%-- 
    Document   : apresDeclaration
    Created on : 29 sept. 2015, 16:57:29
    Author     : Tafitasoa
--%>

<%@page import="mg.cnaps.formation.FormService"%>
<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="mg.cnaps.utilisateur.CNAPSUser"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
    %>
    <%
        try {
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

            CNAPSUser util = new CNAPSUser();
            util.setId_utilisateur(u.getUser().getTuppleID());
            CNAPSUser[] utilisateur = (CNAPSUser[]) CGenUtil.rechercher(util, null, null, "");

            String rajoutLie = "";
            if (tempRajout != null && tempRajout.compareToIgnoreCase("") != 0) {
                rajoutLien = utilitaire.Utilitaire.split(tempRajout, "-");
            }
            if (bute == null || bute.compareToIgnoreCase("") == 0) {
                bute = "pub/Pub.jsp";
            }

            if (classe == null || classe.compareToIgnoreCase("") == 0) {
                classe = "pub.Montant";
            }
//            if (acte.compareToIgnoreCase("insert") == 0) {
//                String error = "";
//                try {
//                    String[] liste_id_declaration = request.getParameterValues("id");
//                    u.saveBordereau(liste_id_declaration);
//
//                } catch (Exception e) {
//                    out.println("<script language=\"JavaScript\">alert(\"" + e.getMessage() + "\")</script>");
//                }
//
//            }
//            
            if (acte.compareToIgnoreCase("delete") == 0) {
                String error = "";
                try {
                    t = (ClassMAPTable) (Class.forName(classe).newInstance());
                    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
                    u.deleteObject(t);

                } catch (Exception e) {
                    out.println("<script language=\"JavaScript\">alert(" + e.getMessage() + ")</script>");
                    System.out.println("erreur suppression" + e.getMessage());
                }


    %>
    <script language="JavaScript">
        alert("Erreur durant la suppression ");
    </script>
    <%        }
        if (acte.compareToIgnoreCase("update") == 0) {
            String formation = request.getParameter("idForm");
            String noteformateur = request.getParameter("noteformateur");
            int nbr = Integer.parseInt(request.getParameter("nbr"));
            String[] log_personnel = new String[nbr];
            String[] note = new String[nbr];
            for(int i = 0; i < nbr; i++){
                log_personnel[i] = request.getParameter("log_pers_"+i);
                note[i] = request.getParameter("note_"+i);
            }
            val = u.updateNoteFormationMutliple(formation, log_personnel, note, noteformateur);
        }
        if (acte.compareToIgnoreCase("finFormation") == 0) {
            String id = request.getParameter("id");
            FormService.finFormation(id,""+u.getUser().getRefuser());
            val= id+"&id="+id;
        }

        if (rajoutLien != null) {

            for (int o = 0; o < rajoutLien.length; o++) {
                String valeur = request.getParameter(rajoutLien[o]);
                rajoutLie = rajoutLie + "&" + rajoutLien[o] + "=" + valeur;
            }
        }

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&valeur=<%=val%>");</script>
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

