<%-- 
    Document   : en-attente-de-visa
    Created on : 20 févr. 2016, 11:04:59
    Author     : ITU
--%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    MouvementLibComplet dr = new MouvementLibComplet();
    dr.setNomTable("mouvementLibComplet");
    String listeCrt[] = {"id","daty","heure", "nomnavire", "valconsignataire", "escale"};
    String listeInt[] = {};
    String libEntete[] = {"id","escale","daty", "heure", "nomnavire", "valconsignataire"};
    PageRecherche pr = new PageRecherche(dr, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("nomnavire").setLibelle("Navire");
    pr.getFormu().getChamp("valconsignataire").setLibelle("Consignataire");
    pr.setAWhere(" and etat!="+ConstanteEtat.getEtatValider()+" and etatnavire!="+ConstanteEtat.getEtatAnnuler());
    pr.setApres("capitainerie/mouvement-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des mouvements &agrave; viser</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/mouvement-visa.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=immo/mouvement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="id">
            <input type="hidden" name="bute" value="capitainerie/mouvement-visa.jsp"/>
            <input type="hidden" name="classe" value="mg.spat.Mouvement"/>
            <input type="hidden" name="acte" value="viser"/>
            
            <%
                System.out.println("lien======="+pr.getLien());
                String libEnteteAffiche[] ={"id","Escale","Date", "Heure", "Navire","Consignataire"};
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