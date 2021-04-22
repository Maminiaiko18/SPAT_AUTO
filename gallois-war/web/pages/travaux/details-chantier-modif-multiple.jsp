<%--<%@page import="sousmission.Sousmission"%>
<%@page import="mg.fer.RecapSoumission"%>--%>
<%@page import="detailschantier.DetailChantier"%>
<!--recapsoumission no aseo fa soumission no any ambany-->


<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRechercheUpdate"%>

<%
        UserEJB u = (UserEJB) session.getAttribute("u");
        
        DetailChantier a = new DetailChantier();
        a.setNomTable("detailChantier");
        String listeCrt[] = {"id","mere"};
        String listeInt[] = {};
        String libEntete[] = {"id","idelement","qte","pu","mere"};

        PageRechercheUpdate pr = new PageRechercheUpdate(a, request, listeCrt, listeInt, 3, libEntete, "id");

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("travaux/details-chantier-modif-multiple.jsp");
        pr.getFormuLigne().getChamp("mere").setAutre("readonly");
        
        String[] colSomme = null;

        pr.setNpp(300);

        pr.creerObjetPage(libEntete, colSomme);

        int nombreLigne = pr.getTableau().getData().length;
%>
<style>
    #modif-form th{
        background-color: black !important;
        font-size : 13px;
    }
    #modif-form th a{
        color: white !important;
    }
</style>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Modification multiple soumission</h1>
    </section>
    <section class="content">
<!--        <form action="<%=pr.getLien()%>?but=marche/soumission-modif-multiple.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>-->

        <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" id='modif-form' method="post" data-parsley-validate>
            <%
//                String libEnteteAffiche[] = {"Id", "Date depot", "Montant","Note technique","Note financiere","Note autre","Coefficient techique","Coefficient financiere","Coefficient autre","Note globale","marche", "Prestataire", "Etat"};
                String libEnteteAffiche[] = {"Identifiant", "idelement","Quantité","Prix unitaire","Chantier"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                out.println(pr.getTableau().getHtmlWithCheckboxUpdateMultiple());
 
            %>
            <input name="acte" type="hidden" id="acte" value="updateMultiple">
            <input name="bute" type="hidden" id="bute" value="travaux/details-chantier-modif-multiple.jsp&mere=<%=request.getParameter("mere")%>">
            <input name="classe" type="hidden" id="classe" value="detailschantier.DetailChantier">
            <input name="nombreLigne" type="hidden" id="nomtable" value="<%=nombreLigne%>">
            <input name="valider_attribuer" class="btn btn-primary" type="submit" id="valider_attribuer"  value="Valider et attribuer">
            <input name="valider" class="btn btn-primary" type="submit" id="valider"  value="Valider">
        </form>
    </section>
</div>
