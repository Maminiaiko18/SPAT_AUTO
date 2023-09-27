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
        String  mapping = "mg.spat.Chantier",
                nomtable = "chantier",
                apres = "travaux/chantier-fiche.jsp",
                titre = "Nouveau chantier";
        
        Chantier objet = new Chantier();
        PageInsert pi = new PageInsert(objet, request, u);
        pi.setLien((String) session.getValue("lien"));
        
        if(request.getParameter("idtravaux") != null){
            pi.getFormu().getChamp("idtravaux").setDefaut(request.getParameter("idtravaux"));
        }
        if(request.getParameter("idtravaux") != null && request.getParameter("nom") != null){
            pi.getFormu().getChamp("idtravaux").setValeurLibelle(request.getParameter("nom"));
        }
        pi.getFormu().getChamp("idtravaux").setPageAppel("choix/listeTravauxChoix.jsp");
        pi.getFormu().getChamp("idtravaux").setAutre("readonly");
        
        pi.getFormu().getChamp("datydebut").setAutre("Date de début");
        pi.getFormu().getChamp("datydebut").setDefaut(Utilitaire.dateDuJour());    
        pi.getFormu().getChamp("datyfin").setAutre("Date de fin");
        pi.getFormu().getChamp("datyfin").setDefaut(Utilitaire.dateDuJour());    
        pi.getFormu().getChamp("idtiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("idtiers").setAutre("readonly");
        pi.getFormu().getChamp("idtiers").setLibelle("Tier");

        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("avancement").setVisible(false);
        pi.getFormu().getChamp("idtravaux").setLibelle("Travaux");
        pi.getFormu().getChamp("datydebut").setLibelle("Date debut");
        pi.getFormu().getChamp("datyfin").setLibelle("Date fin");
        pi.getFormu().getChamp("nom").setLibelle("Désignation");

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