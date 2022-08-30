<%-- 
    Document   : transfert-caisse
    Created on : 16 janv. 2021, 00:42:39
    Author     : Sanda
--%>

<%@page import="mg.spat.MvttIntraCaisse"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="mg.spat.MvtIntraCaisseFille"%>
<%@page import="affichage.PageInsertMultiple"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "mg.spat.MvttIntraCaisse",classeFille = "mg.spat.MvtIntraCaisseFille",
            nomtable = "mvtintracaisse",nomTableFille = "mvtintracaisse_fille", 
            apres = "treso/transfert-caisse-fiche.jsp",colonneMere = "idmere",
            titre = "Transfert Caisse";
    int taille = 10;
    MvttIntraCaisse  objet = new MvttIntraCaisse();
    objet.setNomTable(nomtable);
    MvtIntraCaisseFille fille = new MvtIntraCaisseFille();
    fille.setNomTable(nomTableFille);
    PageInsertMultiple pi = new PageInsertMultiple(objet, fille, request, taille, u);
    pi.setLien((String) session.getValue("lien"));  
    
    if(request.getParameter("ids") != null){
        double somme = objet.calculerSomme(request.getParameter("ids"));
        pi.getFormu().getChamp("montant").setDefaut(Utilitaire.formaterAr(somme));
        if(objet.getListeJournal() != null){
            pi.getFormu().getChamp("caissedepart").setDefaut((objet.getListeJournal())[0].getCaisse());
            for(int i=0; i<(objet.getListeJournal()).length; i++){
                pi.getFormufle().getChamp("reference_"+i).setDefaut((objet.getListeJournal())[i].getNumcheque());
            }
        }
    }
    
    affichage.Champ[] liste = new affichage.Champ[3];
    Caisse liste1 = new Caisse();
    liste1.setNomTable("caisse");
    liste[0] = new Liste("caissedepart", liste1, "val", "id");
    liste[1] = new Liste("caissearrivee", liste1, "val", "id");
    TypeObjet liste2 = new TypeObjet();
    liste2.setNomTable("MODEPAIEMENT");
    liste[2] = new Liste("modepaiement", liste2, "val", "id");     
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("remarque").setVisible(false);
    pi.getFormu().getChamp("caissedepart").setLibelle("Départ");
    pi.getFormu().getChamp("caissearrivee").setLibelle("Arrivée");
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
    pi.getFormufle().getChamp("Reference_0").setLibelle("R&eacute;ference");
    pi.getFormufle().getChamp("Remarque_0").setLibelle("Remarque");
    pi.getFormufle().getChamp("Idmere_0").setVisible(false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
