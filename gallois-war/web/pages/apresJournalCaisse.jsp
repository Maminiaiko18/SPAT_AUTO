<%@page import="mg.spat.JournalCaisse"%>
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
<%@page import="mg.spat.MvttIntraCaisse"%>

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
                String compte = request.getParameter("compte");
                int mois = Utilitaire.stringToInt(request.getParameter("mois"));
                int annee = Utilitaire.stringToInt(request.getParameter("annee"));
                double tva = Utilitaire.stringToDouble(request.getParameter("tva"));
                System.out.println("navire : " + request.getParameter("idnavire"));
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                PageInsert p = new PageInsert(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                String idmvtCaisse = request.getParameter("idmvtcaisse") ;
                if(idmvtCaisse != null ){
                    MvttIntraCaisse mvtcaisse= new MvttIntraCaisse();
                    mvtcaisse = (MvttIntraCaisse)mvtcaisse.getById(idmvtCaisse, "mvtintracaisse", null);
                    id =mvtcaisse.encaisserTraite(u.getUser().getRefuser()+"",(JournalCaisse)p.getObjectAvecValeur());
                }else{
                    f.setNomTable(nomtable);
                    JournalCaisse o = (JournalCaisse) u.createObject(f);

                    if(request.getParameter("factureAuto") != null) o.genererFacture(null, u.getUser().getRefuser()+"", compte, annee, mois, tva);
                    temp = (Object) o;
                    if (o != null) {
                        id = o.getTuppleID();
                    }
                }
                
            }
            



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



