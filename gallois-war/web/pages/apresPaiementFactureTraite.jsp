<%@page import="facture.tr.Traite"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="bean.CGenUtil"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        String acte = request.getParameter("acte");
        String bute = request.getParameter("bute");
        String lien = (String) session.getValue("lien");
        String[] tabId = request.getParameterValues("id");
        String idtraite = request.getParameter("idTraite");
        UserEJB u = (user.UserEJB) session.getValue("u");
        if(acte.equals("attacher")){
            Traite traiteCritere = new Traite();
            traiteCritere.setId(idtraite);
            traiteCritere.setNomTable("traitemttreste");
            Traite[] traites = (Traite[])CGenUtil.rechercher(traiteCritere,null,null,"");
            if(traites.length > 0){
                traites[0].lierJournalCaisse(tabId);
            }
            else{
                throw new Exception("Aucune traite correspondante");
            }
        }
%>
<script language="JavaScript">
    document.location.replace("<%=lien%>?but=<%=bute%>");
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
