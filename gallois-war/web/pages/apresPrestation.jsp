<%@page import="mg.spat.OccupationMaterielNaval"%>
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

        if (acte.compareToIgnoreCase("valider") == 0) {     // VISER
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            t.setNomTable(nomtable);
//            System.out.println(nomtable + " ::: " + request.getParameter("id"));
//            System.out.println("classename: " + t.getClassName());
            OccupationMaterielNaval o = (OccupationMaterielNaval) u.validerObject(t);
            temp = t;
//            val = o.getTuppleID();
            val = o.getActivite().getId();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&id=<%=val%>");</script>
    <%
        }

        if (acte.compareToIgnoreCase("genererActivite") == 0) {     // VISER
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            t.setNomTable(nomtable);
            OccupationMaterielNaval o = (OccupationMaterielNaval) (t);
            o = (OccupationMaterielNaval) o.getById(o.getId(), null, null);
            o.genererActivite(u.getUser().getTuppleID(), null);
            temp = o;
            val = o.getActivite().getId();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&id=<%=val%>");</script>
    <%
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



