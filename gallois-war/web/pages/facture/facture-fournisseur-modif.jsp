<%@page import="mg.spat.Tva"%>
<%@page import="facturefournisseur.FactureFournisseur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureFournisseur facturefrs = new FactureFournisseur();

    PageUpdate pi = new PageUpdate(facturefrs, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet op = new TypeObjet();
    op.setNomTable("DEVISEDEMAT");
    liste[0] = new Liste("iddevise", op, "desce", "id");
//        Tva tva = new Tva();
//        liste[1] = new Liste("idtva", tva, "valeurtva", "valeurtva");    
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("exercice").setDefaut(Utilitaire.getAnneeEnCours());
    pi.getFormu().getChamp("idfournisseur").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("idfournisseur").setAutre("readonly");
    pi.getFormu().getChamp("remarque").setPageAppel("choix/listeChantierChoix.jsp");
    pi.getFormu().getChamp("remarque").setAutre("readonly");
    pi.getFormu().getChamp("datyecheance").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("dateemission").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("budget").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idtva").setVisible(false);
    pi.getFormu().getChamp("montantttc").setVisible(false);
    pi.getFormu().getChamp("resp").setVisible(false);
    pi.getFormu().getChamp("Numeroop").setVisible(false);
    pi.getFormu().getChamp("idfacturefournisseur").setVisible(false);
    pi.getFormu().getChamp("numfact").setLibelle("Numéro Facture");
    pi.getFormu().getChamp("remarque").setLibelle("Chantier");
    pi.getFormu().getChamp("remarque").setVisible(false);
    pi.getFormu().getChamp("budget").setLibelle("Budget");
    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("dateemission").setLibelle("Date d'émission");
    pi.getFormu().getChamp("datyecheance").setLibelle("Date d'échéance");
    pi.getFormu().getChamp("montantdevise").setLibelle("Montant Devise");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idfournisseur").setLibelle("Fournisseur");
    pi.getFormu().getChamp("numid").setLibelle("Numéro Compta");
    pi.getFormu().getChamp("numeroop").setVisible(false);
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("code_etablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    pi.getFormu().getChamp("code_etablissement").setAutre("readonly");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <!--<div class="box-fiche">-->
            <div class="box">
                <h1>Modification facture mere</h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                    <%
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <div class="row">
                        <div class="col-md-11">
                            <button class="btn btn-warning pull-right" name="Submit2" type="submit">Modifier les modifications</button>
                        </div>
                        <br><br> 
                    </div>
                    <input name="acte" type="hidden" id="acte" value="update">
                    <input name="bute" type="hidden" id="bute" value="facture/facture-fournisseur-fiche.jsp&id=<%=request.getParameter("id")%>">
                    <input name="classe" type="hidden" id="classe" value="facturefournisseur.FactureFournisseur">
                </form>
            </div>
            <!--</div>-->
        </div>
    </div>
</div>

