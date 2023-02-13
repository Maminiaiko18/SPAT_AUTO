<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="mg.spat.JournalCaisseMivadika"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%
    try {
        String typecheque = request.getParameter("idtypecheque");
        JournalCaisseLibComplet journalCaisse = new JournalCaisseLibComplet();
        journalCaisse.setNomTable("etatjournalcaisselibrecette");

        if (request.getParameter("etatvue") != null) {
            journalCaisse.setNomTable(request.getParameter("etatvue"));
        }

        String listeCrt[] = {"id", "folio", "valcaisse", "libelle", "remarque", "dateEffet", "idtypecheque", "idplacement", "descecaisse", "numeroOP", "tierslib","idbanquelib","numPiece"};
        String listeInt[] = {"dateEffet"};
        String libEntete[] = {"id", "folio", "valcaisse", "descetypecheque", "numPiece", "numcheque", "libelle", "dateSaisie", "dateEffet", "credit", "debit", "idplacement", "numeroOP", "tierslib","codetiers","idbanquelib"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/journalcaisserecette-liste.jsp");

        Liste[] listes = new Liste[2];
        listes[0] = new Liste("descecaisse", new String[]{"Tous", "Caisse", "Banque"}, new String[]{"", "Caisse", "Banque"});

        TypeObjet typeCheque = new TypeObjet();
        typeCheque.setNomTable("typecheque");
        listes[1] = new Liste("idtypecheque", typeCheque, "val", "id");

        pr.getFormu().changerEnChamp(listes);
        pr.getFormu().getChamp("descecaisse").setLibelle("Bureau");
        pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        pr.getFormu().getChamp("libelle").setLibelle("Libellé");
        pr.getFormu().getChamp("valcaisse").setLibelle("Caisse");
        pr.getFormu().getChamp("valcaisse").setDefaut("RECETTES");
        pr.getFormu().getChamp("idtypecheque").setLibelle("Type");
        pr.getFormu().getChamp("numeroOP").setLibelle("Num&eacute;ro OP");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("idbanquelib").setLibelle("Banque");
        String[] colSomme = {"credit", "debit"};
        pr.creerObjetPage(libEntete, colSomme);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Journal de caisse RECETTE</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/journalcaisserecette-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="JOURNALCAISSELIB_SANSPROV" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_SANSPROV") == 0) {
                                out.print("selected");
                            }%>>Recettes sans provisions</option>
                        <option value="JOURNALCAISSELIB_PROVISION" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_PROVISION") == 0) {
                                out.print("selected");
                            }%>>Provisions</option>
                        <option value="JOURNALCAISSELIB_TOUS" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_TOUS") == 0) {
                                out.print("selected");
                            }%>>Tous</option>
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

        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="journal-caisse-liste">
            <input type="hidden" name="bute" value="treso/journalcaisserecette-liste.jsp"/>
            <input type="hidden" name="classe" value="mg.spat.JournalCaisse"/>
            <input type="hidden" name="acte" value="viser"/>
            <%
                String libEnteteAffiche[] = {"Id", "Folio", "Caisse", "Type", "Num Piece", "num cheque", "Libellé", "Date Saisie", "Date Effet", "Entrée", "Sortie", "Source", "Num&eacute;ro OP", "Tiers","Codetiers","Banque"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                pr.getTableau().setNameBoutton("Viser");

                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
            <%
                if (typecheque != null && typecheque.compareToIgnoreCase("%") == 0) {
                    typecheque = "";
                }
            %>
            <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=listeJournalCaisse&id=<%=request.getParameter("id")%>&folio=<%=request.getParameter("folio")%>&valcaisse=<%=request.getParameter("valcaisse")%>&libelle=<%=request.getParameter("libelle")%>&remarque=<%=request.getParameter("remarque")%>&dateEffet1=<%=request.getParameter("dateEffet1")%>&dateEffet2=<%=request.getParameter("dateEffet2")%>&idtypecheque=<%= typecheque%>&descecaisse=<%=request.getParameter("descecaisse")%>&idplacement=<%= request.getParameter("idplacement")%>&etat=<%= request.getParameter("etatvue")%>" style="margin-right: 10px">Imprimer</a>
            <a class="btn btn-primary pull-right"  href="${pageContext.request.contextPath}/pages/globalnegoce.jsp?but=treso/journalcaisse-saisie.jsp&caisse=CAISSERECETTE" style="margin-right: 10px">Saisie Journal Caisse</a>
        </form>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<script>
    const form = document.getElementById('journal-caisse-liste');
    const footer = form.getElementsByClassName('box-footer')[0];
    const button = footer.getElementsByTagName('button')[0].cloneNode();
    button.innerHTML = 'Transferer';
    button.onclick = function (e) {
//        e.preventDefault();
        form.action = '<%=pr.getLien()%>?but=apresFacture.jsp';
        form.querySelector('[name="acte"]').value = 'transfert';
        form.querySelector('[name="bute"]').value = ' treso/transfert-caisse.jsp';
    }
    footer.append(button);
</script>
<% } catch (Exception e) {
        e.printStackTrace();

    }%>