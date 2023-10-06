<%-- 
    Document   : apresMultiple
    Created on : Oct 19, 2018, 2:55:36 PM
    Author     : Jerry
--%>
<%@page import="facture.PaiementFacture"%>
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
    String champReturn;
    String action = null;
%>
<%
    try {
        nomtable = request.getParameter("nomtable");
        typeBoutton = request.getParameter("type");
        lien = (String) session.getValue("lien");
        u = (UserEJB) session.getAttribute("u");
        acte = request.getParameter("acte");
        bute = request.getParameter("bute");
        action = request.getParameter("action");
        Object temp = null;
        String[] rajoutLien = null;
        String classe = request.getParameter("classe");
        ClassMAPTable t = null;
        String tempRajout = request.getParameter("rajoutLien");
        String val = "";
        String id = request.getParameter("id");
        champReturn = request.getParameter("champReturn");
        String rajoutLie = "";
        if (tempRajout != null && tempRajout.compareToIgnoreCase("") != 0) {
            rajoutLien = utilitaire.Utilitaire.split(tempRajout, "-");
        }
        String tempRajoutLienFormu = request.getParameter("rajoutLienFormu");
        String rajoutLieFormu = "";
        String[] rajoutLienFormu = null;
        if (tempRajoutLienFormu != null && tempRajoutLienFormu.compareToIgnoreCase("") != 0) {
            rajoutLienFormu = utilitaire.Utilitaire.split(tempRajoutLienFormu, "-");
            if(rajoutLienFormu.length == 2){
                rajoutLieFormu = "&"+rajoutLienFormu[0]+"="+rajoutLienFormu[1];
            }
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

        if (rajoutLien != null) {

            for (int o = 0; o < rajoutLien.length; o++) {
                String valeur = request.getParameter(rajoutLien[o]);
                rajoutLie = rajoutLie + "&" + rajoutLien[o] + "=" + valeur;

            }

        }

        int type = Utilitaire.stringToInt(typeBoutton);
        if (acte.compareToIgnoreCase("insert") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            PageInsert p = new PageInsert(t, request);
            ClassMAPTable f = p.getObjectAvecValeur();
            f.setNomTable(nomtable);
            ClassMAPTable o = (ClassMAPTable) u.createObject(f);
            temp = (Object) o;
            if (o != null) {
                id = o.getTuppleID();
            }
            response.getWriter().print("success_"+id);
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        response.getWriter().print("error_"+ex.getMessage());
    }
%>