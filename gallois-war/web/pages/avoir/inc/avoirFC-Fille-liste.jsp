
<%@page import="affichage.Liste"%>
<%@page import="avoir.*"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    AvoirFCFille t = new AvoirFCFille();
    t.setNomTable("AVOIRDETAILFCFILLE");
    String listeCrt[] = {"idavoirfille", "id","datyavoirfc","codeavoir","codefc","client","type","compte","mois","annee"};
    String listeInt[] = {"datyavoirfc"};
    String libEntete[] = {"idavoirfille","id","codeavoir", "type","codefc","client", "designation", "pu", "qte", "duree", "compte", "remise", "tva", "reduction", "majoration", "devise", "taux", "montanthtdevise", "mtthtva", "montanttva", "montantttc", "datyavoirfc"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    //pr.setNpp(10);
    pr.setTitre("Liste Avoir Fille");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("avoir/inc/avoirFC-Fille-liste.jsp");
    pr.getFormu().getChamp("idavoirfille").setLibelle("IdAvoirFille");
    pr.getFormu().getChamp("id").setLibelle("Id Avoir");
    pr.getFormu().getChamp("datyavoirfc1").setLibelle("Date Avoir Min");
    pr.getFormu().getChamp("datyavoirfc2").setLibelle("Date Avoir Max");
    pr.getFormu().getChamp("codeavoir").setLibelle("Numero d'Avoir");
    pr.getFormu().getChamp("codefc").setLibelle("Numero Facture");
    
    affichage.Champ[] liste = new affichage.Champ[1];
        
    String[] affiche = {"Tous", "Interne", "Externe"};
    String[] value = {"%", "interne", "externe"};
    Liste lst = new Liste();
    lst.ajouterValeur(value, affiche);
    liste[0] = lst;
    liste[0].setNom("type");
    pr.getFormu().changerEnChamp(liste);
    
    affichage.Champ[] liste1 = new affichage.Champ[1];
        
    String[] affiche1 = {"Tous", "janvier", "fevrier","mars","avril","mai","juin","juillet","aout","septembre","octobre","novembre","decembre"};
    String[] value1 = {"%", "janvier", "fevrier","mars","avril","mai","juin","juillet","aout","septembre","octobre","novembre","decembre"};
    Liste lst1 = new Liste();
    lst1.ajouterValeur(value1, affiche1);
    liste1[0] = lst1;
    liste1[0].setNom("mois");
    pr.getFormu().changerEnChamp(liste1);

    String[] colSomme = {"montanthtdevise","mtthtva","montanttva","montantttc"};
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=avoir/avoirFC-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles à afficher
    String libEnteteAffiche[] = {"id Avoir Fille","Id Avoir", "code avoir", "type","Code Facture","client","designation", "pu", "qte", "duree", "compte", "remise", "tva", "reduction", "majoration", "devise", "taux", "Mtt Devise ", "MttHTVA", "Mtt TVA", "Mtt TTC", "Date d'avoir"};
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



