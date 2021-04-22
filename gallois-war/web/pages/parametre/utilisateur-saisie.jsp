
<%@page import="lc.Direction"%>
<%@page import="utilisateur.Role"%>
<%@page import="historique.MapUtilisateur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    MapUtilisateur pj = new MapUtilisateur();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("loginuser").setLibelle("Login");
    pi.getFormu().getChamp("pwduser").setLibelle("Mot de passe");
    pi.getFormu().getChamp("pwduser").setType("password");
    pi.getFormu().getChamp("nomuser").setLibelle("Nom");
    
    pi.getFormu().getChamp("teluser").setDefaut("1002067"); 
    pi.getFormu().getChamp("teluser").setAutre("readOnly"); 
    pi.getFormu().getChamp("teluser").setLibelle("Configuration");
    
    affichage.Champ[] liste = new affichage.Champ[2];
    
    Direction cons = new Direction();
    cons.setNomTable("direction");
    liste[0] = new Liste("adruser", cons, "LIBELLEDIR", "IDDIR");
    
    Role role = new Role();
    liste[1] = new Liste("idrole", role, "descrole", "idrole");

    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("adruser").setLibelle("Direction");
    pi.getFormu().getChamp("idrole").setLibelle("Rôle");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un utilisateur</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insertUser">
    <input name="bute" type="hidden" id="bute" value="parametre/utilisateur-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="historique.MapUtilisateur">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>