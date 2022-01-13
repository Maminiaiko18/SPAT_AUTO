<%-- 
    Document   : journalcaisse-etat
    Created on : 11 janv. 2022, 13:43:01
    Author     : User
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.EtatJournalCaisse"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String lien = (String) session.getValue("lien");

    String daty = request.getParameter("date");
    if (daty == null || daty.trim().isEmpty()) {
        daty = "" + Utilitaire.dateDuJour();
    }

%>
<style>
    .col1{
        font-weight: bold;
        text-align: center;
        margin-top: 31px;
    }
    .col2{
        text-align: end;
        font-weight: bold;
    }

    .col3{
        text-align: end;
    }

    .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
        padding: 4px;
        border: 1.2px solid;
    }
</style>
<%    try {
        Date date = new java.sql.Date(Utilitaire.stringToDate("dd/mm/yyyy", daty).getTime());
        EtatJournalCaisse ejc = new EtatJournalCaisse(date);
        JournalCaisse[] jc = ejc.getListeDepenses();
%>
<div class="content-wrapper" style="min-height: 560px;background: #f9fafc;">
    <section class="content-header">
        <h1>SOCIETE DU PORT A GESTION AUTONOME DE TOAMASINA</h1>
    </section>
    <div class="row">
        <section class="content" style="min-height: 0px;">
            <div class="col-xs-12">
                <form action="<%=lien%>?but=treso/journalcaisse-etat.jsp" method="post" >
                    <div class="box box-solid collapsed">
                        <div style="background:#103a8e; color:white;" class="box-header with-border">
                            <h3 class="box-title" color="#103a8e"><span color="#103a8e">Recherche avancée</span></h3>
                            <div class="box-tools pull-right"><button data-original-title="Collapse" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="" tabindex="1"><i class="fa fa-plus"></i></button> </div>
                        </div>
                        <div class="box-body" id="pagerecherche">
                            <div class="form-group">
                                <div class="col-md-4">
                                </div>
                                <div class="col-md-4">
                                    <label for="Date" début="">Date</label>
                                    <input name="date" type="text" class="form-control datepicker" id="date" value="<%=daty%>" onkeydown="return searchKeyPress(event)">
                                </div>
                                <div class="col-md-4">
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="row"></div>
                            <div class="row">
                                <div class="col-xs-6" align="center">
                                    <button type="reset" class="btn btn-default" tabindex="33">Réinitialiser</button>
                                </div>
                                <div class="col-xs-6" align="center">
                                    <input name="afficher" value="Afficher" type="submit" class="btn" style="background:#103a8e; color:white" id="btnListe" tabindex="34">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <section class="content" style="min-height: 0px;">
            <div class="col-xs-12 head">
                <div class="col-xs-12 col-sm-8 col-md-8 col1">
                    <p>JOURNAL DE CAISSE</p>
                    <p>CAISSE DEPENSE</p>
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2 col2">
                    <p>Folio N°</p>     
                    <p>JOURNEE DU</p>
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2 col3">
                    <p>226/21</p>     
                    <p><%= daty%></p>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="col-xs-12">
                <table class="table table-bordered table-hover" style="width: 100%;">
                    <tbody>
                        <tr>
                            <th style="text-align: center">NUM PIECE</th>
                            <th style="text-align: center">LIBELLE</th>
                            <th style="text-align: center">DEBIT</th>
                            <th style="text-align: center">CREDIT</th>
                        </tr>

                        <tr>
                            <td rowspan="8" style="text-align: center">
                                <%
                                    int t = jc.length;
                                    for (int i = 0; i < t; i++) {
                                %>
                                <p><%=Utilitaire.champNull(jc[i].getNumPiece())%></p>
                                <%
                                    }
                                %>
                            </td>
                            <td>
                                <%
                                    for (int i = 0; i < t; i++) {
                                %>
                                <p><%=Utilitaire.champNull(jc[i].getLibelle())%></p>
                                <%
                                    }
                                %>
                            </td>
                            <td style="text-align:right">
                                <%
                                    double debit = 0;
                                    for (int i = 0; i < t; i++) {
                                %>
                                <p><%=Utilitaire.formaterAr(jc[i].getCredit())%></p>
                                <%
                                        debit += jc[i].getCredit();
                                    }
                                    debit += ejc.getTotalRecette();
                                %>
                            </td>
                            <td style="text-align:right">
                                <%
                                    double credit = 0;
                                    for (int i = 0; i < t; i++) {
                                %>
                                <p><%=Utilitaire.formaterAr(jc[i].getDebit())%></p>
                                <%
                                        credit += jc[i].getDebit();
                                    }
                                %>

                            </td>
                        </tr>

                        <tr>
                            <td>
                                <b>Recette de la caisse SPAT Journée du </b> <%= daty%>
                            </td>
                            <td style="text-align: end">
                                <%=Utilitaire.formaterAr(debit)%>
                            </td>
                            <td style="text-align: end">
                                <%=Utilitaire.formaterAr(credit)%>
                            </td>
                        </tr
                         <tr>
                            <td style="border: none">
                            </td>
                            <td style="text-align: end">
                                
                            </td>
                            <td style="text-align: end">
                            </td>
                        </tr>
                        <tr>
                            <td style="border: none">
                                2 -REPORT
                            </td>
                            <td style="text-align: end">
                            </td>
                            <td style="text-align: end">
                            </td>
                        </tr> <tr>
                            <td style="border: none">
                                3 -CUMULS (1+2)
                            </td>
                            <td style="text-align: end">
                            </td>
                            <td style="text-align: end">
                            </td>
                        </tr> <tr>
                            <td style="border: none">
                                4 -SOLDE ANTERIEUR
                            </td>
                            <td style="text-align: end">
                                <%=Utilitaire.formaterAr(ejc.getSoldeAnterieur())%>
                            </td>
                            <td style="text-align: end">
                            </td>
                        </tr> <tr>
                            <td style="border: none">
                                5 -SOLDE ACTUEL
                            </td>
                            <td style="text-align: end">
                            </td>
                            <td style="text-align: end">
                                <%=Utilitaire.formaterAr(ejc.getSoldeActuel())%>
                            </td>
                        </tr> <tr>
                            <td style="border-top: none">

                            </td>
                            <td style="text-align: end">
                                <%=Utilitaire.formaterAr(ejc.getTotalDebitEtat())%>
                            </td>
                            <td style="text-align: end">
                                <%=Utilitaire.formaterAr(ejc.getTotalCreditEtat())%>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>
        <section class="content" style="margin-bottom: 8%">
            <div class="col-xs-12">
                <div class="col-xs-12 col-sm-8 col-md-8" style="text-align: center">
                    <p><b>Etabli par:</b>  </p>
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2">
                    <p><b>Vérifié par:</b>  </p>     
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2">

                </div>
            </div>
            <div class="col-xs-12">
                <div class="col-xs-12 col-sm-8 col-md-8" style="text-align: center;font-weight: bold;">
                    <p>JOURNAL DE CAISSE</p>
                    <p>COFFRE BMOI</p>
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2 col2">
                    <p>JOURNEE DU</p>
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2 col3">
                    <p><%= daty%></p>     
                </div>
            </div>
        </section>
        <section class="content">
            <div class="col-xs-12">
                <table class="table table-bordered table-hover" style="width: 100%;">
                    <tbody>
                        <tr>
                            <th style="text-align: center">NUM PIECE</th>
                            <th style="text-align: center">LIBELLE</th>
                            <th style="text-align: center">DEBIT</th>
                            <th style="text-align: center">CREDIT</th> 
                        </tr>
                        <tr>
                            <td rowspan="2"></td>
                            <td> 
                                <p>Espece en coffre BMOI</p>
                                <p>Espece en coffre BMOI</p>
                                <p>Espece en coffre BMOI</p>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;"> Total</td>
                            <td style="text-align: end">0,00</td>
                            <td style="text-align: end">0,00</td>
                        </tr>
                        <tr>
                            <td style="border: none"></td>
                            <td style="border: none;font-weight: bold;text-align: end">COFFRE BMOI</td>
                            <td style="border: none"></td>
                            <td style="text-align: end">0,00</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>
        <section class="content">
            <div class="col-xs-12">
                <div class="col-xs-12 col-sm-8 col-md-8" style="text-align: center">
                    <p><b>Etabli par:</b>  </p>
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2">
                    <p><b>Vérifié par:</b>  </p>     
                </div>
                <div class="col-xs-12 col-sm-2 col-md-2">

                </div>
            </div>
        </section>                
    </div>                
    <a class="btn btn-info pull-right" href="${pageContext.request.contextPath}/Paie?action=journalCaisseEtat&date=<%=date%>" style="margin-right: 10px">Imprimer</a>
</div>
<%} catch (Exception ex) {
        ex.printStackTrace();
    }%>

