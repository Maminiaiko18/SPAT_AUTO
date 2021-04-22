
<%@page import="mg.spat.compta.ConsultationCompte"%>
<%@page import="bean.CGenUtil"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="utilitaire.Utilitaire" %>
<%@page import="java.sql.Date" %>

<%
    String lang = String.valueOf(session.getAttribute("lang"));
    String[] mots = {"Grand livre du compte", "au", "Compte", "Libelle du compte", "Journal", "Date", "Libelle", "Lettrage", "Mouvement", "Debit", "Credit", "Solde", "exporter"};
    String[] ret = Utilitaire.transformerLangue(mots, lang);
    String date1, date2, plage1, plage2, exercice, mois1, mois2, typecompte,etat;
    mois1 = request.getParameter("date1");
    mois2 = request.getParameter("date2");
    etat= request.getParameter("etat");
    exercice = request.getParameter("exercice");
    date1 = "01/01/" + exercice;
    date2 = Utilitaire.formatterDaty(Utilitaire.getLastDayOfDate("01/" + Utilitaire.completerInt(2, mois2) + "/" + exercice));
    plage1 = request.getParameter("plage1");
    plage2 = request.getParameter("plage2");
    typecompte = request.getParameter("typecompte");
    String valeur = "";
    ConsultationCompte[] cc = null;
    ConsultationCompte cc1 = new ConsultationCompte();
    cc = cc1.traiterConsultation2AnalytiqueMultipleWithEtat("", mois1, mois2, exercice, plage1, plage2, typecompte,etat);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Grand livre du compte du <%=plage1%> au <%=plage2%></title>
        <!-- Tell the browser to be responsive to screen width-->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1 id="titre-export"><%=ret[0]%> <%=plage1%> <%=ret[1]%> <%= plage2%></h1>
            </section>
            <section class="content">
                <div id="table-container">
                    <table id="export" border="1" style="border-collapse:collapse;">
                    <%  //String v = "<table><thead><tr><td>Grand livre du compte " + plage1 + " au " + plage2 + "</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></thead><tbody>";
                        for (int j = 0; j < cc.length; j++) {%>
                    <%
                        if (cc != null && cc[j] != null) {
                            /*v += "<tr><td></td></tr>";
                            v += "<tr><td>COMPTE: " + cc[j].getComptech() + "</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";
                            v += "<tr>";
                            v += "<th>Id Mvt</th>";
                            v += "<th>Date</th>";
                            v += "<th>Jrn/Folio</th>";
                            v += "<th>Contrep.</th>";
                            v += "<th>Libelle oper.</th>";
                            v += "<th>Debit</th>";
                            v += "<th>Credit</th>";
                            v += "<th>Lettre</th>";
                            v += "<th>Compte analytique</th>";
                            v += "<th>Etat</th>";
                            v += "</tr>";

                            v += "<tr>";
                            v += "<td></td><td></td><td></td><td></td>";
                            v += "<td>Ancien cumul...</td>";
                            v += "<td>";*/
                    %>
                    
                    
                    
                            <tr>
                                <td><b>COMPTE:</b></td>
                                <td><b><%= cc[j].getComptech()%></b></td>
                         
                                <td colspan="9"></td>
                            </tr>
                            <tr>
                                <th style="text-align: left;">Compte</th>
                                <th style="text-align: left;">Id Mvt</th>
                                <th style="text-align: left;">Date</th>
                                <th style="text-align: left;">Jrn/Folio</th>
                                <th style="text-align: left;">Contrep.</th>
                                <th style="text-align: center">Libelle oper.</th>
                                <th style="text-align: center">Debit</th>
                                <th style="text-align: center">Credit</th>
                                <th style="text-align: center">Lettre</th>
                                    <%
                                        if (typecompte.compareToIgnoreCase("1") == 0)/* compte general*/ {
                                    %>
                                <th style="text-align: left">Compte analytique</th>
                                    <%
                                    } else {
                                    %>
                                <th style="text-align: left">Compte g�n�rale</th>
                                    <%
                                        }
                                    %>
                                <th style="text-align: center">Etat</th>
                            </tr>



                            <tr>
                                <td colspan="5"></td>
                                <td>Ancien cumul...</td>
                                <td style="text-align: right">
                                    <%if (cc[j].getAncienCumulDebit() == 0) {
                                            out.print("");
                                            //v += "";
                                        } else {
                                            out.print(Utilitaire.formaterAr(cc[j].getAncienCumulDebit()));
                                           // v += Utilitaire.formaterAr(cc[j].getAncienCumulDebit());
                                        }
                                    %>
                                </td>
                                <td style="text-align: right">
                                    <% if (cc[j].getAncienCumulCredit() == 0) {
                                            out.print("");
                                            //v += "";
                                        } else {
                                            out.print(Utilitaire.formaterAr(cc[j].getAncienCumulCredit()));
                                            //v += Utilitaire.formaterAr(cc[j].getAncienCumulCredit());
                                        }
                                    %>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <%
                                /*v += "</td>";
                                v += "<td></td>";
                                v += "<td></td>";
                                v += "</tr>";*/
                                if (cc[j].getListe() != null && cc[j].getListe().length > 0) {
                                    String color = "black";
                                    for (int i = 0; i < cc[j].getListe().length; i++) {
                                        if (cc[j].getListe()[i] != null) {
                                            if (cc[j].getListe()[i].getEtat() == 1) {
                                                color = "red";
                                            } else if (cc[j].getListe()[i].getEtat() == 11) {
                                                color = "black";
                                            }
                            %>
                            <tr>
                                <td>
                                    <%= cc[j].getComptech()%>
                                </td>
                                <td>
                                    <a href="<%=(String) session.getAttribute("lien")%>/../../../gallois.jsp?but=compta/ecriture/ecriture-fiche.jsp&id=<%=cc[j].getListe()[i].getMere()%>" target="_blank"><%=cc[j].getListe()[i].getMere()%></a>
                                </td>
                                <td>
                                    <%= Utilitaire.formatterDaty(cc[j].getListe()[i].getDaty())%>
                                </td>
                                <td>
                                    <%= cc[j].getListe()[i].getJournal()%>/<%= cc[j].getListe()[i].getFolio()%>
                                </td>
                                <td>
                                    <%= Utilitaire.champNull(cc[j].getListe()[i].getContrep())%>
                                </td>
                                <td>
                                    <%= cc[j].getListe()[i].getRemarque()%>
                                </td>
                                <td style="text-align: right">
                                    <%if (cc[j].getListe()[i].getDebit() == 0) {
                                            out.print("");
                                        } else {
                                            out.print(Utilitaire.formaterAr(cc[j].getListe()[i].getDebit()));
                                        }%>
                                </td>
                                <td style="text-align: right"> 
                                    <%if (cc[j].getListe()[i].getCredit() == 0) {
                                            out.print("");
                                        } else {
                                            out.print(Utilitaire.formaterAr(cc[j].getListe()[i].getCredit()));
                                        }%>
                                </td>                                        
                                <td style="text-align: left"> 
                                    <%= cc[j].getListe()[i].getLettrage()%>
                                </td>
                                <td style="text-align: left"><%= cc[j].getListe()[i].getReference_engagement()%></td>
                                <td style="text-align: left; color:<%=color%>"> 
                                    <%if (cc[j].getListe()[i].getEtat() == 1) {
                                            out.print("NON VISE");
                                        } else if (cc[j].getListe()[i].getEtat() == 11) {
                                            out.print("VISE");
                                        }%>
                                </td>
                            </tr>                                    
                            <%
                                   /* v += "<tr>";
                                    v += "<td>"
                                            + cc[j].getListe()[i].getMere()
                                            + "</td>";
                                    v += "<td>"
                                            + Utilitaire.formatterDaty(cc[j].getListe()[i].getDaty())
                                            + "</td>";
                                    v += "<td>"
                                            + cc[j].getListe()[i].getJournal() + "/" + cc[j].getListe()[i].getFolio()
                                            + "</td>"
                                            + "<td>"
                                            + Utilitaire.champNull(cc[j].getListe()[i].getContrep())
                                            + "</td>"
                                            + "<td>"
                                            + cc[j].getListe()[i].getRemarque()
                                            + "</td>"
                                            + "<td>";
                                    if (cc[j].getListe()[i].getDebit() != 0) {
                                        v += Utilitaire.formaterAr(cc[j].getListe()[i].getDebit());
                                    }
                                    v += "</td>";
                                    v += "<td>";
                                    if (cc[j].getListe()[i].getCredit() != 0) {
                                        v += Utilitaire.formaterAr(cc[j].getListe()[i].getCredit());
                                    }
                                    v += "</td>";
                                    v += "<td>"
                                            + cc[j].getListe()[i].getLettrage()
                                            + "</td>"
                                            + "<td> ";
                                    v += cc[j].getListe()[i].getReference_engagement()+"</td><td>";
                                    if (cc[j].getListe()[i].getEtat() == 1) {
                                        v += "NON VISE";
                                    } else if (cc[j].getListe()[i].getEtat() == 11) {
                                        v += "VISE";
                                    }
                                    v += "</td>";
                                    v += "</tr> ";*/
                                }
                            %>
                            <% }
                                }
                            %>

                            <tr>
                                <td colspan="5"></td><td><b>TOTAL</b></td>
                                <td style="text-align: right">
                                    <b><%= Utilitaire.formaterAr(cc[j].getTotalDebit())%></b>
                                </td>
                                <td style="text-align: right">
                                    <b><%= Utilitaire.formaterAr(cc[j].getTotalCredit())%></b>
                                </td>
                                <td></td><td></td><td></td>
                            </tr>
                            <%
                               /* v += "<tr>";
                                v += "<td></td><td></td><td></td><td></td><td><b>TOTAL</b></td>";
                                v += "<td>";
                                v += "<b>" + Utilitaire.formaterAr(cc[j].getTotalDebit()) + "</b>";
                                v += "</td>";
                                v += "<td>"
                                        + "<b>" + Utilitaire.formaterAr(cc[j].getTotalCredit()) + "</b>"
                                        + "</td>"
                                        + "</tr>";*/
                            %>
                            <tr>
                                <td colspan="5"></td>
                                <td><b>CUMUL</b></td>
                                <td style="text-align: right">
                                    <b><%= Utilitaire.formaterAr(cc[j].getCumulDebit())%></b>
                                </td>
                                <td style="text-align: right">
                                    <b><%= Utilitaire.formaterAr(cc[j].getCumulCredit())%></b>
                                </td><td></td><td></td><td></td>
                            </tr>
                            <%
                               /* v += "<tr>"
                                        + "<td></td><td></td><td></td><td></td>"
                                        + "<td><b>CUMUL</b></td>"
                                        + "<td>"
                                        + "<b>" + Utilitaire.formaterAr(cc[j].getCumulDebit()) + "</b>"
                                        + "</td>"
                                        + "<td>"
                                        + "<b>" + Utilitaire.formaterAr(cc[j].getCumulCredit()) + "</b>"
                                        + "</td>"
                                        + "</tr>";
                                */
                            %>
                            <tr>
                                <td colspan="5"></td>
                                <td><b>SOLDE</b></td>
                                <td style="text-align: right">
                                    <b><%if (cc[j].getSoldeCredit() == 0) {
                                            out.print("");
                                        } else {
                                            out.print(Utilitaire.formaterAr(cc[j].getSoldeCredit()));
                                        }%></b>
                                </td>
                                <td style="text-align: right">
                                    <b><%if (cc[j].getSoldeDebit() == 0) {
                                            out.print("");
                                        } else {
                                            out.print(Utilitaire.formaterAr(cc[j].getSoldeDebit()));
                                        }%></b>
                                </td>

                            </tr>
                            <%
                                /*v += "<tr>"
                                        + "<td></td><td></td><td></td><td></td>"
                                        + "<td><b>SOLDE</b></td>"
                                        + "<td>";
                                if (cc[j].getSoldeCredit() != 0) {
                                    v += "<b>" + Utilitaire.formaterAr(cc[j].getSoldeCredit()) + "</b>";
                                }
                                v += "</td>";
                                v += "<td>";
                                if (cc[j].getSoldeDebit() != 0) {
                                    v += "<b>" + Utilitaire.formaterAr(cc[j].getSoldeDebit()) + "</b>";
                                }
                                v += "</td>"
                                        + "</tr>";
                               */
                            %>

                    
                    <% } %>
                    <% }
                        //v += "</tbody></table>";%> 
                        <tr>
                            <td colspan="11"></td>
                        </tr>
                    </table>
                </div>
                <input id="date1" type="hidden" value="<%= date1%>" />
                <input id="date2" type="hidden" value="<%= date2%>" />
                <input id="plage1" type="hidden" value="<%= plage1%>" />
                <input id="plage2" type="hidden" value="<%= plage2%>" />
                <input id="exercice" type="hidden" value="<%= exercice%>" />
                <input id="typecompte" type="hidden" value="<%= typecompte%>" />
                <input id="etat" type="hidden" value="<%= etat%>" />
            </section>


            <div class="box box-primary box-solid">

                <div class="box-header with-border">
                    <h3 class="box-title">Exporter</h3>
                    <div class="box-tools pull-right">
                        <button   class="btn btn-box-tool" data-widget="collapse" >
                            <i class="fa fa-minus"></i>
                        </button> 
                    </div>
                </div>

                <div id="export-body" class="box-body" style="display: block;">

                    <div id="export-body" class="box-body" style="display: block;">
                        <div class="row" style="text-align: center">
                            <label>Export excel :</label>
                            <a href="<%=request.getContextPath()%>/EtatComptable?action=exportGrandLivrePDF&date1=<%=mois1%>&date2=<%=mois2%>&plage1=<%=plage1%>&plage2=<%=plage2%>&typecompte=<%=typecompte%>&exercice=<%=exercice%>&etat=<%=etat%>&type=xls">
                            <img src="../../../dist/img/file_xls.png" alt="csv-export"></a>
                            <!--<button onclick="javascript:exporterCsv()">
                                <img src="../../../dist/img/file_xls.png" alt="csv-export">
                            </button>-->
                            <label>Export pdf :</label>
                            <a href="<%=request.getContextPath()%>/EtatComptable?action=exportGrandLivrePDF&date1=<%=mois1%>&date2=<%=mois2%>&plage1=<%=plage1%>&plage2=<%=plage2%>&typecompte=<%=typecompte%>&exercice=<%=exercice%>&etat=<%=etat%>">
                                <img src="../../../dist/img/file_pdf.png" alt="csv-export"></a>
                        </div>
                    </div>
                    
                   <form id="form-export" action="../../../download" method="post">
                        <input type="hidden" name="ext"  value="xls"  checked="checked">
                        <input type="hidden" name="donnee" value="0" checked="checked">
                        <input type="hidden" name="specific_xls" value="true"/>
                        <input id="excel-input"  type="hidden" name="table">
                    </form>
                        
                    <form id="form-export-pdf" action="<%=(String) session.getValue("lien")%>/EtatComptable?action=exportGrandLivrePDF&date1=<%=mois1%>&date2=<%=mois2%>&plage1=<%=plage1%>&plage2=<%=plage2%>&typecompte=<%=typecompte%>&exercice=<%=exercice%>&etat=<%=etat%>" method="post">
                        <input id="excel-input-pdf"  type="hidden" name="table" value="">
                        <input type="hidden" name="ext"  value="pdf"  checked="checked">
                        <input type="hidden" name="donnee" value="0" checked="checked">
                        <input type="hidden" value="Exporter" class="btn btn-default">
                    </form>

                </div>
            </div>
        </div>
    </body>
    <script>
        function chargerExportPDF()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();

            var excelInput = document.getElementById("excel-input");
            excelInput.value = excel;
            document.location.replace('../../../ExportServlet?titre=' + titre + "&htmlcontent=" + excel);
        }
        function chargerExport()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();
            

            var excelInput = document.getElementById("excel-input");
            excelInput.value = excel;
            console.log("valeur de l'excel" + excelInput.value);
        }
        function changerExportExcel()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();
            

            var excelInput = document.getElementById("donnee");
            excelInput.value = excel;
            //console.log("valeur de l'excel" + excelInput.value);
        }



        function exporterCsv()
        {
            chargerExport(); 
            var form = $("#form-export");
            form.submit();
        }

        function ecranEcritureComptable(id) {
            url = 'compta/etat/ecritureComptable-etat.jsp?id=' + id;
            window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
        }
    </script>    
</html>
