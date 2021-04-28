<%@page import="bordereau.BordereauFille"%>
<%@page import="user.UserEJB"%> 
<%@page import="affichage.PageInsert"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.Chantier"%>
<%@page import="detailschantier.DetailChantier"%>
<%@page import="mg.spat.ChantierLibComplet"%>
<%@page import="utilitaire.Utilitaire"%>

<%

    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String  mapping = "bordereau.BordereauFille",
                nomtable = "liaisonbordereauFF",
                apres = "ded/bordereauxFF-fiche.jsp",
                titre = "Saisie détails bordereaux facture";
        
        BordereauFille objet = new BordereauFille();
        objet.setNomTable(nomtable);
        PageInsert pi = new PageInsert(objet, request, u);
        pi.setLien((String) session.getValue("lien"));
        
        if(request.getParameter("idbordereau") != null && !request.getParameter("idbordereau").trim().equalsIgnoreCase("")){
            pi.getFormu().getChamp("idbordereau").setDefaut(request.getParameter("idbordereau"));
        }

        pi.getFormu().getChamp("idbordereau").setPageAppel("choix/listeBordereauFFchoix.jsp");
        pi.getFormu().getChamp("idbordereau").setAutre("readonly");
        
        pi.getFormu().getChamp("idop").setPageAppel("choix/listeFactureFournisseurChoix.jsp");
        pi.getFormu().getChamp("idop").setAutre("readonly");
        
        pi.getFormu().getChamp("idop").setLibelle("Facture");
        pi.getFormu().getChamp("idbordereau").setLibelle("Bordereau");

        pi.preparerDataFormu();
%>

<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
     
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>