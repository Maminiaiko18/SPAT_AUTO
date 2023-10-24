
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    JournalCaisseLibComplet jc = new JournalCaisseLibComplet();
    jc.setNomTable("JOURNALCAISSELIB_COFFRE");
    String nomTableEtat = request.getParameter("nomTableEtat");
    if(nomTableEtat!=null && !nomTableEtat.isEmpty()){
        jc.setNomTable(nomTableEtat);
    }
    String listeCrt[] = {"id", "caisse", "libelle", "remarque", "dateEffet", "idtypecheque", "idplacement", "descecaisse", "tierslib", "numPiece"};
    String listeInt[] = {"dateEffet"};
    String libEntete[] = {"id", "folio", "valcaisse", "descetypecheque", "numPiece", "libelle", "dateSaisie", "dateEffet", "debit", "credit", "tierslib", "idplacement"};
    PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste Entr&eacute;e");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("treso/coffre-entree.jsp");
    pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
    pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
    pr.getFormu().getChamp("idtypecheque").setLibelle("Type ch&egrave;que");
    pr.getFormu().getChamp("idplacement").setLibelle("ID placement");
    pr.getFormu().getChamp("descecaisse").setLibelle("Caisse");
    pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
    pr.getFormu().getChamp("numPiece").setLibelle("Num pi&egrave;ce");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"ID", "Folio", "Caisse", "Type ch&egrave;que", "Num pi&egrave;ce", "Libell&eacute;", "Date saisie", "Date effet", "D&eacute;bit", "Cr&eacute;dit", "Tiers", "ID placement"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    String[] etatVal = {"JOURNALCAISSELIB_COFFRE", "JOURNALCAISSELIB_COFFRE_CREE", "JOURNALCAISSELIB_COFFRE_VISE"};
    String[] etatAff = {"Tous", "Cr&eacute;&eacute;", "Vis&eacute;"};
%>

<script>
    function submitFormulaire(){
        document.getElementById("coffre").submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" id="coffre">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row">
                <div class="col-md-12">
                    <br>
                    <select name="nomTableEtat" id="nomTableEtat" onchange="submitFormulaire()" class="form-control"style="max-width: 200px; margin: 0 auto;">
                            <%for(int i=0; i<etatVal.length; i++){
                                String selected = jc.getNomTable().equalsIgnoreCase(etatVal[i]) ? "selected" : "";
                            %>
                            <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                            <%}%>
                        </select>
                    <br>
                </div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



