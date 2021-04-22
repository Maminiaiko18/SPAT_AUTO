
<%@page import="mg.spat.PrevisionLibComplet"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="mg.spat.TableauAffichageData"%>
<%@page import="java.util.Map"%>
<%@page import="bean.TypeObjet"%>
<%@page import="java.sql.Date"%>
<%@page import="service.SpatService"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.RecapMouvementQuais"%>
<%
    try {
        Date date_d = Utilitaire.ajoutJourDate(Utilitaire.dateDuJour(), -3);
        Date date_f = Utilitaire.ajoutJourDate(Utilitaire.dateDuJour(), 3);
        String dateAr1 = request.getParameter("date_arrivee1");
        String dateAr2 = request.getParameter("date_arrivee2");

        if (dateAr1 != null && dateAr1.trim().equalsIgnoreCase("") == false)
        {
            date_d = Utilitaire.stringDate(dateAr1);
        }
        if (dateAr2 != null && dateAr2.trim().equalsIgnoreCase("") == false) {
            date_f = Utilitaire.stringDate(dateAr2);
        }

//        if (request.getParameter("date_arrivee1") != null && request.getParameter("date_arrivee1") != "") {
//            System.out.println(date_d);
//            date_d = Utilitaire.stringDate(request.getParameter("date_arrivee1"));
//        }
//        if (request.getParameter("date_arrivee2") != null && request.getParameter("date_arrivee2") != "") {
//            date_f = Utilitaire.stringDate(request.getParameter("date_arrivee2"));
//        }
        TableauAffichageData tad = new TableauAffichageData();
        tad.getRecapAffichage(null, date_d, date_f);
        MouvementLibComplet[] listeOccupation = tad.getListeOccupation();
        PrevisionLibComplet[] listePrevision = tad.getListePrevision();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Tableau d'affichage</h1>
    </section>
    <section class="content">
        <form action="<%=(String) session.getValue("lien")%>?but=capitainerie/tableau-affichage.jsp" method="post" name="listenavire" id="listenavire">
            <div class="row col-md-12">
                <div class="box box-solid collapsed">
                    <div style="background-color:#103a8e; color:white;" class="box-header with-border">
                        <h3 class="box-title" color="#edb031"><span color="#edb031">Recherche avancée</span></h3>
                        <div class="box-tools pull-right">
                            <button data-original-title="Collapse" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title=""><i class="fa fa-minus"></i></button>
                        </div>
                    </div>
                    <div class="box-body" id="pagerecherche" style="display: block;">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label for="Date">Date arrivée min</label>
                                <input name="date_arrivee1" type="text" class="form-control datepicker" id="date_arrivee1" value="<%=Utilitaire.formatterDaty(date_d)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                            <div class="col-md-6">
                                <label for="Date">Date arrivée max</label>
                                <input name="date_arrivee2" type="text" class="form-control datepicker" id="date_arrivee2" value="<%=Utilitaire.formatterDaty(date_f)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                            </br>
                        </div>
<!--                        <div class="form-group">
                            <div class="col-md-6">
                                <label for="Date">Date départ min</label>
                                <input name="date_depart1" type="text" class="form-control datepicker" id="date_arrivee1" value="<%=Utilitaire.formatterDaty(date_d)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                            <div class="col-md-6">
                                <label for="Date">Date départ max</label>
                                <input name="date_depart2" type="text" class="form-control datepicker" id="date_arrivee2" value="<%=Utilitaire.formatterDaty(date_f)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                        </div>-->
                        <div class="form-group">
                            <div class="col-md-4"></div>
                        </div>
                    </div>
                    <div class="box-footer" style="display: block;">
                        <div class="row col-md-12"></div>
                        <div class="row col-md-12">
                            <div class="col-xs-6" align="right">
                                <button type="submit" class="btn" style="background:#103a8e; color:white" id="btnListe">Afficher</button>
                            </div>
                            <div class="col-xs-6" align="left">
                                <button type="reset" class="btn btn-default">Réinitialiser</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="row">
            <div class="row col-md-12">
                <div class="box box-solid">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">TABLEAU D'AFFICHAGE</h3>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th colspan="12" style="background-color:#103a8e;color:#fff;">Mouvement des navires</th>                                       
                                    </tr>
                                    <tr>
                                        <th>Navire</th>
                                        <th>Consignataire</th>
                                        <th>Cargaison</th>
                                        <th>Provenance</th>
                                        <th>Quai</th>
                                        <th>Destination</th>
                                        <th>Quai</th>
                                        <th>Date d'arrivée</th>
                                        <th>Heure d'arrivée</th>
                                        <th>Date de départ prévue</th>
                                        <th>Heure de départ prévue</th>
                                        <th>Durée</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (listeOccupation.length != 0) {
                                            for (int i = 0; i < listeOccupation.length; i++) {
                                    %>
                                    <tr>
                                        
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getNomnavire())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getDesceconsignataire())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getValcargaison())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getValpaysprovenance())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getValquaisprovenance())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getValpaysdestination())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getValquaisdestination())%></td>                               <td><%=Utilitaire.formatterDaty("" + listeOccupation[i].getDatearrivee())%></td>

                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getHeure())%></td>
                                         <td><%=Utilitaire.formatterDaty("" + listeOccupation[i].getDate_depart())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getHeure_depart())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getDuree())%></td>

                                    </tr>
                                    <% }
                                        }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th colspan="12" style="background-color:#103a8e;color:#fff;">Prévision de touchées des navires</th>                                       
                                    </tr>
                                    <tr>
                                        <th>Navire</th>
                                        <th>Consignataire</th>
                                        <th>Cargaison</th>
                                        <th>Provenance</th>
                                        <th>Quai</th>
                                        <th>Destination</th>
                                        <th>Quai</th>
                                        <th>Date d'arrivée</th>
                                        <th>Heure d'arrivée</th>
                                        <th>Date de départ prévue</th>
                                        <th>Heure de départ prévue</th>
                                        <!--<th>Durée</th>-->
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  if (listePrevision.length > 0) {
                                            for (int i = 0; i < listePrevision.length; i++) {
                                    %>
                                    <tr>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getNomnavire())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValconsignataire())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValcargaison())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValpaysprovenance())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValquaisprovenance())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValpaysdestination())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValquaisdestination())%></td>       
                                        <td><%=Utilitaire.formatterDaty("" + listePrevision[i].getDate_arrivee())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getHeure_arrivee())%></td>  
                                        <td><%=Utilitaire.formatterDaty("" + listePrevision[i].getDate_depart())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getHeure_depart())%></td>
                                        <!--<td><%/*Utilitaire.champNull("" + listePrevision[i].getDuree())*/%></td>-->

                                    </tr>
                                    <% }
                                        }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<script type="text/javascript">
    setTimeout(function () {
        location.reload();
    }, 30000);
</script>

<%  } catch (Exception ex) {
        ex.printStackTrace();
        System.out.println(" ex : " + ex);
    }%>