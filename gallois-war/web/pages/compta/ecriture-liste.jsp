<%-- 
    Document   : ecriture-liste
    Created on : 15 nov. 2019, 17:41:37
    Author     : john
--%>

<%@page import="mg.spat.compta.FEcritureC"%>
<%@page import="mg.spat.compta.ComptaSousEcriture"%>
<%@page import="mg.spat.compta.ComptaConsulEcriture4446"%>
<%@page import="mg.spat.compta.ComptaConsulEcriture"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.spat.compta.ComptaSousEcritureInfo"%> 
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        FEcritureC journalCaisse = new FEcritureC();
        journalCaisse.setNomTable("F_ECRITURECMAT");
        String listeCrt[] = {"jo_num","cbjo_num","ec_piece","cbec_piece","ec_refpiece","cbec_refpiece","ec_tresopiece","cg_num","cbcg_num","cg_numcont","ct_num","cbct_num","ec_intitule","ec_lettrage","ec_pointage","ct_numcont","ta_code","cbta_code","ec_reference","cbcreateur","ec_echeance","ec_datepenal","ec_daterelance","ec_daterappro","ec_dateregle","ec_dateop","ec_factureguid","ec_datecloture"};
        String listeInt[] = {"ec_echeance","ec_datepenal","ec_daterelance","ec_daterappro","ec_dateregle","ec_dateop","ec_factureguid","ec_datecloture"};
        String libEntete[] = {"jo_num","cbjo_num","ec_piece","cbec_piece","ec_refpiece","cbec_refpiece","ec_tresopiece","cg_num","cbcg_num","cg_numcont","ct_num","cbct_num","ec_intitule","ec_lettrage","ec_pointage","ct_numcont","ta_code","cbta_code","ec_reference","cbcreateur","ec_no","ec_nolink","jm_date","ec_jour","ec_date","n_reglement","ec_parite","ec_quantite","n_devise","ec_sens","ec_montant","ec_lettre","ec_point","ec_impression","ec_cloture","ec_ctype","ec_rappel","ec_lettreq","ec_antype","ec_rtype","ec_devise","ec_remise","ec_exportexpert","ec_norme","ta_provenance","ec_penaltype","ec_statusregle","ec_montantregle","ec_rib","ec_nocloture","ec_exportrappro","cbprot","cbmarq","cbmodification","cbreplication","cbflag","ec_echeance","ec_datepenal","ec_daterelance","ec_daterappro","ec_dateregle","ec_dateop","ec_factureguid","ec_datecloture"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("/ecriture-liste.jsp");
        /*pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");*/
        String[] colSomme = {"debit","credit"};
        pr.creerObjetPage(libEntete, colSomme);
        
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste de journal caisses</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/ecriture-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=compta/ecriture-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
         
        <%
            String libEnteteAffiche[] ={"Id","Compte","Remarque","LibellePiece","Mere","Reference_engagement","Compte_aux","Lettrage","Journal","Exercice","Folio","Analytique","Date","Debit","Credit"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>

        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
