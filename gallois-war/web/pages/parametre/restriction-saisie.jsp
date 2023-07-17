@@ -1,52 +0,0 @@
<%@page import="utilisateur.Restriction"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilisateur.Role"%>
<%@page import="affichage.PageInsert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    try{
       
        Restriction res = new Restriction();
        PageInsert pi = new PageInsert(res, request,(user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
             
        affichage.Champ[] liste = new affichage.Champ[1];
 
        String[] affiche = {"Interdit","Autorisé"};
        String[] value = {"0","1"};
        Liste lst = new Liste();
        lst.ajouterValeur(value, affiche);
        liste[0] = lst;
        liste[0].setNom("autorise");
    
        pi.getFormu().changerEnChamp(liste);
//        pi.getFormu().getChamp("idmenu").setLibelle("Menu");
        pi.getFormu().getChamp("idrole").setVisible(false);

        pi.getFormu().getChamp("refuser").setLibelle("Utilisateur");
        pi.getFormu().getChamp("iddirection").setVisible(false);
      

        pi.getFormu().getChamp("autorise").setLibelle("Accès");
        pi.getFormu().getChamp("refuser").setAutre("readonly");
        pi.getFormu().getChamp("refuser").setPageAppel("choix/listeUtilisateurChoixMultiple.jsp");
        
        pi.getFormu().getChamp("idaction").setLibelle("action");
        pi.getFormu().getChamp("idaction").setAutre("readonly");
        pi.getFormu().getChamp("idaction").setPageAppel("choix/listeActionChoixMultiple.jsp");
       
        
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Ajout Restriction par Utilisateur</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="menu" id="menu" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="restrictionUser">
        <input name="bute" type="hidden" id="bute" value="parametre/restriction-saisie.jsp">
        <input name="classe" type="hidden" id="classe" value="utilisateur.Restriction">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% } %>