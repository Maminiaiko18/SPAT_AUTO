<%-- 
    Document   : apresMultiple
    Created on : Oct 19, 2018, 2:55:36 PM
    Author     : Jerry
--%>
<%@page import="factureclient.FactureClientDetail"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<%!
    UserEJB u = null;
    String acte = null;
    String lien = null;
    String bute;
    String nomtable = null;
    String typeBoutton;
    String ben;
    String[] tId;
%>
<%
    try {
        ben = request.getParameter("nomtable");
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
        String id = request.getParameter("id");
        tId = request.getParameterValues("id");
        String nombreLigneS = request.getParameter("nombreLigne");
        int nombreLigne = Utilitaire.stringToInt(nombreLigneS);
        String idmere = request.getParameter("idmere");
        String classefille = request.getParameter("classefille");
        ClassMAPTable mere = null;
        ClassMAPTable fille = null;
        String colonneMere = request.getParameter("colonneMere");
        String nombreDeLigne = request.getParameter("nombreLigne");
        int nbLine = Utilitaire.stringToInt(nombreDeLigne);
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
        if (typeBoutton == null || typeBoutton.compareToIgnoreCase("") == 0) {
            typeBoutton = "3"; //par defaut modifier
        }
        int type = Utilitaire.stringToInt(typeBoutton);
        if (acte != null && acte.compareToIgnoreCase("insert") == 0) {
            mere = (ClassMAPTable) (Class.forName(classe).newInstance());
            fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
            PageInsertMultiple p = new PageInsertMultiple(mere, fille, request, nbLine, tId);
            ClassMAPTable cmere = p.getObjectAvecValeur();
            ClassMAPTable[] cfille = p.getObjectFilleAvecValeur();
            for (int i = 0; i < cfille.length; i++) {
                cfille[i].setNomTable(nomtable);
            }
            ClassMAPTable o = (ClassMAPTable) u.createObjectMultiple(cmere, colonneMere, cfille);
            temp = (Object) o;
            if (temp != null) {
                val = temp.toString();
                idmere = o.getTuppleID();
            }
            response.getWriter().print("success_"+idmere);
        }

        if (acte != null && acte.compareToIgnoreCase("updateInsert") == 0) {
            mere = (ClassMAPTable) (Class.forName(classe).newInstance());
            fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
            PageUpdateMultiple p = new PageUpdateMultiple(mere, fille, request, nbLine, tId);
            ClassMAPTable cmere = p.getObjectAvecValeur();
            ClassMAPTable[] cfille = p.getObjectFilleAvecValeur();
            for (int i = 0; i < cfille.length; i++) {
                cfille[i].setNomTable(nomtable);
            }
            ClassMAPTable o = (ClassMAPTable) u.updateObjectMultiple(cmere, colonneMere, cfille);
            temp = (Object) o;
            if (temp != null) {
                val = temp.toString();
                idmere = o.getTuppleID();
            }
            response.getWriter().print("success_"+idmere);
        }
} catch (Exception ex) {
    ex.printStackTrace();
    response.getWriter().print("error_"+ex.getMessage());
}%>