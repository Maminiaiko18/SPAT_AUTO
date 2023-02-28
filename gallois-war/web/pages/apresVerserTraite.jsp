<%@page import="facture.tr.Traite"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.Constante"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.spat.MvttIntraCaisse"%>
<%@page import="mg.spat.Engagement"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        String acte = request.getParameter("acte");
        String bute = request.getParameter("bute");
        String lien = (String) session.getValue("lien");
        String[] tabId = request.getParameterValues("id");
        UserEJB u = (user.UserEJB) session.getValue("u");
        String refUser = u.getUser().getRefuser()+"";
        String caisse=request.getParameter("idcaisse");
        String date=request.getParameter("date");

        
        if (acte.equals("versementTraite")) {
            MvttIntraCaisse mvtcaisse=new MvttIntraCaisse();
            mvtcaisse.setNomTable("mvtintracaisse");

            MvttIntraCaisse[] listeMvt=(MvttIntraCaisse[])CGenUtil.rechercher(mvtcaisse,null,null," and id in ("+Utilitaire.tabToString(tabId, "'", ",")+")");
            for(int i=0;i<listeMvt.length;i++){
                listeMvt[i].verserTraite(refUser);
            }
        }else if(acte.equals("encaissementTraite")){
            MvttIntraCaisse mvtcaisse=new MvttIntraCaisse();
            mvtcaisse.setNomTable("mvtintracaisse");

            MvttIntraCaisse[] listeMvt=(MvttIntraCaisse[])CGenUtil.rechercher(mvtcaisse,null,null," and id in ("+Utilitaire.tabToString(tabId, "'", ",")+")");
            for(int i=0;i<listeMvt.length;i++){
                listeMvt[i].encaisserTraite(caisse,date,refUser);
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