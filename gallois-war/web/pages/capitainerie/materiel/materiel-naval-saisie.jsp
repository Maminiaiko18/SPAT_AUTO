<%-- 
    Document   : materiel-naval-saisie
    Created on : 15 nov. 2019, 11:30:30
    Author     : rajao
--%>
<%@page import="mg.spat.MaterielNaval"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{ 
        MaterielNaval pj = new MaterielNaval();    
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        
        pi.getFormu().getChamp("date_aquisition").setLibelle("Date d'aquisition");
        pi.getFormu().getChamp("date_aquisition").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("etat").setVisible(false);
        
        affichage.Liste[] liste = new affichage.Liste[3];
        TypeObjet marque = new TypeObjet();
        marque.setNomTable("MARQUE_MATERIEL");
        liste[0] = new Liste("idMarque", marque, "val", "id");
        
        TypeObjet type_materiel = new TypeObjet();
        type_materiel.setNomTable("TYPE_MATERIEL");
        liste[1] = new Liste("idType_materiel", type_materiel, "val", "id");
        
        TypeObjet categorie = new TypeObjet();
        categorie.setNomTable("CATEGORIE_MATERIEL");
        liste[2] = new Liste("idcategorie", categorie, "val", "id");
        pi.getFormu().changerEnChamp(liste);
        
        pi.getFormu().getChamp("idMarque").setLibelle("Marque");
        pi.getFormu().getChamp("idType_materiel").setLibelle("Type du matériel");
        pi.getFormu().getChamp("idcategorie").setLibelle("Catégorie");
        
        pi.getFormu().getChamp("etat").setVisible(false);
        
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
   %>
<div class="content-wrapper">
    <h1>Saisie d'un materiel naval</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/materiel/materiel-naval-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.MaterielNaval">
    
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>