
<%@page import="avoir.AvoirFC"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        AvoirFC ff = new AvoirFC();
        String[] etatVal = {"avoirFC_montant", "avoirFC_montant_C", "avoirFC_montant_V"};
        String[] etatAff = {"Tous", "Créé", "Visé"};
        ff.setNomTable(etatVal[0]);
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            ff.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"id","tierslib","idfacture"};
        String listeInt[] = null;
        String libEntete[] =  {"id","tierslib","idfacture","montant","montantpaye","montantreste"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("avoir/avoirFC-liste.jsp");
        
        pr.getFormu().getChamp("tierslib").setLibelle("tiers");
        pr.getFormu().getChamp("idfacture").setLibelle("facture");
       
        
        
        String[] colSomme = {"montant", "montantpaye", "montantreste"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste AvoirFC </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=avoir/avoirFC-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = etatVal[i].equalsIgnoreCase(ff.getNomTable()) ? "selected" : "";
                        %>
                        <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String libelleAffiche[] = {"id","tiers","facture","montant","montant payé","montant reste"};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            
            
            String lienTableau[] = {pr.getLien() + "?but=avoir/avoirFC-fiche.jsp", pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"id", "idfacture"};
            String[] urlLienMultiple = {"id", "idfacture"};
            String[] urlLienAffiche = {"id", "id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
