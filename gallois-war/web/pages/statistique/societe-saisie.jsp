<%-- 
    Document   : societe-saisie
    Created on : 23 févr. 2021, 14:47:07
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
            titre = "Saisie statistique - Societe";
    
    StatistiqueActivite  objet = new StatistiqueActivite();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[5];
    TypeObjet nomsociete = new TypeObjet();
    nomsociete.setNomTable("nomsociete");
    liste[0] = new Liste("idnomsociete", nomsociete, "val", "id");
    TypeObjet typeSaisie = new TypeObjet();
    typeSaisie.setNomTable("typeSaisie");
    liste[1] = new Liste("typeSaisie", typeSaisie, "val", "id");
    TypeObjet typemanipulation = new TypeObjet();
    typemanipulation .setNomTable("typemanipulation");
    liste[2] = new Liste("idtypemanipulation", typemanipulation , "val", "id");
    TypeObjet typemarchandise = new TypeObjet();
    typemarchandise .setNomTable("typemarchandise");
    liste[3] = new Liste("idtypemarchandise", typemarchandise , "val", "id");
    TypeObjet typemesure = new TypeObjet();
    typemesure .setNomTable("typemesure");
    liste[4] = new Liste("idtypemesure", typemesure , "val", "id");
    pi.getFormu().changerEnChamp(liste);
	
    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("Etat").setVisible(false);
    pi.getFormu().getChamp("IdtypeActionConteneur").setVisible(false); 
    pi.getFormu().getChamp("Plein20Pieds").setVisible(false); 
    pi.getFormu().getChamp("Vide20Pieds").setVisible(false); 
    pi.getFormu().getChamp("Plein40Pieds").setVisible(false); 
    pi.getFormu().getChamp("Vide40Pieds").setVisible(false); 
    pi.getFormu().getChamp("idtypemesure").setDefaut(Constante.tonnage);
    pi.getFormu().getChamp("typeSaisie").setDefaut(Constante.societe);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idnomsociete").setLibelle("Nom");
    pi.getFormu().getChamp("typeSaisie").setLibelle("Type");
    pi.getFormu().getChamp("idtypemanipulation").setLibelle("Type manipulation");
    pi.getFormu().getChamp("idtypemarchandise").setLibelle("Type marchandise");
    pi.getFormu().getChamp("idtypemesure").setLibelle("Type mesure");
    pi.getFormu().getChamp("nombreunite").setLibelle("Nombre d'unite");
            
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
