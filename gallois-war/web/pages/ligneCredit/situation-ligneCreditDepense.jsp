<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="bean.ResultatEtSomme"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
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

        String listeCrt[] = {"id", "designation", "compteInv", "compteSimple", "direction", "projet", "directionProjet", "daty", "annee"};
        String listeInt[] = {"daty", "mois"};
        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("ligneCredit/situation-ligneCreditDepense.jsp");
        
        String date1 = request.getParameter("daty1"), date2 = request.getParameter("daty2"), annee = request.getParameter("annee");
        
        if(date1 == null || date1.trim().isEmpty()) { 
            date1 = "01/01/"+Utilitaire.getAnneeEnCours(); 
            pr.getFormu().getChamp("daty1").setDefaut(date1);
        }
        //if(date2 == null || date2.trim().isEmpty()) date2 = "31/12/"+Utilitaire.getAnneeEnCours();
        if(annee == null || annee.trim().isEmpty()) { 
            annee = Utilitaire.getAnneeEnCours(); 
            pr.getFormu().getChamp("annee").setDefaut(annee);
        }
        
//        pr.getFormu().getChamp("daty2").setDefaut(date2);
        
        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("compteInv").setLibelle("Compte inv");
        pr.getFormu().getChamp("compteSimple").setLibelle("Compte compta");
        pr.getFormu().getChamp("direction").setLibelle("Direction");
        pr.getFormu().getChamp("projet").setLibelle("Code projet");
        pr.getFormu().getChamp("directionProjet").setLibelle("Direction & Projet");
                
        pr.getFormu().getChamp("annee").setLibelle("Exercice");
        
        String reqniv = request.getParameter("niveau");
        
        String[] colSomme = {"montant", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget"};
        pr.creerObjetPage(libEntete, colSomme);
        
//        LigneCredit[] liste = LigneCredit.findSituationCreditDepense(request.getParameter("id"), request.getParameter("designation"), request.getParameter("compte"), request.getParameter("daty1"), request.getParameter("daty2"), etatp, reqniv, annee, request.getParameter("mois"), null);
        ResultatEtSomme rs = LigneCredit.findSituationCreditDepense((LigneCredit) pr.getCritere(), date1, date2, null, colSomme);
        pr.setRs(rs);
        pr.setTableau(new TableauRecherche((bean.ClassMAPTable[]) rs.getResultat(), libEntete));
        pr.makeTableauRecap();

        String[] libEtat = {"Tous", "Créés", "Visés"};
        String[] etat = {"", "" + ConstanteEtat.getEtatCreer(), "" + ConstanteEtat.getEtatValider()};
%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }
    
    function ajoutChampsNiveau(){
        var d = document.getElementById("pagerecherche");
        var inputanneeniv = "<div class='col-md-4'>\n\
        <label for='anneestr'> Année </label>\n\
        <input id='anneestr' class='form-control' name='anneestr' type='textbox' value='' onkeydown='return searchKeyPress(event)'>\n\
        </div>";
        
        var inputniv = "<div class='col-md-4'>\n\
        <label for='niveau'> Niveau </label>\n\
        <input id='niveau' class='form-control' name='niveau' type='textbox' value='<%=Utilitaire.champNull(reqniv)%>' onkeydown='return searchKeyPress(event)'>\n\
        </div>";        
        //d.insertAdjacentHTML('beforeend', inputanneeniv);
        d.insertAdjacentHTML('beforeend', inputniv);
    }
    
    <%if(request.getParameter("recap") == null || request.getParameter("recap").equals("")) { %>
        window.location.href = "<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditDepense.jsp&recap=checked";
    <% } %>
    
//    window.onload = ajoutChampsNiveau;    
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
            String libEnteteAffiche[] = {"id", "designation", "compte", "annee", "montant", "Engagé", "% engagé", "décaissé", "% payé", "a recouvrir", "reste sur budget"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setLibeEntete(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
        <script>
            
        </script>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>