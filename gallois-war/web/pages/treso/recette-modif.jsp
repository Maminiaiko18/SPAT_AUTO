
<%@page import="mg.spat.Caisse"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    JournalCaisse pj = new JournalCaisse();
    PageUpdate pi = new PageUpdate(pj, request, (user.UserEJB) session.getValue("u"));
     pi.getFormu().getChamp("idTypeCheque").setVisible(false);
        pi.getFormu().getChamp("numpiece").setVisible(false);
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeClientChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
//        pi.getFormu().getChamp("datesaisie").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("datesaisie").setVisible(false);
//        pi.getFormu().getChamp("dateeffet").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("numcheque").setLibelle("Numero du cheque");

        pi.getFormu().getChamp("debit").setVisible(false);
        pi.getFormu().getChamp("credit").setLibelle("Montant du chèque");
        pi.getFormu().getChamp("remarque").setDefaut(" ");
        // pi.getFormu().getChamp("tiers").setLibelle("Client émetteur");
        pi.getFormu().getChamp("idordre").setVisible(false);
        pi.getFormu().getChamp("tiers").setLibelle("Client emetteur");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("dateeffet").setLibelle("Date effet");
        pi.getFormu().getChamp("typemvt").setVisible(false);
        pi.getFormu().getChamp("idplacement").setAutre("readonly");
        pi.getFormu().getChamp("idplacement").setLibelle("Source");

        affichage.Champ[] liste = new affichage.Champ[3];
        Caisse esc = new Caisse();
        esc.setNomTable("caisse_banque");
        liste[0] = new Liste("caisse", esc, "VAL", "id");

        TypeObjet op = new TypeObjet();
        op.setNomTable("DEVISEDEMAT");
        liste[1] = new Liste("iddevise", op, "desce", "id");
        TypeObjet mode = new TypeObjet();
        mode.setNomTable("MODEPAIEMENTCV");
        liste[2] = new Liste("idmode", mode, "desce", "id");

        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("caisse").setLibelle("Banque");
        pi.getFormu().getChamp("iddevise").setLibelle("Devise");
        pi.getFormu().getChamp("idmode").setLibelle("mode de paiement");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification recette</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="treso/recette-fiche.jsp&type=<%=request.getParameter("type")%>">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.JournalCaisse">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="journalcaisse">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

