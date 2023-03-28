<%-- 
    Document   : analyse-journal-de-caisse
    Created on : 2 déc. 2019, 08:22:05
    Author     : Antsa
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        PlacementLibComplet journal = new PlacementLibComplet();
        journal.setNomTable("placementlibcomplet_analyse");
        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"id", "date_placement", "date_echeance", "valentite", "valbanque", "numero"};
        String listeInt[] = {"etat", "date_placement", "date_echeance"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id", "date_placement", "date_echeance", "valentite", "valbanque", "numero"};
        String somDefaut[] = {"duree", "interet_recevoir", "montant"};
        String lien[] = {"montant"};
        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("date_placement1").setLibelle("Date placement  min");
        pr.getFormu().getChamp("date_echeance1").setLibelle("Date échéance min");
        pr.getFormu().getChamp("date_placement2").setLibelle("Date placement  max");
        pr.getFormu().getChamp("date_echeance2").setLibelle("Date échéance max");

        pr.getFormu().getChamp("date_placement1").setDefaut(fin[0]);
        pr.getFormu().getChamp("date_echeance1").setDefaut(fin[0]);
        pr.getFormu().getChamp("date_placement2").setDefaut(fin[1]);
        pr.getFormu().getChamp("date_echeance2").setDefaut(fin[1]);

        pr.getFormu().getChamp("valentite").setLibelle("Nature");
        pr.getFormu().getChamp("valbanque").setLibelle("Entite");
        pr.setApres("placement/analyse-placement.jsp");
        pr.creerObjetPage();
        HashMap<String,String> hash = new HashMap<String,String>();
        hash.put("id","ID");
        hash.put("entite","ID Entite");
        hash.put("date_placement","Date placement");
        hash.put("date_echeance","Date &eacute;ch&eacute;ance");
        hash.put("duree","Dur&eacute;e");
        hash.put("montant","Montant");
        hash.put("taux","Taux");
        hash.put("etat","Etat");
        hash.put("numero","Num&eacute;ro");
        hash.put("iddetails","Details");
        hash.put("idmeredetails","Mere Details");
        hash.put("mois","Mois");
        hash.put("interet_recevoir","Interet Recevoir");
        hash.put("interet_net","Interet net");
        hash.put("identite","Identite");
        hash.put("idbanque","ID Banque");
        hash.put("valentite","Entite");
        hash.put("desceentite","Entite");
        hash.put("valbanque","Banque");
        hash.put("descebanque","Banque");
        List<String> strings = new ArrayList<String>();
        if(pr.getColGroupe()!=null && pr.getColGroupe().length>0){
            for(String col: pr.getColGroupe()){
                strings.add(hash.get(col));
            }
        }
        if(pr.getSommeGroupe()!=null && pr.getSommeGroupe().length>0){
            for(String somme: pr.getSommeGroupe()){
                strings.add(hash.get(somme));
            }
        }
        String[] libEntete = new String[strings.size()];
        strings.toArray(libEntete);
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Placement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="placement/analyse-placement.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            if(strings.size() == 0){
                String libEnteteAffiche[] = {"ID","Date placement","Date &eacute;ch&eacute;ance","Entite", "Banque","Num&eacute;ro" ,"Dur&eacute;e", "Interet recevoir", "Montant"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            }
            else
                pr.getTableau().setLibelleAffiche(libEntete);
            String lienTableau[] = {
                pr.getLien() + "?but=placement/details-analyse-placementMontant.jsp&recap=checked"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(lien);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>