<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="utilitaire.Constante"%>
<%@page import="affichage.Liste"%>
<%@page import="avoir.*"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    AvoirFCFille t = new AvoirFCFille();
    t.setNomTable("AVOIRDETAILFCFILLE");
    String listeCrt[] = {"idavoirfille", "id","datyavoirfc","codeavoir","codefc","client","type","compte","mois","annee"};
    String listeInt[] = {"datyavoirfc"};
    String libEntete[] = {"idavoirfille","id","codeavoir", "datyavoirfc","type","codefc","datyfc","client", "designation", "pu", "qte", "duree", "compte", "remise", "tva", "reduction", "majoration", "devise", "taux", "montanthtdevise", "mtthtva", "montanttva", "montantttc"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    //pr.setNpp(10);
    pr.setTitre("Liste Avoir Fille");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("avoir/avoirFC-Fille-liste.jsp");
    pr.getFormu().getChamp("idavoirfille").setLibelle("IdAvoirFille");
    pr.getFormu().getChamp("id").setLibelle("Id Avoir");
    pr.getFormu().getChamp("datyavoirfc1").setLibelle("Date Avoir Min");
    pr.getFormu().getChamp("datyavoirfc2").setLibelle("Date Avoir Max");

    if( request.getParameter("datedebut") != null && !request.getParameter("datedebut").isEmpty() && request.getParameter("datefin") != null && !request.getParameter("datefin").isEmpty()){
        SimpleDateFormat parser = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        String dateDebut = formatter.format(parser.parse(request.getParameter("datedebut")));
        String dateFin = formatter.format(parser.parse(request.getParameter("datefin")));
        pr.getFormu().getChamp("datyavoirfc1").setDefaut(dateDebut);
        pr.getFormu().getChamp("datyavoirfc2").setDefaut(dateFin);
    }
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
    

    if( request.getParameter("datedebut") == null  && request.getParameter("datefin") == null ){
        affichage.Liste[] liste1 = new affichage.Liste[1];
        liste1[0] = new Liste("mois");
        liste1[0].makeListeMois();
        pr.getFormu().changerEnChamp(liste1);

        if( request.getParameter("typeFC") != null && !request.getParameter("typeFC").isEmpty() && request.getParameter("typeFC").compareTo(Constante.typeFCCAAvoirCumul) == 0){
            pr.setAWhere(" and datyfc < TO_DATE('" + request.getParameter("annee") + "-01-01', 'yyyy-mm-dd')");
        }
    }


    String[] colSomme = {"montanthtdevise","mtthtva","montanttva","montantttc"};
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=avoir/avoirFC-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles � afficher
    String libEnteteAffiche[] = {"id Avoir Fille","Id Avoir", "code avoir", "Date d'avoir", "type","Code Facture","Date Facture","client","designation", "pu", "qte", "duree", "compte", "remise", "tva", "reduction", "majoration", "devise", "taux", "Mtt Devise ", "MttHTVA", "Mtt TVA", "Mtt TTC"};
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



