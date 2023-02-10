<%@page import="facture.PaiementFactureLibJc"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="facture.FactureClient"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    String idfacture = request.getParameter("idFC");
    String idtraite = request.getParameter("idTraite");


    PaiementFactureLibJc paiementFactureLib = new PaiementFactureLibJc();
    paiementFactureLib.setNomTable("paiementfacturelibjc");
    String[] listCrt = {};
    String[] listInt = {};
    String libEntete[] = {"idmvt", "montant","dateeffet","remarque","caisse","modepaiement","tiers"};
    String[] colSomme = null;
    PageRecherche paiements = new PageRecherche(paiementFactureLib, request, listCrt, listInt, 2, libEntete, libEntete.length);
    paiements.setUtilisateur((user.UserEJB) session.getValue("u"));
    paiements.setLien((String) session.getValue("lien"));
    paiements.setApres("facture/liste-paiementfacture-multiple.jsp");
    paiements.setAWhere(" AND idmode in ('pay6')  AND idfact = '" + idfacture + "' AND idtraite is null");
    paiements.creerObjetPage(libEntete, colSomme);
    String popupLink = "choix/traiteChoix.jsp?traite=true&champReturn=idTraite;idTraitelibelle&amp;apresLienPageAppel=";
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Attacher paiement traite à la facture</h1>
    </section>
         <form action="<%=paiements.getLien()%>?but=apresPaiementFactureTraite.jsp" method="post" name="paiementfacture" id="paiementfacture">
            <input type="hidden" name="bute" value="facture/factureclient-fiche-vaovao.jsp&id=<%=idfacture%>&id=<%=idfacture%>"/>
            <input type="hidden" name="acte" value="attacher"/>
            <div class="form-group row">
                <div class="col-md-3">
                    <label for="idTraite">Traite</label>
                    <input name="idTraitelibelle" type="textbox" class="form-control" id="idTraitelibelle" value="<%=idtraite%>" readonly="" data-parsley-id="4">
                    <input type="hidden" value="" name="idTraite" id="idTraite">
                    <input name="choix" type="button" class="submit" onclick="pagePopUp('<%= popupLink %>')" value="..." tabindex="1">
                </div>
                
                
            </div>
            <%
                String libEntetePaiement[] = {"id", "Montant","Date Effet","Remarque","Caisse","Mode de paiement","Tiers"};
                paiements.getTableau().setLibelleAffiche(libEntetePaiement);
                paiements.getTableau().setNameActe("attacher");
                paiements.getTableau().setNameBoutton("Attacher");
                out.println(paiements.getTableau().getHtmlWithCheckbox());
            %>
         </form>
</div>
