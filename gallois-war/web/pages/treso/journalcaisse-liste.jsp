<%-- 
    Document   : journalcaisse-liste
    Created on : 6 nov. 2019, 15:02:52
    Author     : pro
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.JournalCaisseMivadika"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        JournalCaisse journalCaisse = new JournalCaisse();
        journalCaisse.setNomTable("JOURNALCAISSELIBCOMPLET");

        if (request.getParameter("etatvue") != null) {
            journalCaisse.setNomTable(request.getParameter("etatvue"));
        }

        String listeCrt[] = {"id","folio", "caisse", "libelle", "remarque", "dateEffet","idtypecheque","idplacement"};
        String listeInt[] = {"dateEffet"};
        String libEntete[] = {"id", "folio", "caisse","idtypecheque", "numPiece", "numcheque","libelle", "dateSaisie", "dateEffet", "credit", "debit","idplacement"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/journalcaisse-liste.jsp");
        pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        pr.getFormu().getChamp("libelle").setLibelle("Libellé");
        pr.getFormu().getChamp("idtypecheque").setLibelle("Type");
        String[] colSomme = {"credit", "debit"};
        pr.creerObjetPage(libEntete, colSomme);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste de journal caisses</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/journalcaisse-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="JOURNALCAISSELIBCOMPLET" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIBmiv") == 0) {
                                out.print("selected");
                            }%>>Tous</option>
                        <option value="JOURNALCAISSELIBCOMPLET_CREE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_CREE_miv") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;e</option>
                        <option value="JOURNALCAISSELIBCOMPLET_VISE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_vise_miv") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;</option>

                        
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>

        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="id">
            <input type="hidden" name="bute" value="treso/journalcaisse-liste.jsp"/>
            <input type="hidden" name="classe" value="mg.spat.JournalCaisse"/>
            <input type="hidden" name="acte" value="viser"/>
            <%                              
                String libEnteteAffiche[] = {"Id", "Folio", "Caisse","Type", "Num Piece", "num cheque", "Libellé", "Date Saisie", "Date Effet", "Entrée", "Sortie","Source"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                pr.getTableau().setNameBoutton("Viser");

                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
        </form>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
