<%-- 
    Document   : postedestinataire-liste
    Created on : 5 nov. 2019, 11:55:29
    Author     : john
--%>

<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    PosteDestinataireLibComplet posteDestinataire = new PosteDestinataireLibComplet();
    posteDestinataire.setNomTable("POSTEDESTINATAIRELIBCOMPLET");
    
 
    String listeCrt[] = {"id","valquais", "interne", "valpays","valtypequais"};
    String listeInt[] = {};
    String libEntete[] =  {"id","valquais", "interne", "valpays","valtypequais","longueur", "profondeur", "tirant"};
    PageRecherche pr = new PageRecherche(posteDestinataire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("capitainerie/postedestinataire-liste.jsp");
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("valquais").setLibelle("Quais");
    pr.getFormu().getChamp("interne").setLibelle("Interne");
    pr.getFormu().getChamp("valpays").setLibelle("Pays");
    pr.getFormu().getChamp("valtypequais").setLibelle("Type Quais");
  
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listepostedestinataire.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Poste Destinataire </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/postedestinataire-liste.jsp" method="post" name="listepostedestinataire" id="listepostedestinataire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capita"
                    + "inerie/postedestinataire-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Quais", "Interne", "Pays","Type Quais","Longueur", "Profondeur", "Tirant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
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

