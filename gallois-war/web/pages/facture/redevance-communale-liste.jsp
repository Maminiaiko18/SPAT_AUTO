<%-- 
    Document   : redevance-communale-liste
    Created on : 5 janv. 2022, 09:43:52
    Author     : rijan
--%>

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.EtatRedevance"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    EtatRedevance etat = new EtatRedevance();
    etat.setNomTable("redevanceCommunaleFacture");
    String listeCrt[] = {"daty","tierslib","typelib"};
    String listeInt[] = {"daty"};
    String libEntete[] =  {"code","daty","tierslib","montantHT","tva","montantTTC"};
    PageRecherche pr = new PageRecherche(etat, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facture/redevance-communale-liste.jsp");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("tierslib").setLibelle("Client");
    pr.getFormu().getChamp("typelib").setLibelle("Type");
    pr.getFormu().getChamp("typelib").setDefaut("Au comptant");
    Date jour = Utilitaire.dateDuJourSql();
    jour.setDate(1);
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.datetostring(jour));
    Date date2 = Utilitaire.getLastDayOfDateSQL(jour);
    pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.datetostring(date2));
    
    
  
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Redevance communale facture <%=pr.getFormu().getChamp("typelib").getValeur()%></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/redevance-communale-liste.jsp" method="post" name="listepostedestinataire" id="listepostedestinataire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
//            String lienTableau[] = {pr.getLien() + "?but=facture/redevance-communale-fiche.jsp"};
//            String colonneLien[] = {"id"};
//            pr.getTableau().setLien(lienTableau);
//            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","N° facture", "Date", "Client","Montant","Tva", "Total"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

