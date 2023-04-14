<%-- 
    Document   : journal-liste
    Created on : 6 nov. 2019, 14:24:39
    Author     : john
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        JournalCaisse journal = new JournalCaisse();
        journal.setNomTable("journalcaisselibdepenseBanqueT");
        String suiteReq = "";
        if (request.getParameter("mode") != null)  {
            journal.setNomTable("journalcaisselibdepenseBanqueV");
        }
        if (request.getParameter("tablename") != null) journal.setNomTable(request.getParameter("tablename"));
          String listeCrt[] = {"id","folio", "valcaisse", "libelle", "remarque", "dateEffet","DESCETYPECHEQUE"};
        String listeInt[] = {"dateEffet"};
        String libEntete[] =  {"id", "valcaisse","DESCETYPECHEQUE", "numPiece", "numcheque","libelle", "dateSaisie", "dateEffet", "debit","idplacement","etatlib"};
        PageRecherche pr = new PageRecherche(journal, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

         pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        pr.getFormu().getChamp("libelle").setLibelle("Libell�");
        pr.getFormu().getChamp("DESCETYPECHEQUE").setLibelle("Type");
        pr.getFormu().getChamp("valcaisse").setLibelle("Banque");
        pr.setAWhere(suiteReq);

        String[] colSomme = {"debit"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.recettebq.submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Depenses Banques</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/depense-liste.jsp" method="post" name="recettebq" id="recettebq">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
                    <div class="col-md-4">
                    Etat : 
                    <select name="tablename" class="champ" id="tablename" onchange="changerDesignation()" >
                        
                        <% if (request.getParameter("tablename") != null && request.getParameter("tablename").compareToIgnoreCase("journalcaisselibdepenseBanqueT") == 0) {%>    
                        <option value="journalcaisselibdepenseBanqueT" selected>Tous</option>
                        <% } else { %>
                        <option value="journalcaisselibdepenseBanqueT" >Tous</option>
                        <% } %>
                        
                        <% if (request.getParameter("tablename") != null && request.getParameter("tablename").compareToIgnoreCase("journalcaisselibdepenseBanqueC") == 0) {%>    
                        <option value="journalcaisselibdepenseBanqueC" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="journalcaisselibdepenseBanqueC" >Cr&eacute;&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("tablename") != null && request.getParameter("tablename").compareToIgnoreCase("journalcaisselibdepenseBanqueV") == 0) {%>    
                        <option value="journalcaisselibdepenseBanqueV" selected>Valid&eacute;</option>
                        <% } else { %>
                        <option value="journalcaisselibdepenseBanqueV" >Valid&eacute;</option>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
             String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="journal-caisse-liste">
            <input type="hidden" name="bute" value="treso/depense-liste.jsp"/>
            <input type="hidden" name="classe" value="mg.spat.JournalCaisse"/>
            <input type="hidden" name="acte" value="viser"/>
            <%
                String entete[] =  {"id", "banque","type cheque", "numPiece", "Numero cheque","libelle", "date de saisie", "date d'effet", "debit","idplacement","etat"};
                pr.getTableau().setLibelleAffiche(entete);
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
