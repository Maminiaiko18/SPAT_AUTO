<%--<%@page import="sousmission.Sousmission"%>
<%@page import="mg.fer.RecapSoumission"%>--%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="detailschantier.DetailChantier"%>
<!--recapsoumission no aseo fa soumission no any ambany-->


<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRechercheUpdate"%>

<%
        UserEJB u = (UserEJB) session.getAttribute("u");
        
        BonDeCommandeFille a = new BonDeCommandeFille();
        String listeCrt[] = {"id","idbc","unite"};
        String listeInt[] = {};
        String libEntete[] = {"id","produit","quantite","unite","pu","idbc"};

        PageRechercheUpdate pr = new PageRechercheUpdate(a, request, listeCrt, listeInt, 3, libEntete, "id");

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("stock/bc/bon-commande-modif-multiple.jsp");
        pr.getFormuLigne().getChamp("idbc").setAutre("readonly");
        pr.getFormuLigne().getChamp("unite").setAutre("readonly");
        
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
        <h1>Modification détails BC</h1>
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
                String libEnteteAffiche[] = {"id","Produit","Quantite","Unité","PU","BC"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                out.println(pr.getTableau().getHtmlWithCheckboxUpdateMultiple());
 
            %>
            <input name="acte" type="hidden" id="acte" value="updateMultiple">
            <input name="bute" type="hidden" id="bute" value="stock/bc/asBonDeCommande-fiche.jsp&id=<%=request.getParameter("idbc")%>">
            <input name="classe" type="hidden" id="classe" value="mg.spat.stock.BonDeCommandeFille">
            <input name="nombreLigne" type="hidden" id="nomtable" value="<%=nombreLigne%>">
        </form>
    </section>
</div>
