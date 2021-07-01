<%@page import="facture.FactureClient"%>
<%@page import="mg.spat.AdminPrestation"%>
<%@page import="mg.spat.OccupationMaterielNaval"%>
<%@page import="mg.amadia.facture.FactureService"%>
<%@page import="bordereau.Bordereau"%>
<%@page import="facturefournisseur.FactureFournisseur"%>
<%@page import="mg.spat.StatistiqueMICTSL"%>
<%@page import="mg.spat.StatistiquePTP"%>
<%@page import="mg.spat.StatistiqueSMMC"%>
<%@page import="mg.spat.placement.Placement"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="mg.spat.relationhumaine.InfoPersonnel"%>
<%@page import="mg.spat.relationhumaine.InfoProfessionnel"%>
<%@page import="mg.spat.Cloture"%>
<%@page import="java.util.List"%>

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
            String[] ids = request.getParameterValues("id");

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
                if (rajoutLienFormu.length == 2) {
                    rajoutLieFormu = "&" + rajoutLienFormu[0] + "=" + rajoutLienFormu[1];
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

            if (acte.compareToIgnoreCase("factureGlobale") == 0) {
                String idprevision = request.getParameter("idPrevision");
                mg.spat.Prevision prevision = new mg.spat.Prevision();
                prevision.setId(idprevision);

                facture.FactureClient fc = prevision.facturer("" + u.getUser().getRefuser(), null);
                bute = "facture/factureclient-modif.jsp";
                id = fc.getId();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&valeur=<%=val%>&id=<%=Utilitaire.champNull(id)%>");</script>
    <%
        }

        /*if (ids == null || ids.length == 0) {
            throw new Exception("Vous devez  cocher au moins un element");
        }

        System.out.println("acte ===========" + acte);
        if (acte.compareToIgnoreCase("facturerPrevision") == 0) {
            String idprevision = request.getParameter("idprevision");
            AdminPrestation adminPrestation = new AdminPrestation();
            adminPrestation.initPrevision(idprevision);

            adminPrestation.findPrestations(ids);
            FactureClient facture = adminPrestation.facturer(u.getUser().getTuppleID());
            id = facture.getId();
            System.out.println("facture ===========" + facture.getId());
        }*/
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&valeur=<%=val%>&id=<%=Utilitaire.champNull(id)%>");</script>
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



