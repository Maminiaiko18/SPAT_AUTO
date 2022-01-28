<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mg.spat.PrevisionLibComplet"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="mg.spat.TableauAffichageData"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        Date date = Utilitaire.dateDuJourSql();

        Date date_d = Utilitaire.ajoutJourDate(Utilitaire.dateDuJour(), -3);
        Date date_f = Utilitaire.ajoutJourDate(Utilitaire.dateDuJour(), 3);

        TableauAffichageData tad = new TableauAffichageData();
        tad.getRecapAffichage(null, date_d, date_f);
        MouvementLibComplet[] listeOccupation = tad.getListeOccupation();
        PrevisionLibComplet[] listePrevision = tad.getListePrevision();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page='pages/elements/css.jsp'/>
        <style>
            .tables-container{
                display: flex;
            }
                    
            .part{
                width: 480px;
                height: 1920px;
            }
            
            .part > *{
                width: 100%;
            }
            
            .part > table{
                font-size: 10px;
            }
            
        </style>
    </head>
    <body>
        <div class="tables-container">
                <div class="box box-solid part">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">PREVISION D'ESCALE AU PORT DE TOAMASINA</h3>
                    </div>
                            <table border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th colspan="12" style="background-color:#103a8e;color:#fff;text-align: center;">DATE : <input style="color: black; height: 28px;" type="date" data-date="" readonly value="<%= date%>"  class="form-group" data-date-format="DD MMMM YYYY"></th>                                     
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
                                    <%  for (int i = 0; i < listePrevision.length; i++) {%>
                                    <tr>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getNomnavire())%></td>
                                        <td><%=Utilitaire.formatterDaty("" + listePrevision[i].getDate_arrivee())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValquaisprovenance())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValcargaison())%></td>
                                        <td><%=Utilitaire.champNull("" + listePrevision[i].getValconsignataire())%></td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                </div>
                <div class="box box-solid part">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">OCCUPATION DES QUAIS</h3>
                    </div>
                            <table border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th colspan="12" style="background-color:#103a8e;color:#fff;text-align: center;">DATE : <input style="color: black; height: 28px;" type="date" data-date="" class="form-group" value="<%= date%>" readonly data-date-format="DD MMMM YYYY"></th>                                       
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
                                    <% for (int i = 0; i < listeOccupation.length; i++) {%>
                                    <tr>

                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getValquaisdestination())%></td>
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getNomnavire())%></td>
                                        <td><%=Utilitaire.formatterDaty("" + listeOccupation[i].getDatearrivee())%></td>
                                        <td><%=Utilitaire.champNull(listeOccupation[i].getValcargaison())%></td>
                                        <td><%=Utilitaire.formatterDaty("" + listeOccupation[i].getDate_depart_prev())%></td> 
                                        <td><%=Utilitaire.champNull("" + listeOccupation[i].getDesceconsignataire())%></td>

                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                </div>
        </div>
    </body>
</html>
<script type="text/javascript">
    setTimeout(function () {
        location.reload();
    }, 30000);
</script>
<%  } catch (Exception ex) {
        ex.printStackTrace();
        System.out.println(" ex : " + ex);
    } %>
