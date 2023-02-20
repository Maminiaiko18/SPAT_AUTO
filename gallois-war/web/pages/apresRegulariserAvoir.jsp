<%@page import="mg.spat.exploitant.AdminActivite"%>
<%@page import="facture.FactureClient"%>
<%@page import="mg.spat.exploitant.Activite"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="java.sql.Date"%>
<%@page import="user.UserEJB"%>
<%@page import="facture.FactureClientAvoir"%>
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

        if (acte != null && acte.compareToIgnoreCase("regulariser") == 0) {
            String idavoirs = request.getParameter("idavoir");
            idavoirs = idavoirs.substring(0,idavoirs.length()-1);
            double m = Utilitaire.stringToDouble(request.getParameter("montant"));
            (new FactureClientAvoir(id, idavoirs, m)).payerAvoirFacture(u.getUser().getTuppleID());
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=id%>&tab=facture-client-fille");</script>
<% }

%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=id%>&tab=facture-client-fille");</script>
<% } catch (Exception e) {
    e.printStackTrace();
%>

<script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
    history.back();</script>
<%
        return;
    }
%>