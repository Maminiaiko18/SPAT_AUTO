<%-- 
    Document   : utilisateurInterim-fiche
    Created on : 7 nov. 2016, 14:28:20
    Author     : RAMARONERA
--%>

<%@page import="utilisateur.UtilisateurInterimLibTous"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageConsulte"%>
<%!
    UtilisateurInterimLibTous  interim;
    user.UserEJB u;
%>
<%
    interim = new UtilisateurInterimLibTous();
    
    u = (UserEJB) session.getValue("u");
    String[] libelleEvacuationFiche = {"Id", "Nom Utilisateur à remplacé", "Matricule Utilisateur à remplacé", "Nom Utilisateur Interim","Matricule Utilisateur Interim", "Fonction","Service","Direction","Etats"};
    PageConsulte pc = new PageConsulte(interim, request, (user.UserEJB) session.getValue("u"));
    pc.setLibAffichage(libelleEvacuationFiche);
    pc.setTitre("Utilisateur Interim");
   // pc.getChampByName("iduser").setVisible(true);
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=utilisateur/utilisateur-interim-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">

                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/apresUtilisateur.jsp&idUser=" + request.getParameter("id")%>&acte=activer&bute=utilisateur/utilisateurInterim-fiche.jsp&classe=utilisateur.UtilisateurInterim" style="margin-right: 10px">Activer</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/apresUtilisateur.jsp&idUser=" + request.getParameter("id")%>&acte=terminerInterim&bute=utilisateur/utilisateurInterim-fiche.jsp&classe=utilisateur.UtilisateurInterim" style="margin-right: 10px">Terminer</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/utilisateur-interim-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=utilisateur/interim-liste.jsp&classe=utilisateur.UtilisateurInterim" style="margin-right: 10px">Supprimer</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%out.println(pc.getBasPage());%>
</div>

