<%@page import="bean.ClassMAPTable"%>
<%@page import="mg.cnaps.compta.ComptaEcriture"%>
<%@page import="user.UserEJB"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<%
    String[] val = request.getParameterValues("id");
    if (val == null || val.length == 0) {
        throw new Exception("Vous devez  cocher au moins un element");
    }
    String nomTableRejet = request.getParameter("nomTableRejet");
    String nomTableCategorieRejet = request.getParameter("nomTableCategorieRejet");
    UserEJB u = (user.UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    String bute = request.getParameter("bute");
    String classe = request.getParameter("classe");
    String acte = request.getParameter("acte");
    String table = request.getParameter("nomTable");
    ClassEtat t = null;

    try {
        if (acte.compareToIgnoreCase("viser") == 0) {
            t = (ClassEtat) (Class.forName(classe).newInstance());
            t.setNomTable(table);
            String idTmp = Utilitaire.tabToString(val, "'", ",");
            ClassEtat[] et = (ClassEtat[]) u.getData(t, null, null, null, " and id in ("+idTmp+")");
            for(int co=0;co<et.length;co++){
                if(et[co].getEtat()!=ConstanteEtat.getEtatCmViseParDg()) throw new Exception("Veuillez ne selectionner que des elements visé par ordonnateur");
            }
            u.viserObjectMultiple(t, val);
        }
        if (acte.compareToIgnoreCase("rejeter") == 0) {
            t = (ClassEtat) (Class.forName(classe).newInstance());
            u.rejeterObjectMultiple(t, val, nomTableRejet, nomTableCategorieRejet);
        }
        if (acte.compareToIgnoreCase("annuler") == 0) {
            t = (ClassEtat) (Class.forName(classe).newInstance());
            u.annulerOPPrestation(val);
        }
        if (acte.compareToIgnoreCase("ordonne") == 0) {
            t = (ClassEtat) (Class.forName(classe).newInstance());
            u.cmOrdonneMultiple(t, val);
        }
%><script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script><%
} catch (Exception e) {
    e.printStackTrace();

%>
<script>
    alert('<%=e.getMessage()%>');
    history.back();</script>
<%
        return;
    }
%>