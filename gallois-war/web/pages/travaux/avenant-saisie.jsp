
<%@page import="mg.spat.Avenant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    Avenant a = new Avenant();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    String classe = "mg.spat.Avenant";
    String butApresPost = "travaux/avenant-fiche.jsp";
    String nomTable = "avenant";
    
    affichage.Liste[] listes = new affichage.Liste[1];

    TypeObjet type = new TypeObjet();
    type.setNomTable("unite");
    listes[0] = new Liste("unite", type, "VAL", "id");

    pi.getFormu().changerEnChamp(listes);
    
    if (request.getParameter("idcontrat") != null && request.getParameter("nomcontrat") != null) {
        pi.getFormu().getChamp("idcontrat").setDefaut(request.getParameter("idcontrat"));
        pi.getFormu().getChamp("idcontrat").setValeurLibelle(request.getParameter("nomcontrat"));
    }
        
    pi.getFormu().getChamp("idcontrat").setPageAppel("choix/listeChantierChoix.jsp");
    pi.getFormu().getChamp("idcontrat").setAutre("readonly");
    pi.getFormu().getChamp("idtiers").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("idtiers").setAutre("readonly");
    
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("fin_avenant").setVisible(false);
    pi.getFormu().getChamp("droit_entree").setVisible(false);
    pi.getFormu().getChamp("redevance_fixe").setVisible(false);
    pi.getFormu().getChamp("devise").setVisible(false);
    pi.getFormu().getChamp("redevance_variable").setVisible(false);
    pi.getFormu().getChamp("droit_port").setVisible(false);
    pi.getFormu().getChamp("typedroitport").setVisible(false);
    pi.getFormu().getChamp("redevance_domaniale").setVisible(false);
    pi.getFormu().getChamp("redevance_locative").setVisible(false);
    pi.getFormu().getChamp("pipeline").setVisible(false);
    pi.getFormu().getChamp("typeduree").setVisible(false);
    
    pi.getFormu().getChamp("idcontrat").setLibelle("Contrat");
    pi.getFormu().getChamp("idtiers").setLibelle("Tiers");
    pi.getFormu().getChamp("date_signature").setLibelle("Date signature");
    pi.getFormu().getChamp("debut_avenant").setLibelle("D&eacute;but avenant");
    pi.getFormu().getChamp("duree").setLibelle("Dur&eacute;e");
    pi.getFormu().getChamp("unite").setLibelle("Unit&eacute;");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <h1 align="center">Saisie avenant</h1>
            <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
                <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    out.println(pi.getFormu().getHtmlInsert());
                %>
                <input name="acte" type="hidden" id="nature" value="insert">
                <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
            </form>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>
