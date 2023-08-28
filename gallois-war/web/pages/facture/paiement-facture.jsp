<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="mg.spat.JournalCaisseMivadika"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="utilitaire.Constante"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%
    try {
        String typecheque = request.getParameter("idtypecheque");
        JournalCaisseLibComplet journalCaisse = new JournalCaisseLibComplet();
        journalCaisse.setNomTable("Paiementfactureclient");

        if (request.getParameter("etatvue") != null) {
            journalCaisse.setNomTable(request.getParameter("etatvue"));
        }

     //   System.out.println("tablename"+journalCaisse.getNomTable());
        String listeCrt[] = {"id", "caisse", "numpiece", "libelle", "DATEEFFET", "codefacture", "tierslib","idbanquelib","DESCETYPECHEQUE","idtypecheque","datesaisie"};
        String listeInt[] = {"dateEffet","datesaisie"};
        String libEntete[] = {"id","datesaisie","DATEEFFET","valcaisse","numpiece","libelle","CREDIT","TIERSLIB","VALTYPECHEQUE","DESCETYPECHEQUE","NUMCHEQUE","CODETIERS","IDBANQUELIB","MONTANT","CODEFACTURE","CATEGORIELIB"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/paiement-facture.jsp");

        Liste[] listes = new Liste[3];
        TypeObjet caisse = new TypeObjet();
        caisse.setNomTable("caisse");
        listes[0] = new Liste("caisse", caisse, "val", "id");

        TypeObjet cheque = new TypeObjet();
        cheque.setNomTable("MODEPAIEMENTBQ");
        listes[1] = new Liste("DESCETYPECHEQUE", cheque, "VAL", "val");

        TypeObjet typeCheque = new TypeObjet();
        typeCheque.setNomTable("typecheque");
        listes[2] = new Liste("idtypecheque", typeCheque, "val", "id");

        pr.getFormu().changerEnChamp(listes);
        
      //  pr.getFormu().getChamp("descecaisse").setLibelle("Bureau");
//        pr.getFormu().getChamp("dateEffet1").setDefaut("01/01/"+Utilitaire.getAnnee(Utilitaire.dateDuJourSql()););
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        pr.getFormu().getChamp("dateSaisie1").setLibelle("Date saisie min");
        pr.getFormu().getChamp("dateSaisie2").setLibelle("Date saisie max");
        //pr.getFormu().getChamp("valcaisse").setDefaut("RECETTES");
       // pr.getFormu().getChamp("idtypecheque").setLibelle("Type");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("numpiece").setLibelle("Numero Piece");
        pr.getFormu().getChamp("codefacture").setLibelle("Code facture");
        pr.getFormu().getChamp("idbanquelib").setLibelle("Banque");
        pr.getFormu().getChamp("DESCETYPECHEQUE").setLibelle("Mode paiement");
        pr.getFormu().getChamp("Idtypecheque").setLibelle("Type");

        pr.setOrdre(" order by dateeffet desc");

        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete, colSomme);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Paiement Facture client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/paiement-facture.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>

        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="journal-caisse-liste">
            <input type="hidden" name="bute" value="facture/paiement-facture.jsp"/>
            <input type="hidden" name="classe" value="mg.spat.JournalCaisse"/>
            <input type="hidden" name="acte" value="viser"/>
            <%
                String libEnteteAffiche[] = {"Id","Date saisie","Date effet","Caisse","Numero piece","Libelle","Credit","Tiers","Type","Mode de paiement","Num cheque","Code Tiers","Banque","Montant","Code facture","Categorie"};
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
        form.querySelector('[name="bute"]').value = ' facture/paiement-facture.jsp';
    }
    footer.append(button);
</script>
<% } catch (Exception e) {
        e.printStackTrace();

    }%>