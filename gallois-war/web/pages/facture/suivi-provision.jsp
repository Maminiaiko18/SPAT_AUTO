
<%@page import="facture.SuiviProvision"%>
<%@page import="test.*"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    SuiviProvision suiviProvision = new SuiviProvision();
    String setNomTableNormale = "SUIVI_PROVISION";
//    String setNomTableViser = "visee";
//    String setNomTableCreer = "creer";
//    if (request.getParameter("etat") != null && !request.getParameter("etat").equals("")) {
        suiviProvision.setNomTable(setNomTableNormale);
//    } else {
//        suiviProvision.setNomTable(setNomTableNormale);
//    }
    String listeCrt[] = {"id", "caisse","daty","libelle","credit","tiers","code","codeprovision"};
    String listeInt[] = {"daty"};
        
    String libEntete[] = {"id", "daty", "caisse","numpiece","libelle","credit", "tiers","montant","code","codeprovision"};
    PageRecherche pr = new PageRecherche(suiviProvision, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Suivi Provision");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
  pr.setApres("facture/suivi-provision.jsp");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {};
    String colonneLien[] = {};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles à afficher
    String libEnteteAffiche[] = {"id", "daty", "caisse","numpiece","libelle","credit", "tiers","montant","code","codeprovision"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">

                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
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