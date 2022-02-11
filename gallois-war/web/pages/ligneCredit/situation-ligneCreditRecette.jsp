<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="java.lang.reflect.Field"%>
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
        pr.setApres("ligneCredit/situation-ligneCreditRecette.jsp");

        String date1 = request.getParameter("daty1"), date2 = request.getParameter("daty2"), annee = request.getParameter("annee");
        if (date1 == null || date1.trim().isEmpty()) {
            date1 = "01/01/" + Utilitaire.getAnneeEnCours();
            pr.getFormu().getChamp("daty1").setDefaut(date1);
        }
        //if(date2 == null || date2.trim().isEmpty()) date2 = "31/12/"+Utilitaire.getAnneeEnCours();
        if (annee == null || annee.trim().isEmpty()) {
            annee = Utilitaire.getAnneeEnCours();
            pr.getFormu().getChamp("annee").setDefaut(annee);
        }

//        pr.getFormu().getChamp("daty1").setDefaut(date1);
//        pr.getFormu().getChamp("daty2").setDefaut(date2);
        String reqniv = request.getParameter("niveau");

        String[] colSomme = new String[] {"montant", "facture", "paye", "arecouvrir", "restebudget"};
        pr.creerObjetPage(libEntete, colSomme);
        
        Field[] listF = pr.getTableau().getListeField();

        ResultatEtSomme rs = SituationCredit.findSituationCreditRecette((SituationCredit) pr.getCritere(), date1, date2, reqniv, null, colSomme);
        pr.setRs(rs);
        pr.setTableau(new TableauRecherche((bean.ClassMAPTable[]) rs.getResultat(), libEntete));
        pr.getTableau().setListeField(listF);
        pr.makeTableauRecap();

        String[] etatAff = {"Tous", "Créé", "Visé"};
        String[] etatVal = {"", "" + ConstanteEtat.getEtatCreer(), "" + ConstanteEtat.getEtatValider()};
        
        SituationCredit[] data = (SituationCredit[])pr.getTableau().getData();
%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }

    function ajoutChampsNiveau() {
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

    <%if (request.getParameter("recap") == null || request.getParameter("recap").equals("")) {%>
    window.location.href = "<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditRecette.jsp&recap=checked";
    <% }%>

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
                        <%for (int i = 0; i < etatVal.length; i++) {
                                String selected = Utilitaire.champNull(request.getParameter("etat")).equals(etatVal[i]) ? "selected" : "";
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
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/fiche-ligneCreditRecette.jsp", pr.getLien() + "?but=facture/facture-client-fille-liste.jsp&compte=" + Utilitaire.champNull(request.getParameter("compte")) + "&recap=checked&daty1="+ Utilitaire.champNull(date1) + "&daty2=" + Utilitaire.champNull(date2)};
            String colonneLien[] = {"id", "facture"};
            String urlLien[] = {"id", "facture"};
            String urlLienAffiche[] = {"id", "id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "designation", "compte", "annee", "montant", "Engagé", "% engagé", "Encaissé", "% encaissé", "a recouvrir", "reste sur budget"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setUrlLien(urlLien);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);

            
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
                                    <th>Id</th>
                                    <th>Designation</th>
                                    <th>Compte</th>
                                    <th>Année</th>
                                    <th>Montant</th>
                                    <th>Facture</th>
                                    <th>% Engag&eacute;</th>
                                    <th>Paye</th>
                                    <th>% Pay&eacute;</th>
                                    <th>Arecouvrir</th>
                                    <th>Restebudget</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  for (int i = 0; i < data.length; i++) {%>
                                <tr>
                                    <td><a href="<%= pr.getLien() %>?but=ligneCredit/fiche-ligneCreditRecette.jsp&id=<%= data[i].getId() %>"><%=Utilitaire.champNull(data[i].getId())%></a></td>
                                    <td><%=Utilitaire.champNull(data[i].getDesignation())%></td>
                                    <td><%=Utilitaire.champNull(data[i].getCompte())%></td>
                                    <td><%= data[i].getAnnee() %></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getMontant())%></td>
                                    <td align="right"><a href="<%= pr.getLien() %>?but=facture/facture-client-fille-liste.jsp&compte=<%= Utilitaire.champNull(data[i].getCompte()) %>&recap=checked&daty1=<%= Utilitaire.champNull(date1) %>&daty2=<%= Utilitaire.champNull(date2) %>"><%=Utilitaire.formaterAr(data[i].getFacture())%></a></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getPourcEngage())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getPaye())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getPourcPaye())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getArecouvrir())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(data[i].getRestebudget())%></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <%= pr.getBasPage()%>                    
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>