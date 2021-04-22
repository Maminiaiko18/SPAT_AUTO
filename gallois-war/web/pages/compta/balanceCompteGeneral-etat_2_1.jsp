

<%@page import="mg.spat.compta.ComptaEtatService"%>
<%@page import="mg.spat.compta.BalanceDesComptesAffichage"%>
<%@page import="mg.spat.compta.BalanceDesComptes"%>

<%@page import="bean.CGenUtil"%>

<%@page import="utilitaire.Utilitaire" %>
<%@page import="java.sql.Date" %>

<%@page import="java.util.*" %>
<%@page import="affichage.PageRechercheGroupe" %>


<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%
    String lang = String.valueOf(session.getAttribute("lang"));
    String[] mots = {"Balance des comptes", "au", "Compte", "Intitule du compte", "Cumul DB", "Cumul CR", "Mois DB", "Mois CR", "Solde DB", "Solde CR", "exporter"};
    String[] ret = Utilitaire.transformerLangue(mots, lang);

    String mois1, mois2, plage1, plage2, exercice, typecompte, date1, date2,etat;
    mois1 = request.getParameter("date1");
    mois2 = request.getParameter("date2");
    plage1 = request.getParameter("plage1");
    plage2 = request.getParameter("plage2");
    exercice = request.getParameter("exercice");
    typecompte = request.getParameter("typecompte");
    etat = request.getParameter("etat");
    date1 = "01/" + Utilitaire.completerInt(2, mois1) + "/" + exercice;
    date2 = Utilitaire.formatterDaty(Utilitaire.getLastDayOfDate("01/" + Utilitaire.completerInt(2, mois2) + "/" + exercice));
    BalanceDesComptes[] lsBalances = ComptaEtatService.traiterBalanceRAnalytiqueSisal(ComptaEtatService.findBalance2AnalytiqueWithEtat(mois1, mois2, date1, date2, plage1, plage2, typecompte, exercice,etat), exercice, date1, date2, mois1, plage1, plage2, typecompte);
    BalanceDesComptesAffichage[] lsBalance = BalanceDesComptesAffichage.afficher(lsBalances);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Balance des comptes g&eacute;n&eacute;raux du <%= date1%> au <%= date2%></title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
       
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1 id="titre-export"><%=ret[0]%> <%= date1%> <%=ret[1]%> <%= date2%></h1>
            </section>
            <%
                //System.out.println("------"+lsBalance.length);
                if (lsBalance != null && lsBalance.length !=0) { 
                    String debit = lsBalance[(lsBalance.length-1)].getSoldeDebiteur();
                    String credit = lsBalance[(lsBalance.length-1)].getSoldeCrediteur();
                    if ( !debit.equals(credit) ){
            %>
                        <div class="alert alert-danger">
                            <strong>Attention!</strong> Balance non conforme.
                        </div>
            <%      }
                }
            %>
            <section class="content">
                <div id="table-container">
                    <table border="1" style="font-size: 12px;width:100%;border-collapse:collapse;">
                        <tr>
                            <th style="text-align:center;"><%=ret[2]%></th>
                            <th style="text-align:center;"><%=ret[3]%></th>
                            <th style="text-align:center;"><%=ret[4]%></th>
                            <th style="text-align:center;"><%=ret[5]%></th>
                            <th style="text-align:center;"><%=ret[6]%></th>
                            <th style="text-align:center;"><%=ret[7]%></th>
                            <th style="text-align:center;"><%=ret[8]%></th>
                            <th style="text-align:center;"><%=ret[9]%></th>
                        </tr>
                        <%if (lsBalance != null) {
                                for (int i = 0; i < lsBalance.length; i++) {
                                    if (lsBalance[i] != null) {
                                        boolean isAux = (lsBalance[i].getTypecompte() != null && lsBalance[i].getTypecompte().compareToIgnoreCase(ComptaEtatService.TYPE_COMPTE_AUX) == 0);

                        %>
                        <tr>
                            <td align="left">
                                 
                                <%if(!lsBalance[i].getCompte().contains("ST"))
                                        {%>
        
                                <a href="<%=session.getAttribute("lien")%>/../../grandLivreCompte-etatMultiple_1.jsp?date1=<%=mois1%>&date2=<%=mois2%>&plage1=<%=lsBalance[i].getCompte().trim()%>&plage2=<%=lsBalance[i].getCompte().trim()%>&exercice=<%=exercice.trim()%>&typecompte=<%=typecompte.trim()%>&etat=<%=etat%>" target="_blank"><% if (!lsBalance[i].getCompte().contains("ST")) {out.print(lsBalance[i].getCompte().trim());}%></a>
                            <%}%>
                            </td>
                            <td align="left"><%= lsBalance[i].getLibelle_compte()%></td>
                            <td align="right"><%= lsBalance[i].getAnterieurDebit()%></td>
                            <td align="right"><%= lsBalance[i].getAnterieurCredit()%></td>
                            <td align="right"><%= lsBalance[i].getMouvementDebit()%></td>
                            <td align="right"><%= lsBalance[i].getMouvementCredit()%></td>
                            <td align="right"><%= lsBalance[i].getSoldeDebiteur()%></td>
                            <td align="right"><%= lsBalance[i].getSoldeCrediteur()%></td>
                        </tr>
                        <% }
                                }
                            }
                        %>

                    </table>
                </div>
                <input id="date1" type="hidden" value="<%= date1%>" />
                <input id="date2" type="hidden" value="<%= date2%>" />
                <input id="plage1" type="hidden" value="<%= plage1%>" />
                <input id="plage2" type="hidden" value="<%= plage2%>" />
                <input id="exercice" type="hidden" value="<%= exercice%>" />
                <input id="typecompte" type="hidden" value="<%= typecompte%>" />
            </section>


            <div class="box box-primary box-solid">

                <div class="box-header with-border">
                    <h3 class="box-title"><%=ret[10]%></h3>
                    <div class="box-tools pull-right">
                        <button   class="btn btn-box-tool" data-widget="collapse" >
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div id="export-body" class="box-body" style="display: block;">
                    <div class="row" style="text-align: center">
                        <label><%=ret[10]%> excel :</label>
                        <button onclick="exporterCsv()">
                            <img src="../../../dist/img/file_xls.png" alt="csv-export">
                        </button>
                        <label><%=ret[10]%> pdf :</label>
                        <a href="<%=request.getContextPath()%>/EtatComptable?action=balanceCompteGeneraux&typecompte=<%=typecompte%>&mois1=<%=mois1%>&mois2=<%=mois2%>&plage1=<%=plage1%>&plage2=<%=plage2%>&exercice=<%=exercice%>&date1=<%=date1%>&date2=<%=date2%>"><img src="../../../dist/img/file_pdf.png" alt="csv-export"></a>
                    </div>
                </div>
            </div>
            <form id="form-export" action="../../../download" method="post">
                <input id="excel-input"  type="hidden" name="table" value="">
                <input type="hidden" name="ext"  value="xls"  checked="checked">
                <input type="hidden" name="donnee" value="0" checked="checked">
                <input type="hidden" name="specific_xls" value="true"/>
                <input type="submit" value="Exporter" class="btn btn-default">
            </form>
            <form id="form-export-pdf" action="<%=(String) session.getValue("lien")%>/../../EtatComptable?action=etatComptablePDF" method="post">
                <input id="excel-input-pdf"  type="hidden" name="table" value="">
                <input type="hidden" name="ext"  value="pdf"  checked="checked">
                <input type="hidden" name="donnee" value="0" checked="checked">
                <input type="hidden" value="Exporter" class="btn btn-default">
            </form>

        </div>
    </body>

    <script>
        function chargerExportPDF()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();

            var excelInput = document.getElementById("excel-input");
            excelInput.value = excel;
            document.location.replace('../../../EtatComptable?action=balanceCompteGeneral&htmlcontent' + excel);
            console.log(excel);
        }

        function chargerExport()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();


            var excelInput = document.getElementById("excel-input");
            excelInput.value = excel;
            console.log("valeur de l'excel" + excelInput.value);
        }
        function chargerExportPDF()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();


            var excelInput = document.getElementById("excel-input-pdf");
            excelInput.value = excel;
            console.log("valeur de l'excel" + excelInput.value);
        }


        function exporterCsv()
        {
            chargerExport()
            var form = $("#form-export");
            form.submit();
        }

        function exporterPDF()
        {
            chargerExportPDF()
            var form = $("#form-export-pdf");
            form.submit();
        }


        function ecranGrandLivreCompte(compte, libelle_compte) {
            var date1, date2, plage1, plage2, exercice, typecompte, url;
            date1 = $('#date1').val();
            date2 = $('#date2').val();
            plage1 = $('#plage1').val();
            plage2 = $('#plage2').val();
            exercice = $('#exercice').val();
            typecompte = $('#typecompte').val();
            url = '../../popup.jsp?but=compta/grandLivreCompte-etat.jsp&compte=' + compte + '&libelle_compte=' + libelle_compte + '&date1=' + date1 + '&date2=' + date2 + '&plage1=' + plage1 + '&plage2=' + plage2 + '&exercice=' + exercice + '&typecompte=' + typecompte;
            window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
        }
        function ecranBalanceAuxiliaire(compte) {
            var date1, date2, plage1, plage2, exercice, typecompte, url;
            date1 = $('#date1').val();
            date2 = $('#date2').val();
            plage1 = $('#plage1').val();
            plage2 = $('#plage2').val();
            exercice = $('#exercice').val();
            typecompte = $('#typecompte').val();
            url = '../../popup.jsp?but=compta/balanceCompteAuxiliaire.jsp&compte_mere=' + compte + '&date1=' + date1 + '&date2=' + date2 + '&exercice=' + exercice + '&typecompte=' + typecompte;
            window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
        }


        function prePrint()
        {

            if (window.print) {
                window.print();

            }
            else
                alert('Votre navigateur ne supporte pas cette action');
        }

    </script>
</html>