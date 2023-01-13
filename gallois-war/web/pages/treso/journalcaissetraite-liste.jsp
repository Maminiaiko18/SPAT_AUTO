<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.JournalCaisseMivadika"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        JournalCaisse journalCaisse = new JournalCaisse();
        journalCaisse.setNomTable("JOURNALCAISSE_TR");
        String listeCrt[] = {"id","folio", "libelle", "remarque", "dateEffet","idtypecheque","idplacement"};
        String listeInt[] = {"dateEffet"};
        String libEntete[] = {"id", "folio","idtypecheque", "numPiece", "numcheque","libelle", "dateSaisie", "dateEffet", "credit", "debit","idplacement"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/journalcaissetraite-liste.jsp");
        if(request.getParameter("dateEffet1") == null || request.getParameter("dateEffet2") == null){
            pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
            pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
            
        }
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        pr.getFormu().getChamp("libelle").setLibelle("Libellé");
        pr.getFormu().getChamp("idtypecheque").setLibelle("Type");
        String[] colSomme = {"debit"};
        pr.creerObjetPage(libEntete, colSomme);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Journal Traite</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/journalcaissetraite-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            
        </form>

        <%  
            /*String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());*/
        %>
        <br/>

        <%
            String libEnteteAffiche[] = {"Id", "Folio","Type", "Num Piece", "num cheque", "Libellé", "Date Saisie", "Date Effet", "Entrée", "Sortie","Source"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
