<%-- 
    Document   : liste-utilisation-materiels
    Created on : 25 févr. 2021, 10:11:58
    Author     : Sanda
--%>

<%@page import="facture.FactureClient"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%> 
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@page import="mg.spat.Navire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        FactureClient ff = new FactureClient();
        ff.setNomTable("facture_client_union");
        
        String id = request.getParameter("id");
        
        String listeCrt[] = {"idprevision"};
        String listeInt[] = {};
        String libEntete[] = {"id","daty","tierslib","designation","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste", "etatLib"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.setApres("capitainerie/quais/inc/liste-factures.jsp");
        pr.setAWhere(" and idprevision = '" + id + "'");
        
        String[] colSomme = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
        pr.creerObjetPage(libEntete, colSomme);
%>


<%
    String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"id","daty","Client","designation", "montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste à payer", "Etat"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>
<form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="facturation" id="facturation">
    <%
        pr.getTableau().setNameBoutton("Valider");
        pr.getTableau().setNameActe("viser");
        if(pr.getTableau().getHtmlWithCheckbox() == null){
            out.println("Aucun !");
        }else{
            out.println(pr.getTableau().getHtmlWithCheckbox());%>
    
            <button class="btn btn-primary pull-right" onclick="changer()">Fusionner</button>
       <% }  %>
    <input type="hidden" name="acte" id="acte" value="viser"/>
    <input name="bute" type="hidden" id="bute" value="capitainerie/quais/quais-prevision-fiche.jsp&tab=liste-factures&id=<%=id%>">
    <input name="classe" type="hidden" id="classe" value="facture.FactureClient">
</form>
    
    
<script>
    function changer(){
        document.facturation.action = "<%=pr.getLien()%>?but=apresFacture.java";
        document.getElementById("acte").value="fusionner";
	document.facturation.submit();
    }
</script>
    
<%} catch (Exception e) {
        e.printStackTrace();
    }%>