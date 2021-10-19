<%@page import="mg.spat.PrevisionLibComplet"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="mg.spat.TableauAffichageData"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        Date date = Utilitaire.dateDuJourSql();
        
        TableauAffichageData tad = new TableauAffichageData();
        tad.getRecapAffichage(null, date, date);
        MouvementLibComplet[] listeOccupation = tad.getListeOccupation();
        PrevisionLibComplet[] listePrevision = tad.getListePrevision();
%>
<div class="content-wrapper">
    <section class="content-header">
    </section>
    <section class="content">
        <div class="row">
            <div class="row col-md-12">
                <div class="box box-solid">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">PREVISION D'ESCALE AU PORT DE TOAMASINA</h3>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th colspan="12" style="background-color:#103a8e;color:#fff;text-align: center;">DATE : <input style="color: black; height: 28px;" type="date" data-date="" readonly value="<%= date %>"  class="form-group" data-date-format="DD MMMM YYYY"></th>                                     
                                    </tr>
                                    <tr>
                                        <th>NOM NAVIRE</th>
                                        <th>ETA</th>
                                        <th>PROVENANCE</th>
                                        <th>CARGAISON</th>
                                        <th>CONSIGNATAIRE / ARMATEUR</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   <%  for (int i = 0; i < listePrevision.length; i++) { %>
                                    <tr>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getNomnavire())%></td>
                                        <td><%=Utilitaire.formatterDaty("" + listePrevision[i].getDate_arrivee())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValquaisprovenance())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValcargaison())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValconsignataire())%></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-md-12">
                <div class="box box-solid">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">OCCUPATION DES QUAIS</h3>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th colspan="12" style="background-color:#103a8e;color:#fff;text-align: center;">DATE : <input style="color: black; height: 28px;" type="date" data-date="" class="form-group" value="<%= date %>" readonly data-date-format="DD MMMM YYYY"></th>                                       
                                    </tr>
                                    <tr>
                                        <th>NOM DU QUAIS</th>
                                        <th>NOM NAVIRE</th>
                                        <th>DATE DE MISE A QUAI</th>
                                        <th>OPERATIONS</th>
                                        <th>ETD</th>
                                        <th>CONSIGNATAIRE / ARMATEUR</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   <% for (int i = 0; i < listeOccupation.length; i++) { %>
                                    <tr>
                                        
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getValquaisdestination())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getNomnavire())%></td>
                                        <td><%=Utilitaire.formatterDaty("" + listeOccupation[i].getDatearrivee())%></td>
                                        <td></td>
                                        <td><%=Utilitaire.formatterDaty("" + listeOccupation[i].getDate_depart())%></td> 
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getDesceconsignataire())%></td>
                                       
                                    </tr>
                                    <% } %>
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