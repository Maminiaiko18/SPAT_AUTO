<%-- 
    Document   : analyse-ecriture
    Created on : 15 nov. 2019, 09:08:51
    Author     : john
--%>

<%@page import="mg.spat.compta.AnalyseEcriture"%>
<%@page import="mg.spat.AnalyseMouvement"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        AnalyseEcriture ecriture = new AnalyseEcriture();
        ecriture.setNomTable("analyseecriture_analyse");
        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String fin = String.valueOf(utilitaire.Utilitaire.getNombreJourMois(mois, an));

        String listeCrt[] = {"ec_no", "cg_num", "cg_intitule", "ec_refpiece", "ec_tresopiece", "ec_lettrage", "ec_date"};
        String listeInt[] = {"ec_date"};
        String[] pourcentage = {""};
        String colDefaut[] = {"ec_no", "cg_num", "cg_intitule",  "ec_tresopiece", "ec_lettrage", "cg_type", "ec_date"};
        String somDefaut[] = {"debit", "credit"};

        PageRechercheGroupe pr = new PageRechercheGroupe(ecriture, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 10, 2);

        pr.getFormu().getChamp("ec_date1").setLibelle("Date début");
        pr.getFormu().getChamp("ec_date2").setLibelle("Date fin");
        pr.getFormu().getChamp("ec_date1").setDefaut("01/" + mois + "/" + an);
        pr.getFormu().getChamp("ec_date2").setDefaut(fin + "/" + mois + "/" + an);
        pr.getFormu().getChamp("ec_no").setLibelle("Numéro interne");
        pr.getFormu().getChamp("cg_num").setLibelle("Compte Générale");
        pr.getFormu().getChamp("cg_intitule").setLibelle("Intitulé");
        pr.getFormu().getChamp("ec_refpiece").setLibelle("Numéro de facture");
        pr.getFormu().getChamp("ec_tresopiece").setLibelle("Pièce de Trésorerie");
        pr.getFormu().getChamp("ec_lettrage").setLibelle("Lettrage");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        // pr.setAWhere(" order by depart, arrivee");
        pr.setApres("compta/analyse-ecriture.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse ecriture</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="compta/analyse-ecriture.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String lienTableau[]
                    = {pr.getLien() + "?but=facturation/details-analyse-ecritureDebit.jsp",
                        pr.getLien() + "?but=facturation/details-analyse-ecritureCredit.jsp"
                    };
             pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(somDefaut);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

