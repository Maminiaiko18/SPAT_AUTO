<%-- 
    Document   : prioritaire-saisie
    Created on : 4 sept. 2023, 13:56:59
    Author     : Valiah Karen
--%>

<%@page import="utilisateur.Prioritaire"%>
<%@page import="user.*"%> 
<%@ page import="bean.TypeObjet" %>
<%@page import="affichage.*"%>
<%@page import="affichage.Liste"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    try{
        
    
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Prioritaire a = new Prioritaire();
    a.setNomTable("prioritaire");
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("refuser").setPageAppel("choix/listeUtilisateurChoix.jsp");
    pi.getFormu().getChamp("refuser").setAutre("readonly");
    pi.getFormu().getChamp("refuser").setLibelle("Utilisateur");

    pi.getFormu().getChamp("idrole").setPageAppel("choix/listeRoleChoix.jsp");
    pi.getFormu().getChamp("idrole").setAutre("readonly");
    pi.getFormu().getChamp("idrole").setLibelle("Role");
    pi.getFormu().getChamp("idrole").setVisible(false);

    pi.getFormu().getChamp("etat").setVisible(false);

    Liste[] listes = new Liste[1];
        String[] avecFactureAff = {"oui","non"};
        String[] avecFactureVal = {"1", "0"};
        listes[0] = new Liste("rang", avecFactureAff, avecFactureVal);
    pi.getFormu().changerEnChamp(listes);
    pi.getFormu().getChamp("rang").setLibelle("Tous");


    pi.preparerDataFormu();

%><div class="content-wrapper">
    <h1>Saisie prioritaire</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="prioritaire/prioritaire-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="utilisateur.Prioritaire">
    </form>
</div>
<%
    } catch(Exception ex){
        ex.printStackTrace();
    }
%>dcsd