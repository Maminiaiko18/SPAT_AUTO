<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="facture.RegulFCProvision"%>
<%@page import="mg.spat.FactureAnalyse"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        RegulFCProvision ff = new RegulFCProvision();
        ff.setNomTable("regulFCProvisionlib");

        String listeCrt[] = {"idProvision"};
        String listeInt[] = {};
        String libEntete[] = {"id", "idFactureCode", "etatlib"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};

            String colonneLien[] = {"idFactureCode"};
            String [] urlLienMultiple = {"idFacture"};
            String [] urlLienAffiche = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            pr.getTableau().setUrlLien(urlLienMultiple);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);

            String libEnteteAffiche[] = {"ID", "Code facture","Etat"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    if(pr.getTableau().getData().length > 0){
        %>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="fusionner" id="fusionner">
            <% 
                pr.getTableau().setNameActe("viser");
                out.println(pr.getTableau().getHtmlWithCheckbox()); %>    
            <input name="acte" type="hidden" id="nature" value="viser">
            <input type="hidden" name="classe" value="facture.RegulFCProvision">
            <input type="hidden" name="table" value="regulFCProvision">
            <input type="hidden" name="bute" value="facture/factureclient-fiche-vaovao.jsp&tab=regularisation&id=<%=request.getParameter("idProvision")%>">            
        </form>
        <%
    }else{ %>
        <center><h4>Aucun résultat </h4></center><%
    }
        %>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
