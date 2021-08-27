<%-- 
    Document   : apresFacture
    Created on : 15 janv. 2021, 11:38:49
    Author     : Tsiory
--%>
<%@page import="java.sql.Connection"%>
<%@page import="facture.FactureClient"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Date" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String idfacture = "";
        String lien = null;
        String apresLien = null;
    %>
    <%
        try {
            idfacture = (String) request.getParameter("id");
            String acte = request.getParameter("acte");
            String bute = request.getParameter("bute");
            u = (UserEJB) session.getAttribute("u");
            lien = (String) session.getValue("lien");
            apresLien = bute;
            
            if (acte != null && acte.compareToIgnoreCase("fusionner") == 0) {
                System.out.println("===================================== fusionner =====================================");
                String[] listeFacture = request.getParameterValues("id");
                if (listeFacture == null && listeFacture.length == 0) {
                    throw new Exception("Vous devez cocher!");
                }
                FactureClient facture = new FactureClient();
                facture = (FactureClient) facture.getById(listeFacture[0], "Factureclient", null);
                String[] idautre = new String[listeFacture.length - 1];
                for (int i = 1; i < listeFacture.length; i++) {
                    idautre[i - 1] = listeFacture[i];
                }
                String colonneFusion = "idmere";
                facture.fusionner(u.getUser().getTuppleID(), colonneFusion, null, idautre);
            }

            if (acte != null && acte.compareToIgnoreCase("payer") == 0) {
                apresLien = u.checkPageSelonUtilisateur(idfacture, null);
            }
            
            if (acte != null && acte.compareToIgnoreCase("genererMICTSL") == 0) {
                int mois = Utilitaire.stringToInt(request.getParameter("mois"));
                int annee = Utilitaire.stringToInt(request.getParameter("annee"));
                String type = request.getParameter("type");
                String noteExplicative = request.getParameter("noteExplicative");
                Date daty = Utilitaire.stringDate(request.getParameter("daty"));
                 FactureClient factureclient = new FactureClient();
//                factureclient = (FactureClient) factureclient.getById(idfacture, "Factureclient", null);
                //System.out.println("ID UTSER ==== "+u.getUser().getTuppleID());
                FactureClient factRetour  = factureclient.creerMICTSL(daty, type, noteExplicative, mois, annee, u.getUser().getTuppleID(),null);
                
//                factRetour.createObject(u.getUser().getTuppleID(), null);
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=facture/factureclient-modif.jsp&id=<%=factRetour.getId()%>");</script>
                <%
            }

            if (acte != null && acte.compareToIgnoreCase("genererDefinitive") == 0) {
                FactureClient facture = new FactureClient();
                facture = (FactureClient) facture.getById(idfacture, facture.getNomTable(), null);
                
                FactureClient fact2 = facture.genererDefinitive(u, 1, null);
                if(fact2 == null) throw new Exception("Erreur lors de la generation");
                
                apresLien = "facture/factureclient-modif.jsp&id=" + fact2.getId();
            }
            
            if (acte != null && acte.compareToIgnoreCase("genererProvision") == 0) {
                FactureClient facture = new FactureClient();
                facture = (FactureClient) facture.getById(idfacture, facture.getNomTable(), null);
                
                FactureClient fact2 = facture.genererDefinitive(u, 2, null);
                if(fact2 == null) throw new Exception("Erreur lors de la generation");
                
                apresLien = "facture/factureclient-modif.jsp&id=" + fact2.getId();
            }
             
            if (acte != null && acte.compareToIgnoreCase("editerBED") == 0) {
                String[] listeFacture = request.getParameterValues("id");

                if (listeFacture == null) {
                    throw new Exception("Vous devez cocher!");
                }

                String ded_id = Utilitaire.tabToString(listeFacture, "", ";");
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&idsOP=<%=ded_id%>");</script>
    <%
        } if (acte != null && acte.equalsIgnoreCase("modifierEntete")) { 
            Page p = new Page(new FactureClient(), request);
            FactureClient fc = (FactureClient)p.getObjectAvecValeur();
            fc.modifierEntete(u.getUser().getRefuser(), null);
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%= bute %>&id=<%= fc.getId() %>");</script>
    <% } %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%= apresLien%>");</script>
    <%

    } catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
        history.back();</script>
        <%
                return;
            }
        %>
</html>
