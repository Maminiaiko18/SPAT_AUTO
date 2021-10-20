<%@page import="mg.spat.exploitant.AdminActivite"%>
<%@page import="facture.FactureClient"%>
<%@page import="mg.spat.exploitant.Activite"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="java.sql.Date"%>
<%@page import="user.UserEJB"%>
<%!
    UserEJB u = null;
    String acte = null;
    String lien = null;
    String bute;
    String id;
    String[] ids;
    String val;
    int nombreLigne;
%>
<% try {
        lien = (String) session.getValue("lien");
        u = (UserEJB) session.getAttribute("u");
        acte = request.getParameter("acte");
        bute = request.getParameter("bute");
        id = request.getParameter("id");
        ids = request.getParameterValues("id");
        nombreLigne = Utilitaire.stringToInt(request.getParameter("nombreLigne"));

        if (acte != null && acte.compareToIgnoreCase("saisieActiviteMultiple") == 0) {
            int mois = Utilitaire.stringToInt(request.getParameter("mois"));
            int annee = Utilitaire.stringToInt(request.getParameter("annee"));

            Date[] date = new Date[nombreLigne];
            String[][] qte = new String[nombreLigne][];
            String[][] rub = new String[nombreLigne][];

            for (int i = 0; i < nombreLigne; i++) {
                date[i] = Utilitaire.stringDate(request.getParameter("daty_" + i));
                qte[i] = request.getParameterValues("qte_" + i);
                rub[i] = request.getParameterValues("rubrique_" + i);
            }

            new Activite().creerActiviteMultiple(date, mois, annee, qte, rub, u, null);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
<% }

    if (acte != null && acte.compareToIgnoreCase("saisieMICTSLmultiple") == 0) {
        int mois = Utilitaire.stringToInt(request.getParameter("mois"));
        int annee = Utilitaire.stringToInt(request.getParameter("annee"));

        Date date = Utilitaire.stringDate(request.getParameter("daty"));
        String[] qte = request.getParameterValues("qte");
        String[] rub = request.getParameterValues("rubrique");

        new Activite().creerActiviteMultiple(date, mois, annee, qte, rub, u, null);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
<% }

%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=val%>");</script>
<% } catch (Exception e) {
    e.printStackTrace();
%>

<script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
    history.back();</script>
<%
        return;
    }
%>