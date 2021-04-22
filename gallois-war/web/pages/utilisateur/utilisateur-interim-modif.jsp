<%-- 
    Document   : subvention-modif
    Created on : 13 oct. 2016, 11:25:33
    Author     : hp
--%>

<%@page import="utilisateur.UtilisateurInterim"%>
<%@page import="mg.cnaps.pointage.PointAutorisation"%>
<%@page import="mg.cnaps.pointage.PointDroit"%>

<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    UtilisateurInterim a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new UtilisateurInterim();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_debut").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_fin").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("iduser_interim").setPageAppel("choix/utilisateurChoix.jsp");
    pi.getFormu().getChamp("iduser_a_remplacer").setPageAppel("choix/utilisateurChoix.jsp");
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("date_debut").setLibelle("D&eacute;but");
    pi.getFormu().getChamp("iduser_interim").setLibelle("Interim");
    pi.getFormu().getChamp("iduser_a_remplacer").setLibelle("Utilisateur à remplacer");
    
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'un utilisateur interim</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="pointautorisation">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="utilisateur/utilisateurInterim-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="utilisateur.UtilisateurInterim">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                            
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
