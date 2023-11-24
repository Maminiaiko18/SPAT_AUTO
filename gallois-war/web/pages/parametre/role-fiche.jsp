<%-- 
    Document   : conge-permission-fiche
    Created on : 30 nov. 2019, 09:10:45
    Author     : Tin
--%>
<%@page import="utilisateur.Role"%>
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
    try {

        Role map = new Role();
        PageConsulte pc = new PageConsulte(map, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.setTitre("Fiche Role");
        String dossier = "parametre";
        pc.getChampByName("idrole").setLibelle("Id role");
        pc.getChampByName("descrole").setLibelle("Description role");

        UserMenu user = new UserMenu();
        user.setNomTable("v_usermenu");
        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id", "idmenu"};
        PageRecherche pr = new PageRecherche(user, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("parametre/role-fiche.jsp");
        pr.setAWhere(" and idrole='"+map.getIdrole()+"' and interdit != 1 ");
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
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=parametre/role-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=parametre/roles-modif.jsp&idrole=" + request.getParameter("idrole")%>" style="margin-right: 10px">Modifier</a>                              

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
                if(pr.getTableau().getHtml() != null){
                    out.println(pr.getTableau().getHtml());
                }
                else{
            %>
            <center>Aucun r&eacute;sultat</center>
        </section>  
    </div>   
</div>

<%}} catch (Exception e) {
        e.printStackTrace();
    }%>