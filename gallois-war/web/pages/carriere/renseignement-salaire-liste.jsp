<%-- 
    Document   : renseignement-salaire-liste
    Created on : 29 nov. 2019, 09:58:19
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.InfoSalaire"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    InfoSalaire info = new InfoSalaire();
    info.setNomTable("infoSalaire");
    String listeCrt[] = {"id","idPersonnel","categorie","palier","logement","vehicule","autre_avantage","mode_paiement","numero_virement","numero_cnaps","idIndemnite","idAvantagenature","indice"};
    String listeInt[] = {"indice"};
    String libEntete[] = {"id","categorie","palier","logement","vehicule","autre_avantage","mode_paiement","numero_virement","numero_cnaps","idIndemnite","idAvantagenature","indice","indemnite_fonction","indemnite_conge_paye","indemnite_deplacement","indemnite_risque","salaire_base"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/renseignement-salaire-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste renseignement salaire</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/renseignement-salaire-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/renseignement-salaire-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Categorie","Palier","Logement","Vehicule","Autre avantage","Mode paiement","Numero virement","Numero cnaps","Indemnite","Avantagenature","Indice","Indemnite fonction","Indemnite conge paye","Indemnite deplacement","Indemnite risque","Salaire base"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>



