<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="mg.spat.CompteCA"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="mg.spat.CaFcFilleComplet"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        CaFcFilleComplet cht = new CaFcFilleComplet();
        cht.setNomTable("CAFCFILLECOMPLET_AVOIR");
        if (request.getParameter("etatvue") != null) {
            cht.setNomTable(request.getParameter("etatvue"));
        }
        String libEntete[] = { "idmere","daty","code","client", "designation", "compte", "pu", "quantite", "duree", "tva", "montant", "montantTva", "montantttc"};
        String listeCrt[] = {"compte","annee", "type","daty","mereca","code"};
        String listeInt[] = {"daty"};

        PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/facture-client-fille-liste.jsp");

        pr.getFormu().getChamp("daty1").setLibelle("date min");
        pr.getFormu().getChamp("daty2").setLibelle("date max");
        pr.getFormu().getChamp("annee").setLibelle("Année");
        pr.getFormu().getChamp("type").setLibelle("Type");
        pr.getFormu().getChamp("compte").setLibelle("Compte");
         pr.getFormu().getChamp("code").setLibelle("Code");
        
        
        pr.getFormu().getChamp("annee").setDefaut(utilitaire.Utilitaire.getAnneeEnCours());
        
        affichage.Liste[] listes= new affichage.Liste[5];
        
        TypeObjet type = new TypeObjet();
        type.setNomTable("typefc");
        listes[0] = new Liste("type", type, "VAL", "id");
        
        listes[1] = new Liste("mois1");
        listes[1].makeListeMois();
        //listes[1].setDefaultSelected(utilitaire.Utilitaire.getMoisEnCours()+"");

        listes[2] = new Liste("mois2");
        listes[2].makeListeMois();        
        //listes[2].setDefaultSelected(utilitaire.Utilitaire.getMoisEnCours()+"");
        
        CompteCA type2 = new CompteCA();
        type2.setNomTable("compteCADetails");
        listes[3] = new Liste("compte", type2, "libelle", "val");
        
        TypeObjet type3 = new TypeObjet();
        type3.setNomTable("mereca");
        listes[4] = new Liste("mereca", type3, "desce", "id");
        
        pr.getFormu().changerEnChamp(listes);
        
        pr.getFormu().getChamp("annee").setLibelle("Année");
        pr.getFormu().getChamp("type").setLibelle("Type");
        pr.getFormu().getChamp("compte").setLibelle("Compte");
        pr.getFormu().getChamp("mereca").setLibelle("Grande rubrique");
        
        String[] colSomme = {"montant", "montanttva", "montantttc"};
        pr.setTitre("Liste facture client details");
        pr.setNpp(300);
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture client details</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/facture-client-fille-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                             <option value="CAFCFILLECOMPLET_AVOIR" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("CAFCFILLECOMPLET_AVOIR") == 0) {
                                out.print("selected");
                            }%>>Tous</option>
                        
                        <option value="CAFCFILLECOMPLET_AVOIRC" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("CAFCFILLECOMPLET_AVOIRC") == 0) {
                                out.print("selected");
                            }%>>Créé</option>
                        <option value="CAFCFILLECOMPLET_AVOIRV" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("CAFCFILLECOMPLET_AVOIRV") == 0) {
                                out.print("selected");
                            }%>>Visé</option>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"idmere"};
            String[] urlLien = {"idmere"};
            String[] urlLienAff = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            pr.getTableau().setUrlLien(urlLien);
            pr.getTableau().setUrlLienAffiche(urlLienAff);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Num Facture","date","Code","client", "Désignation", "Compte", "Prix unitaire", "Quantité", "Durée", "TVA", "Montant", "Montant TVA", "Montant TTC"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
