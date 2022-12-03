<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureClient ff = new FactureClient();
        //ff.setNomTable("factureclientApayer");
        ff.setNomTable("FACTURECLIENTPAYEESNP");

        String listeCrt[] = {"id","daty","tierslib", "cdclt", "designation","armateurlib","exercice","date_echeance","escale","categorielib", "code","codeFiltre","typelib","numpiece"};
        String listeInt[] = {"daty","date_echeance","exercice"};
        String libEntete[] = {"id","daty","tierslib","cdclt", "numpiece", "code", "escale","designation","armateurlib","exercice","categorielib","tva","date_echeance","typelib","montant", "montantTVA", "montantTTC", "montantTTCvrai", "montantAvoir","montantpaye","montantreste"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/factureclient-liste-numpiece.jsp");
        pr.setNpp(300);
        pr.getFormu().getChamp("numpiece").setLibelle("Numero pièce");
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("exercice1").setLibelle("debut exercice");
        pr.getFormu().getChamp("exercice2").setLibelle("fin exercice");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("typelib").setLibelle("Type");
        pr.getFormu().getChamp("armateurlib").setLibelle("Armateur");
        pr.getFormu().getChamp("categorielib").setLibelle("Catégorie");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);
        
        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        /*if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);
            
        }*/
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        pr.getFormu().getChamp("designation").setLibelle("Note explicative");
        
          Liste[] listes= new Liste[1];
        TypeObjet type = new TypeObjet();
        type.setNomTable("rubrique_fact_emises");
        listes[0] = new Liste("codeFiltre", type, "desce", "val");
        pr.getFormu().changerEnChamp(listes);
        pr.getFormu().getChamp("codeFiltre").setLibelle("Rubriques");
        
        String[] colSomme = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture client avec numpiece</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/factureclient-liste-numpiece.jsp" method="post" name="incident" id="incident">
            <%
                String libelleAffiche[] = {};
                pr.getTableau().setLibelleAffiche(libelleAffiche);
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>     
                <div class="col-md-4">                 
                    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerFactureClient1&etat=<%=request.getParameter("etat")%>&code=<%=request.getParameter("code")%>&categorielib=<%=request.getParameter("categorielib")%>&armateurlib=<%=request.getParameter("armateurlib") %>&designation=<%=request.getParameter("designation") %>&tierslib=<%=request.getParameter("tierslib") %>&daty1=<%=request.getParameter("daty1") %>&daty2=<%=request.getParameter("daty2") %>&date_echeance1=<%=request.getParameter("date_echeance1") %>&date_echeance2=<%=request.getParameter("date_echeance2") %>" style="margin-right: 10px">Imprimer factures</a>                 
                </div>
            </div>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=apresFacture.jsp" method="post" name="incidents" id="incidents">
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp", pr.getLien() + "?but=capitainerie/quais/quais-prevision-fiche.jsp"};
            String colonneLien[] = {"id", "escale"};
            String[] urlLienMultiple = {"id", "idprevision"};
            String[] urlLienAffiche = {"id", "id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id","daty","Client", "Code Clt","numero pièce", "Code", "Escale","Note explicative","armateur","exercice","Catégorie", "tva", "date echeance", "Type","montant HT", "montant TVA", "Montant TTC", "Net à payer", "montant Avoir","Montant payé","Reste à payer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            pr.getTableau().setNameBoutton("Encaisser");
            pr.getTableau().setNameActe("encaisserMultiple");
            out.println(pr.getTableau().getHtmlWithCheckbox());
            
            %>

        <input type="hidden" name="acte" value="encaisserMultiple"/>
        </form>
         
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
