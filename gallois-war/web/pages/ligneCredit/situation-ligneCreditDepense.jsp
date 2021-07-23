<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="lignecredit.LigneCredit"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%
    try {

        LigneCredit fa = new LigneCredit();

        String etatp = "";
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            etatp = request.getParameter("etat");
        }
        fa.setNomTable("situationLC_vide");

        String listeCrt[] = {"id", "designation", "compte"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "facture", "paye", "daty"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("ligneCredit/situation-ligneCreditDepense.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);

        LigneCredit[] liste = LigneCredit.findSituationCreditDepense(request.getParameter("id"), request.getParameter("designation"), request.getParameter("compte"), request.getParameter("daty1"), request.getParameter("daty2"), etatp, null);
        pr.setTableau(new TableauRecherche(liste, libEntete));

        String[] libEtat = {"Tous", "Créés", "Visés"};
        String[] etat = {"", "" + ConstanteEtat.getEtatCreer(), "" + ConstanteEtat.getEtatValider()};
%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Credits Depenses </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditDepense.jsp" method="post" name="absence" id="absence">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="table" onchange="changerDesignation()" >
                        <% for (int i = 0; i < etat.length; i++) { %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase(etat[i]) == 0) {%>    
                        <option value="<%=etat[i]%>" selected><%=libEtat[i]%></option>
                        <% } else { %>
                        <option value="<%=etat[i]%>" ><%=libEtat[i]%></option>
                        <% } %>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/fiche-ligneCreditDepense.jsp"};
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