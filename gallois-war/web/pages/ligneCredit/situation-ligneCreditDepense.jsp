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

        String listeCrt[] = {"compteInv", "compteSimple", "direction", "projet", "directionProjet", "daty", "annee"};
        String listeInt[] = {"daty"};
//        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "engageer", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget"};
        String libEntete[] = {"direction", "projet", "montant", "engageer", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget", "resteApresEngmt"};
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
        String moisMin = date1 != null && !date1.isEmpty() ? ""+Utilitaire.stringToInt(Utilitaire.getMois(date1)) : "", moisMax = date2 != null && !date2.isEmpty() ? ""+Utilitaire.stringToInt(Utilitaire.getMois(date2)) : "";
        
        String[] colSomme = {"montant", "engageer", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget", "resteApresEngmt"};
        pr.creerObjetPage(libEntete, colSomme);
        
//        LigneCredit[] liste = LigneCredit.findSituationCreditDepense(request.getParameter("id"), request.getParameter("designation"), request.getParameter("compte"), request.getParameter("daty1"), request.getParameter("daty2"), etatp, reqniv, annee, request.getParameter("mois"), null);
        ResultatEtSomme rs = LigneCredit.findSituationCreditDepense((LigneCredit) pr.getCritere(), date1, date2,annee, null, colSomme);
        pr.setRs(rs);
        pr.setTableau(new TableauRecherche((bean.ClassMAPTable[]) rs.getResultat(), libEntete));
        pr.makeTableauRecap();

        String[] libEtat = {"Tous", "Cr��s", "Vis�s"};
        String[] etat = {"", "" + ConstanteEtat.getEtatCreer(), "" + ConstanteEtat.getEtatValider()};
        
        LigneCredit[] data = (LigneCredit[])pr.getTableau().getData();
%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }
    
    function ajoutChampsNiveau(){
        var d = document.getElementById("pagerecherche");
        var inputanneeniv = "<div class='col-md-4'>\n\
        <label for='anneestr'> Ann�e </label>\n\
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
        <h1>FCC d&eacute;pense</h1>
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
            String libEnteteAffiche[] = {"direction", "projet", "montant", "Engag�", "Factur�", "% engag�", "d�caiss�", "% pay�", "a recouvrir", "reste sur budget", "reste apr�s engagement"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setLibeEntete(libEnteteAffiche);
//            out.println(pr.getTableau().getHtml());
        %>
        <div class="row">
            <div class="box box-solid">
                <div style="background:#ffb401; color:white;" class="box-header">
                    <h3 class="box-title" align="center">LISTE</h3>
                </div>
                <div class="box-body table-responsive no-padding">
                    <div id="selectnonee">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th>Direction</th>
                                    <th>Projet</th>
                                    <th>Montant</th>
                                    <th>Engag&eacute;</th>
                                    <th>Facture</th>
                                    <th>% Factur&eacute;</th>
                                    <th>D&eacute;caiss&eacute;</th>
                                    <th>% D&eacute;caiss&eacute;</th>
                                    <th>A recouvrir</th>
                                    <th>Reste sur budget</th>
                                    <th>Reste apr&egrave;s engagement</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  for (int i = 0; i < data.length; i++) {%>
                                <tr>
                                    <td><%=Utilitaire.champNull(data[i].getDirection())%></td>
                                    <td><%=Utilitaire.champNull(data[i].getProjet())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getMontant())%></td>
                                    <td align="right"><a href="<%= pr.getLien() %>?but=depense/engagement-listefcc.jsp&codeetablissementlib=<%= data[i].getDirection()%>&projetlib=<%= data[i].getProjet() %>&daty1=<%= Utilitaire.champNull(date1) %>&daty2=<%= Utilitaire.champNull(date2) %>"><%=Utilitaire.formaterAr(data[i].getEngageer())%></a></td>
                                    <td align="right"><a href="<%= pr.getLien() %>?but=facture/facture-fournisseur-liste-vaovao.jsp&code_etablissementlib=<%= data[i].getDirection()%>&projetlib=<%= data[i].getProjet() %>&exercice=<%= data[i].getAnnee() %>&mois1=<%= Utilitaire.champNull(moisMin) %>&mois2=<%= Utilitaire.champNull(moisMax) %>"><%=Utilitaire.formaterAr(data[i].getFacture())%></a></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getPourcEngage())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getPaye())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getPourcPaye())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getArecouvrir())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getRestebudget())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getResteApresEngmt())%></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <%

            String compteInv = request.getParameter("compteInv");
            String compteSimple = request.getParameter("compteSimple");
            String direction = request.getParameter("direction");
            String projet = request.getParameter("projet");
            String directionProjet = request.getParameter("directionProjet");
            String daty1 = request.getParameter("daty1");
            String daty2 = request.getParameter("daty2");

            String params="";
            if(compteInv!= null && compteInv.compareToIgnoreCase("null")!=0){
                params=params+"&compteInv="+compteInv;
            }
            if(compteSimple!= null && compteSimple.compareToIgnoreCase("null")!=0){
                
                params=params+"&compteSimple="+compteSimple;
            }
            if(direction!= null && direction.compareToIgnoreCase("null")!=0){
                params=params+"&compteSimple="+compteSimple;
            }

            if(projet!= null && projet.compareToIgnoreCase("null")!=0){
                params=params+"&direction="+direction;
            }
            if(directionProjet!= null && directionProjet.compareToIgnoreCase("null")!=0){
                params=params+"&directionProjet="+directionProjet;
            }
            if(daty1!= null && daty1.compareToIgnoreCase("null")!=0){
                params=params+"&daty1="+daty1;
            }
            if(daty2!= null && daty2.compareToIgnoreCase("null")!=0){
                params=params+"&daty2="+daty2;
            }

            if(annee!= null && annee.compareToIgnoreCase("null")!=0){
                params=params+"&annee="+annee;
            }

            
        %>          
         <a class="btn btn-primary pull-left" href="<%=(String) session.getValue("lien") + "/../../Paie?action=lgc"+params %>" >Imprimer</a>
        <%
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