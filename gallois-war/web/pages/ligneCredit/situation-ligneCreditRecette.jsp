<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="bean.ResultatEtSomme"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="lignecredit.SituationCredit"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        SituationCredit fa = new SituationCredit();

        String nomTable = "SITUATIONLC_VIDE";
        fa.setNomTable(nomTable);

        String listeCrt[] = {"id", "designation", "compte", "daty", "annee"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("daty1").setLibelle("Date Début");
        pr.getFormu().getChamp("daty2").setLibelle("Date Fin");
        pr.getFormu().getChamp("annee").setLibelle("Exercice");
        //pr.getFormu().getChamp("annee2").setLibelle("Exercice Fin");
        pr.setApres("ligneCredit/situation-ligneCreditRecette.jsp");
        
       /* String mois = request.getParameter("mois1");
        if(mois != null && !mois.equals("")) pr.getFormu().getChamp("mois2").setDefaut(mois);
        
        String affiche[] = {"-","Janvier", "F\u00e9vrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "D\u00e9cembre"};
	String valeur[] = {"", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
        Liste[] listeD = new Liste[1];
        listeD[0] = new Liste("mois1");
        listeD[0].setValeurBrute(affiche);
        listeD[0].setColValeurBrute(valeur);
        pr.getFormu().changerEnChamp(listeD);
        
        pr.getFormu().getChamp("mois1").setLibelle("Mois");
        pr.getFormu().getChamp("mois2").setVisible(false);
        pr.getFormu().getChamp("mois2").setLibelleAffiche(" ");*/
        
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
        
//        pr.getFormu().getChamp("daty1").setDefaut(date1);
//        pr.getFormu().getChamp("daty2").setDefaut(date2);
        
        String reqniv = request.getParameter("niveau");                  
        
        boolean estFiltre = (reqniv == null || reqniv.equals("")) && (date1 == null || date1.equals("")) && (date2 == null || date2.equals(""));
        
        if(estFiltre) {
            pr.getBase().setNomTable("SITUATIONLCRECETTEV");
        }
        
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        
        if(!estFiltre) {
            ResultatEtSomme rs  = SituationCredit.findSituationCreditRecette((SituationCredit) pr.getCritere(),date1,date2, reqniv, null, colSomme);
            pr.setRs(rs);
            pr.setTableau(new TableauRecherche((bean.ClassMAPTable[]) rs.getResultat(), libEntete));            
            pr.makeTableauRecap();
        }
        
        String[] etatAff = {"Tous", "Créé", "Visé"};
        String[] etatVal = {"", ""+ConstanteEtat.getEtatCreer(), ""+ConstanteEtat.getEtatValider()};
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
        window.location.href = "<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditRecette.jsp&recap=checked";
    <% } %>
    
    window.onload = ajoutChampsNiveau;        
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
            String libEnteteAffiche[] = {"id", "designation", "compte", "annee", "montant", "Engagé", "% engagé", "Encaissé", "% encaissé", "a recouvrir", "reste sur budget"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setLibeEntete(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>