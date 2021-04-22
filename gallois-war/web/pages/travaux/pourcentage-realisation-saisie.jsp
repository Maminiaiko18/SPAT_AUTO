
<%@page import="mg.spat.Chantier"%>
<%@page import="mg.spat.travaux.PourcentageProjet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        PourcentageProjet pj = new PourcentageProjet();
        user.UserEJB u = (user.UserEJB) session.getValue("u");
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        Chantier[] chantiers = new Chantier[0];
        if(request.getParameter("id") != null){
            chantiers = (Chantier[]) CGenUtil.rechercher(new Chantier(), null, null," and id like '"+request.getParameter("id")+"'");                      
        }

        String id = request.getParameter("id");
        pi.getFormu().getChamp("idchantier").setAutre("readonly");
        pi.getFormu().getChamp("idchantier").setPageAppel("choix/listeChantierChoix.jsp");
        if(chantiers.length >0 && chantiers[0] != null){
           pi.getFormu().getChamp("idchantier").setDefaut(chantiers[0].getId());
        }

        pi.getFormu().getChamp("idchantier").setLibelle("Chantier");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour()); 
        pi.getFormu().getChamp("idutilisateur").setLibelle("Utilisateur");
        pi.getFormu().getChamp("idutilisateur").setVisible(false);
        pi.getFormu().getChamp("idutilisateur").setValeur(u.getUser().getRefuser()+"");
        pi.getFormu().getChamp("etat").setVisible(false);

        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie pourcentage de réalisation</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="pourcentage" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="travaux/pourcentage-realisation-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.travaux.PourcentageProjet">
    </form>
</div>
<% 
        if(request.getParameter("id") != null && chantiers.length >0 && chantiers[0] != null) {
%>
    <script>
        document.getElementById("idChantierlibelle").value='<%=chantiers[0].getNom()%>';
    </script>
<% } %>
        
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>
