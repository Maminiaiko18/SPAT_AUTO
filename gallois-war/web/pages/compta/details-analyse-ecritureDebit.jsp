<%-- 
    Document   : datails-analyse-conventionnelMtht
    Created on : 9 déc. 2019, 12:16:05
    Author     : Antsa
--%>
<%@page import="mg.spat.compta.AnalyseEcriture"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        AnalyseEcriture ecriture = new AnalyseEcriture();
        ecriture.setNomTable("analyseecriture");

        String listeCrt[] = {"ec_no", "cg_num", "cg_intitule", "ec_refpiece", "ec_tresopiece", "ec_lettrage", "ec_date"};
        String listeInt[] = {"ec_date"};
        String libEntete[] = {"ec_no", "cg_num", "cg_intitule", "ec_refpiece", "ec_tresopiece", "ec_lettrage", "cg_type", "ec_date","debit"};

        PageRecherche pr = new PageRecherche(ecriture, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        //PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        /*pr.getFormu().getChamp("nmfact").setLibelle("Numero facture");
        pr.getFormu().getChamp("categorie_facture").setLibelle("Categorie facture");
        pr.getFormu().getChamp("categorie_client").setLibelle("Categorie client");
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");

        pr.getFormu().getChamp("numcompte").setLibelle("Numero de compte");*/
        pr.setApres("compta/analyse-ecriture.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Détails analyse écriture Débit</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/details-analyse-ecritureDebit.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp",pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp"};
            String lienTableau[] = {pr.getLien() + "?but=compta/details-analyse-ecritureDebit.jsp"};
            String colonneLien[] = {"ec_no"};
//String colonneLien[] = {"gain"};
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ec_no", "cg_num", "cg_intitule", "ec_refpiece", "ec_tresopiece", "ec_lettrage", "cg_type", "ec_date","debit"};
            //                               "nmfact" , "categorie_facture","sous_categorie_facture","categorie_client","daty","client","numCompte","designation","devfact","mttc","mtht","taxe","mtdevise","mtavoir","paye","reste"
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>