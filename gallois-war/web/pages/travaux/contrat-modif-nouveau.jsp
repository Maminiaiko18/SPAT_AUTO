<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>
<%@page import="mg.spat.Contrat"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Contrat t = new Contrat();
    t.setNomTable("CONTRATLIBCPLT");
    PageUpdate pi = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    t = (Contrat)pi.getBase();

    affichage.Liste[] listes = new affichage.Liste[1];

    TypeObjet type = new TypeObjet();
    type.setNomTable("unitecontrat");
    listes[0] = new Liste("unite", type, "VAL", "id");

    pi.getFormu().changerEnChamp(listes);
 
    pi.getFormu().getChamp("idchantier").setPageAppel("choix/listeChantierChoix.jsp");
    pi.getFormu().getChamp("idchantier").setAutre("readonly");
    pi.getFormu().getChamp("idchantier").setValeurLibelle(t.getChantierlib());
    pi.getFormu().getChamp("idtiers").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("idtiers").setAutre("readonly");
    pi.getFormu().getChamp("idtiers").setValeurLibelle(t.getNom());
    pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
    pi.getFormu().getChamp("codeetablissement").setValeurLibelle(t.getCodeetablissementlib());
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("projet").setValeurLibelle(t.getCodeprojetlib());
    pi.getFormu().getChamp("idLC").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLC;idLClibelle;idLClibelle;idLClibelle");
    pi.getFormu().getChamp("idLC").setAutre("readonly");
    pi.getFormu().getChamp("idLC").setValeurLibelle(t.getLclib());

    pi.getFormu().getChamp("nom").setVisible(false);
    pi.getFormu().getChamp("montant").setVisible(false);
    pi.getFormu().getChamp("chantierlib").setVisible(false);
    pi.getFormu().getChamp("codeprojetlib").setVisible(false);
    pi.getFormu().getChamp("codeetablissementlib").setVisible(false);
    pi.getFormu().getChamp("typeduree").setVisible(false);
    pi.getFormu().getChamp("valunite").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("lclib").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    pi.getFormu().getChamp("idavenant").setVisible(false);
    pi.getFormu().getChamp("fin_avenant").setVisible(false);
    pi.getFormu().getChamp("montantpaye").setVisible(false);
    pi.getFormu().getChamp("annee").setVisible(false);
    
    pi.getFormu().getChamp("idchantier").setLibelle("Chantier");
    pi.getFormu().getChamp("idtiers").setLibelle("Tiers");
    pi.getFormu().getChamp("date_signature").setLibelle("Date signature");
    pi.getFormu().getChamp("debut_contrat").setLibelle("D&eacute;but contrat");
    pi.getFormu().getChamp("unite").setLibelle("Unit&eacute;");
    pi.getFormu().getChamp("codeetablissement").setLibelle("Code &Eacute;tablissement");
    pi.getFormu().getChamp("idLC").setLibelle("Budget");
    pi.getFormu().getChamp("fin_contrat").setLibelle("Fin contrat");

    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>O
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
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
                        <input name="bute" type="hidden" id="bute" value="travaux/contrat-fiche-nouveau.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Contrat">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="contrat">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    }catch(Exception e){
    e.printStackTrace();
    }
%>