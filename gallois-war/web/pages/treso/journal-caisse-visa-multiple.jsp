<%-- 
    Document   : caisse-visa-multiple
    Created on : 6 nov. 2019, 09:35:39
    Author     : john
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        JournalCaisse journalCaisse = new JournalCaisse();
        String listeCrt[] = {"folio","caisse","libelle","remarque","dateEffet"};
        String listeInt[] = {"dateEffet"};
        String libEntete[] = {"id","folio","caisse","numPiece","libelle","remarque","dateSaisie","dateEffet","dateSaisie","dateEffet"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setAWhere(" and etat!="+ConstanteEtat.getEtatValider());
        pr.setApres("/journal-caisse-visa-multiple.jsp");
        pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des journal de caisses &agrave; viser</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/journal-caisse-visa-multiple.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="id">
            <input type="hidden" name="bute" value="treso/journal-caisse-visa-multiple.jsp"/>
            <input type="hidden" name="classe" value="mg.spat.JournalCaisse"/>
            <input type="hidden" name="acte" value="viser"/>
            
            <%
                System.out.println("lien======="+pr.getLien());
                String libEnteteAffiche[] ={"id","folio","caisse","numPiece","libelle","remarque","dateSaisie","dateEffet","dateSaisie","dateEffet"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                pr.getTableau().setNameBoutton("Viser");
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>

        </form>
            <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
