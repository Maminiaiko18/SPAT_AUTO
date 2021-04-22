<%-- 
    Document   : conge-permission-fiche
    Created on : 30 nov. 2019, 09:10:45
    Author     : Tin
--%>
<%@page import="historique.MapUtilisateurLib"%>
<%@page import="utilisateur.UserMenu"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="historique.MapUtilisateur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
       
    MapUtilisateurLib mp = new MapUtilisateurLib();
    PageConsulte pc = new PageConsulte(mp, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche Utilisateur");
    pc.getChampByName("refuser").setVisible(false);
    String dossier="parametre";
    pc.getChampByName("pwduser").setLibelle("Mots de passe");
    pc.getChampByName("idrole").setLibelle("Rôle");
    pc.getChampByName("nomuser").setLibelle("Nom de l'utilisateur");
    pc.getChampByName("loginuser").setLibelle("Login");
    pc.getChampByName("teluser").setLibelle("Téléphone");
    pc.getChampByName("adruser").setLibelle("Direction");
    
    MapUtilisateurLib map = (MapUtilisateurLib) pc.getBase();

    UserMenu user = new UserMenu();
    user.setNomTable("v_usermenu");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id", "idmenu"};
    PageRecherche pr = new PageRecherche(user, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("parametre/utilisateur-fiche.jsp");
    pr.setAWhere(" and refuser = '" + map.getRefuser() + "' and interdit != 1 ");
    String colSomme[] = null;
    pr.setNpp(1000);
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=parametre/utilisateur-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/utilisateur-modif.jsp&refuser=" + request.getParameter("refuser")%>" style="margin-right: 10px">Modifier</a>       
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
                        
    </div>
                        
    <div class="row">                         
        <section class="content-header">

        </section>
        <section class="content">

            <%
                String libEnteteAffiche[] = {"Id", "Idmenu"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                out.println(pr.getTableau().getHtml());
                

            %>
        </section>  

    </div>   
</div>

<%}catch(Exception e){
    e.printStackTrace();
}%>