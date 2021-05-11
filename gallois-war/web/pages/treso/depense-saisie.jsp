
<%@page import="ded.OrdonnerPayement"%>
<%@page import="mg.spat.MvtcaisseOrdonnerpayementFacture"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.Caisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    JournalCaisse pj = new JournalCaisse();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));

    pi.getFormu().getChamp("datesaisie").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idordre").setDefaut(Utilitaire.champNull(request.getParameter("idordre")));
    pi.getFormu().getChamp("idordre").setAutre("readonly");
    pi.getFormu().getChamp("idordre").setLibelle("Ordre");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("idmode").setLibelle("Mode");
    pi.getFormu().getChamp("numcheque").setLibelle("Numero chèque");
    pi.getFormu().getChamp("typemvt").setLibelle("Type mouvement");
    pi.getFormu().getChamp("datesaisie").setVisible(false);
    pi.getFormu().getChamp("dateeffet").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("numpiece").setLibelle("Numero pièce");
    pi.getFormu().getChamp("credit").setVisible(false);
    pi.getFormu().getChamp("debit").setLibelle("Montant");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("dateeffet").setLibelle("Date effet");
    pi.getFormu().getChamp("idplacement").setAutre("readonly");
    pi.getFormu().getChamp("idplacement").setLibelle("Source");
    
    affichage.Champ[] liste = new affichage.Champ[3];
    Caisse esc = new Caisse();
    esc.setNomTable("caisse_banque");
    liste[0] = new Liste("caisse", esc, "VAL", "id");
    TypeObjet op = new TypeObjet();
    op.setNomTable("DEVISE");
    liste[1] = new Liste("iddevise", op, "desce", "id");
    TypeObjet mode = new TypeObjet();
    mode.setNomTable("MODEPAIEMENTCV");
    liste[2] = new Liste("idmode", mode, "desce", "id");    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("caisse").setLibelle("Banque");
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("Typemvt").setVisible(false);
    pi.getFormu().getChamp("numPiece").setVisible(false);
    pi.getFormu().getChamp("idtypecheque").setVisible(false);
//    pi.getFormu().getChamp("Idordre").setPageAppel("choix/listeOrdonnerPayementChoix.jsp");
    pi.getFormu().getChamp("Idordre").setPageAppel("choix/listeOrdonnerPayementChoix.jsp", "idordre;idordrelibelle;libelle;remarque;debit;idordrelibelle");
    pi.getFormu().getChamp("Idordre").setAutre("readonly");
    pi.getFormu().getChamp("Tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("Tiers").setAutre("readonly");
    pi.getFormu().getChamp("Idordre").setLibelle("Ordre");
    pi.getFormu().getChamp("Iddevise").setLibelle("devise");
    pi.getFormu().getChamp("idmode").setLibelle("Mode de paiement");
    
    if (request.getParameter("id") != null) {
        if (request.getParameter("id")!= null && request.getParameter("id").compareTo("") != 0){
            pi.getFormu().getChamp("idordre").setDefaut(request.getParameter("id"));
            MvtcaisseOrdonnerpayementFacture ordre = new MvtcaisseOrdonnerpayementFacture(request.getParameter("id"));
            ordre.setNomTable("JOURNALCAISSE_INFO");
            MvtcaisseOrdonnerpayementFacture preremplie = ordre.getOrdre(null);
            pi.getFormu().getChamp("idordre").setValeurLibelle(preremplie.getRemarque());
            pi.getFormu().getChamp("tiers").setValeurLibelle(preremplie.getTierslib());
            pi.getFormu().getChamp("tiers").setDefaut(preremplie.getTiers());
            pi.getFormu().getChamp("idmode").setDefaut(preremplie.getModepaiement());
            pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr(""+preremplie.getReste()));
        }
        OrdonnerPayement[] ord = (OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, null, " and id = '" + request.getParameter("id") + "'");
        if (ord.length > 0) {
            pi.getFormu().getChamp("libelle").setDefaut(ord[0].getRemarque());
            pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr(""+ord[0].getMontant()));
            pi.getFormu().getChamp("idordre").setDefaut(ord[0].getId());
            pi.getFormu().getChamp("idordre").setValeurLibelle(ord[0].getRemarque());
            pi.getFormu().getChamp("idmode").setDefaut(ord[0].getModepaiement());
        }
    }
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'une dépense</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="treso/recette-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.JournalCaisse">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>