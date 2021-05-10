<%-- 
    Document   : conteneur-saisie
    Created on : 23 févr. 2021, 14:46:54
    Author     : Sanda
--%>

<%@page import="affichage.Liste"%> 
<%@page import="affichage.PageInsert"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Constante"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "mg.spat.StatistiqueActivite",
            nomtable = "statistiqueActivite",
            apres = "statistique/statistique-fiche.jsp",
            titre = "Saisie statistique - Conteneur";
    
    StatistiqueActivite  objet = new StatistiqueActivite();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet typeActionConteneur = new TypeObjet();
    typeActionConteneur.setNomTable("typeActionConteneur");
    liste[0] = new Liste("idtypeActionConteneur", typeActionConteneur, "val", "id");
    TypeObjet typeSaisie = new TypeObjet();
    typeSaisie.setNomTable("typeSaisie");
    liste[1] = new Liste("typeSaisie", typeSaisie, "val", "id");
    
    /*TypeObjet typemanipulation = new TypeObjet();
    typemanipulation.setNomTable("typemanipulation");
    liste[2] = new Liste("idtypemanipulation", typemanipulation, "val", "id");*/
    
    pi.getFormu().changerEnChamp(liste);
	
    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("Etat").setVisible(false);
    pi.getFormu().getChamp("Poids").setVisible(false);
    pi.getFormu().getChamp("Nombreunite").setVisible(false);
    pi.getFormu().getChamp("Idtypemesure").setVisible(false);
    pi.getFormu().getChamp("idtypemanipulation").setVisible(false);
    pi.getFormu().getChamp("Idtypemarchandise").setVisible(false);
    pi.getFormu().getChamp("Idnomsociete").setVisible(false);
    pi.getFormu().getChamp("typeSaisie").setDefaut(Constante.conteneur);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("Plein20Pieds").setLibelle("20 pieds plein");
    pi.getFormu().getChamp("Vide20Pieds").setLibelle("20 pieds vide");
    pi.getFormu().getChamp("Plein40Pieds").setLibelle("40 pieds plein");
    pi.getFormu().getChamp("Vide40Pieds").setLibelle("40 pieds vide");
    pi.getFormu().getChamp("typeSaisie").setLibelle("Type");
    pi.getFormu().getChamp("idtypeActionConteneur").setLibelle("Type action conteneur");
    //pi.getFormu().getChamp("idtypemanipulation").setLibelle("Type manipulation");
            
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    
    <div class="box-title with-border">
        <h1 class="box-title">
            <a href="<%=pi.getLien()%>?but=statistique/statistique-saisie.jsp">
                <i class="fa fa-arrow-circle-left"></i>
            </a>  
            <%=titre%>
        </h1>
    </div>
    
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
    history.back();</script>
<% }%>
