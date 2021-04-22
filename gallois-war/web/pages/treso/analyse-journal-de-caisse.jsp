a<%-- 
    Document   : analyse-journal-de-caisse
    Created on : 2 d�c. 2019, 08:22:05
    Author     : Antsa
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try {
        JournalCaisse journal = new JournalCaisse();
        journal.setNomTable("journalcaisselib_Analyse");

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"id", "folio", "caisse", "numpiece", "libelle", "remarque", "datesaisie"};
        // String libEntete[] = {"id", "datesaisie", "dateeffet","folio", "caisse", "numpiece", "libelle", "remarque", "datesaisie", "dateeffet"};
        String listeInt[] = {"datesaisie"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id", "datesaisie", "dateeffet", "folio", "caisse", "numpiece", "libelle", "remarque"};
        String somDefaut[] = {"debit", "credit"};

        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 10, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("datesaisie1").setDefaut(fin[0]);
        pr.getFormu().getChamp("datesaisie2").setDefaut(fin[1]);
        // pr.getFormu().getChamp("dateeffet1").setDefaut(fin[0]);
        //pr.getFormu().getChamp("dateeffet2").setDefaut(fin[1]);

        pr.getFormu().getChamp("datesaisie1").setLibelle("Date saisie min");
        pr.getFormu().getChamp("datesaisie2").setLibelle("Date saisie max");
        //pr.getFormu().getChamp("dateeffet1").setLibelle("Date effet min");
        //pr.getFormu().getChamp("dateeffet2").setLibelle("Date effet max");

        pr.getFormu().getChamp("numpiece").setLibelle("Numero pi&egrave;ce");

        pr.setApres("treso/analyse-journal-de-caisse.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyses journal de caisse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
           <input type="hidden" name="but" value="treso/analyse-journal-de-caisse.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            // String libEnteteAffiche[] = {"Id", "Date de saisie", "Date effet", "Folio", "Caisse", "Num�ro pi�ce", "Libelle", "Remarque", "D�bit", "Cr�dit"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");
            String lienTableau[]
                    = {pr.getLien() + "?but=treso/details-analyse-journalCaisseDebit.jsp",
                        pr.getLien() + "?but=treso/details-analyse-journalCaisseCredit.jsp"
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