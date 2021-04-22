!<%@page import="bean.CGenUtil"%>
<%@page import="bean.TypeObjet"%>
<%@page import="lc.Direction"%>
<%@page import="affichage.Liste"%>
<%@page import="historique.MapRoles"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="historique.MapUtilisateurLib"%>
<%@page import="lc.Direction"%>
<%@page import="utilisateur.Role"%>

<%
    UserEJB u;
    MapUtilisateur a; 
%>
<%
    try{
        String refuser = request.getParameter("refuser");
        MapUtilisateurLib art = new MapUtilisateurLib();
        art.setNomTable("UTILISATEUR_ID");
        System.out.println(" Refuser =" + art.getRefuser());

        PageUpdate pi = new PageUpdate(art, request, (user.UserEJB) session.getValue("u"));
        System.out.println(" Refuser1111 =" + art.getRefuser());
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("loginuser").setLibelle("Login");
        pi.getFormu().getChamp("PWDUSER").setLibelle("Mot de passe");
        pi.getFormu().getChamp("PWDUSER").setValeur("");
        pi.getFormu().getChamp("PWDUSER").setType("password");
        pi.getFormu().getChamp("nomuser").setLibelle("Nom");
        //pi.getFormu().getChamp("teluser").setVisible(false);
        pi.getFormu().getChamp("IDROLE").setAutre("readonly");
        //pi.getFormu().getChamp("adruser").setValeur(art.getAdruser());
        //pi.getFormu().getChamp("adruser").setVisible(false);
        pi.getFormu().getChamp("IDROLE").setLibelle("Profil");
        pi.getFormu().getChamp("IDROLE").setAutre("readonly");//setVisible(false);
        
        affichage.Champ[] liste = new affichage.Champ[2];
        
        Direction cons = new Direction();
        cons.setNomTable("direction");
        liste[0] = new Liste("adruser", cons, "LIBELLEDIR", "IDDIR");

        Role role = new Role();
        liste[1] = new Liste("idrole", role, "descrole", "idrole");
        
//        pi.getFormu().changerEnChamp(liste);
        
        pi.getFormu().getChamp("adruser").setLibelle("Direction");
        pi.getFormu().getChamp("idrole").setLibelle("Rôle");
        pi.getFormu().getChamp("adruser").setAutre("readonly");//.setVisible(false);
        pi.getFormu().getChamp("idrole").setAutre("readonly");//setVisible(false);
        
        pi.preparerDataFormu();

 
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification de profil</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="starticle">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="teluser" type="hidden" id="teluser" value="<%=art.getTeluser()%>">
                        <input name="adruser" type="hidden" id="adruser" value="<%=art.getAdruser()%>">
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="utilisateur/profil-modif.jsp&refuser=<%=refuser%>">
                        <input name="classe" type="hidden" id="classe" value="historique.MapUtilisateur">
                        <input name="nomtable" type="hidden" id="nomtable" value="utilisateur">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
