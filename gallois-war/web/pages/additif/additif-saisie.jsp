<%-- 
    Document   : additif-saisie
    Created on : 18 d�c. 2020, 09:27:13
    Author     : Sanda
--%>

<%@page import="avoir.Avoir"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="affichage.Champ"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="mg.spat.Tva"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "avoir.Avoir",
            nomtable = "additif",
            apres = "additif/additif-fiche.jsp",
            titre = "Nouvel additif";
    
    Avoir  objet = new Avoir();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[2];
    String[] value = {"1","2"}, affiche = {"HT","TTC"};
    liste[0] = new Liste("type",affiche, value);
    Tva tva = new Tva();
    liste[1] = new Liste("tva", tva, "valeurtva", "valeurtva"); 
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idfacture").setDefaut(request.getParameter("idfacture"));
    pi.getFormu().getChamp("idfacture").setPageAppel("choix/listeFactureFournisseurChoix.jsp");
    pi.getFormu().getChamp("idfacture").setAutre("readonly");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idfacture").setLibelle("facture");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    
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
    history.back();</script>
<% }%>
