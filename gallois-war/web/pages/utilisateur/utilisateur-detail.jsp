<%-- 
    Document   : utilisateur-detail
    Created on : 6 déc. 2016, 15:43:46
    Author     : Jetta
--%>
<%@page import="affichage.Liste"%>
<%@page import="mg.cnaps.log.LogService"%>
<%@page import="mg.cnaps.utilisateur.UtilisateurDetail"%>
<%@page import="affichage.PageRecherche"%> 
<% UtilisateurDetail dr = new UtilisateurDetail();
    String listeCrt[] = {"login", "nom", "matricule", "fonction","service_actuel"};
    String listeInt[] = null;
    String libEntete[] = {"login", "nom", "matricule", "fonction","service_actuel"};
    PageRecherche pr = new PageRecherche(dr, request, listeCrt, listeInt, 3, libEntete, 5);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("utilisateur/utilisateur-detail.jsp");
    String[] colSomme = null;
     
    affichage.Champ[] liste=new affichage.Champ[1];
    LogService m= new LogService();
    liste[0]=new Liste("service_actuel",m,"libelle","libelle");
    
    pr.getFormu().changerEnChamp(liste);
    pr.creerObjetPage(libEntete, colSomme);%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Utilisateur avec son login</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/utilisateur-detail.jsp" method="post" name="listedirection" id="listeUtilisateur">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
           
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Login", "Nom et prenom", "Matricule", "fonction","Service"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>