<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="lignecredit.SituationCredit"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        SituationCredit fa = new SituationCredit();

        String nomTable = "situationLC_vide";
        fa.setNomTable(nomTable);

        String listeCrt[] = {"id", "designation", "compte", "daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "facture", "paye", "daty"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("daty1").setLibelle("Date Début");
        pr.getFormu().getChamp("daty2").setLibelle("Date Fin");
        
        pr.setApres("ligneCredit/situation-ligneCreditRecette.jsp");
        
        String date1 = request.getParameter("daty1"), date2 = request.getParameter("daty2");
        if(date1 == null || date1.trim().isEmpty()) date1 = "01/01/"+Utilitaire.getAnneeEnCours();
        if(date2 == null || date2.trim().isEmpty()) date2 = "31/12/"+Utilitaire.getAnneeEnCours();
        
        pr.getFormu().getChamp("daty1").setDefaut(date1);
        pr.getFormu().getChamp("daty2").setDefaut(date2);
        
        SituationCredit[] liste  = SituationCredit.findSituationCreditRecette(request.getParameter("id"),request.getParameter("designation"),request.getParameter("compte"),date1,date2, request.getParameter("etat"), null);
        System.out.println("liste : " + liste.length);
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        pr.setTableau(new TableauRecherche(liste, libEntete));
        
        String[] etatAff = {"Tous", "Créé", "Visé"};
        String[] etatVal = {"", ""+ConstanteEtat.getEtatCreer(), ""+ConstanteEtat.getEtatValider()};
%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Credits Recettes </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditRecette.jsp" method="post" name="absence" id="absence">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <br/>
            <div class="col-md-12">
                <div class="col-md-3 col-md-offset-4">
                    Etat : 
                    <select class="form-control" id="etat" name="etat" onchange="changerDesignation()">
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = Utilitaire.champNull(request.getParameter("etat")).equals(etatVal[i]) ? "selected" : "" ;
                        %>
                            <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                        <%}%>
                    </select>
                </div>
            </div>
            <br/>
            <br/>
            <br/>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/fiche-ligneCreditRecette.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "designation", "compte", "annee", "montant", "facture", "paye","Date"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>