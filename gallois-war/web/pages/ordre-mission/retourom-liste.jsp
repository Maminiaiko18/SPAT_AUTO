
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="utilitaire.*"%>
<%@page import="ordremission.RetourOM"%>
<%@page import="ordremission.OrdreMissionLib"%>
<%@page import="affichage.PageRecherche"%>

<%
    try {
        RetourOM ff = new RetourOM();
        String[] etatVal = {"RETOUROMLIBCPLT", "RETOUROMLIBCPLTc", "RETOUROMLIBCPLTv", "RETOUROMLIBCPLTa"};
        String[] etatAff = {"Tous", "Crée(s)", "Visée(s)", "Annulé(s)"};
        ff.setNomTable(etatVal[0]);
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            ff.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"id", "idom", "heurearrivee", "datearrivee", "nombres", "prixunitaire","autres"};
        String listeInt[] = {""}    ;
        String libEntete[] = {"id", "idom", "heurearrivee", "datearrivee", "nombres", "prixunitaire", "autres"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/retourom-liste.jsp");
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("heurearrivee").setLibelle("Heure d'arrivée");
        pr.getFormu().getChamp("datearrivee").setLibelle("Date arrivée");
        pr.getFormu().getChamp("nombres").setLibelle("Nombre");
        pr.getFormu().getChamp("prixunitaire").setLibelle("Prix Unitaire");
        pr.getFormu().getChamp("autres").setLibelle("Autres");
        //Variables de navigation

       /* Date firstDate = Utilitaire.dateDuJourSql();
        firstDate.setDate(1);
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);

        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);

        if (request.getParameter("daty1") == null && request.getParameter("daty2") == null) {
            //pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.getDateMoins6Mois());
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);

        }        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);

        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
*/
        String[] colSomme = {"id", "iddom", "heurearrivee", "datearrivee", "nombres", "prixunitaire", "autres"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture provision</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ordre-mission/retourom-liste.jsp" method="post" name="incident" id="incident">
            <%
                String libelleAffiche[] = {};
                pr.getTableau().setLibelleAffiche(libelleAffiche);
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <%for (int i = 0; i < etatVal.length; i++) {
                                String selected = etatVal[i].equalsIgnoreCase(ff.getNomTable()) ? "selected" : "";
                        %>
                        <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
               <%
            String lienTableau[] = {pr.getLien() + "?but=ordre-mission/retourom-liste.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
          //  out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "iddom", "heurearrivee", "datearrivee", "nombres", "prixunitaire", "autres"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>