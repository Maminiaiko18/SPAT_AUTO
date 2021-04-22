<%@page import="utilisateur.UserMenu"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilisateur.Role"%>
<%@page import="affichage.PageInsert"%>
<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserMenu a = new UserMenu();
        //a.setNomTable("");
        PageInsert pi = new PageInsert(a, request,(user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        
        affichage.Champ[] liste = new affichage.Champ[1];
    
        /*Role mvt = new Role();
        mvt.setNomTable("roles");
        liste[1] = new Liste("idrole",mvt,"descrole","idrole");*/
        
        String[] affiche = {"Autorisé","Interdit"};
        String[] value = {"0","1"};
        Liste lst = new Liste();
        lst.ajouterValeur(value, affiche);
        liste[0] = lst;
        liste[0].setNom("interdit");
    
        pi.getFormu().changerEnChamp(liste);
    
        pi.getFormu().getChamp("idmenu").setLibelle("Menu");
        pi.getFormu().getChamp("refuser").setLibelle("Utilisateur");
        
        //pi.getFormu().getChamp("idrole").setLibelle("Rôle");
        pi.getFormu().getChamp("idrole").setVisible(false);
        pi.getFormu().getChamp("codeservice").setVisible(false);
        pi.getFormu().getChamp("codedir").setVisible(false);
        pi.getFormu().getChamp("interdit").setLibelle("Accès");
        pi.getFormu().getChamp("idmenu").setAutre("readonly");
        pi.getFormu().getChamp("refuser").setAutre("readonly");
        
        pi.getFormu().getChamp("idmenu").setPageAppel("choix/listeMenuDynamiqueChoixMultiple.jsp");
        pi.getFormu().getChamp("refuser").setPageAppel("choix/listeUtilisateurChoixMultiple.jsp");

        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Ajout Menu</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="menu" id="menu" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insertMenu">
        <input name="bute" type="hidden" id="bute" value="parametre/menu-utilisateur-saisie.jsp">
        <input name="classe" type="hidden" id="classe" value="utilisateur.UserMenu">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% } %>
