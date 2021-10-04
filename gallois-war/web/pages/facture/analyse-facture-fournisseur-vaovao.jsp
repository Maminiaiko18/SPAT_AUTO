<%@page import="facture.FactureFournisseurDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        FactureFournisseurDetails lv = new FactureFournisseurDetails();
        lv.setNomTable("FACTfourn_FILLE_VM_lib");
        String listeCrt[] = {"produit_lib", "rubriquelib"};
        String listeInt[] = {};

        String[] pourcentage = {};
        String somDefaut[] ={"quantite"}; //sum
        String colDefaut[] =  {"produit_lib"}; // colonne
        String[] colGrCol = {"rubriquelib"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("produit_lib").setLibelle("Produit");
        pr.getFormu().getChamp("rubriquelib").setLibelle("Rubrique");
        
        pr.setApres("facture/analyse-facture-fournisseur-vaovao.jsp");
        System.out.println("colDefaut==="+colDefaut[0]);
        System.out.println("pr.getLien==="+pr.getLien());
        System.out.println("pr.getApres"+pr.getApres());
        pr.creerObjetPageCroise(colDefaut, pr.getLien()+"?but="+pr.getApres());

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Facture Client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres()%>" method="post" name="formulaire" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>