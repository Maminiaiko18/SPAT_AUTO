
<%@page import="bean.CGenUtil"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="utilitaire.Utilitaire" %>
<%@page import="java.sql.Date" %>
<%@page import="mg.spat.compta.ComptaEtatEcriture" %>
<%
   String id;
   ComptaEtatEcriture ecriture, lsEcriture[];
   id = request.getParameter("id");
   ecriture = new ComptaEtatEcriture();
   ecriture.setId(id);
   lsEcriture = (ComptaEtatEcriture[]) CGenUtil.rechercher(ecriture, null, null, " order by debit desc");
   double debit = 0;
   double credit=0;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Ecriture comptable</title>
        <!-- Tell the browser to be responsive to screen width-->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
           <section class="content-header"> 
                <h1 id="titre-export">Ecriture comptable</h1>
            </section>
            <section class="content">
                <div id="table-container">
                <table class="table table-bordered">
                    <tr>
                        <th>Compte</th>
                        <th>Libelle</th>
                        <th>Date</th>
                        <th>Débit</th>
                        <th>Crédit</th>
                    </tr>
                    <% for(ComptaEtatEcriture uneLigne : lsEcriture) { %>
                        <tr>
                            <td><%= uneLigne.getCompte()%></td>
                            <td><%= uneLigne.getLibelle()%></td>
                            <td><%= Utilitaire.formatterDaty(uneLigne.getDaty()) %></td> 
                            <td align="right"><%= Utilitaire.formaterAr(uneLigne.getDebit())%></td>                    
                            <td align="right"><%= Utilitaire.formaterAr(uneLigne.getCredit())%></td>                            
                        </tr>    
                    <% debit = debit + uneLigne.getDebit(); credit = credit + uneLigne.getCredit();} 
                        double solde = debit - credit;
                        double soldedebit = 0, soldecredit = 0;
                        if(solde>0){ soldedebit = solde; soldecredit = 0;}
                        if(solde<0){ soldedebit = 0; soldecredit = solde;}
                    %>
                    <tr>
                        <td colspan="3"><b>TOTAL</b></td>
                        <td align="right"><b><%= Utilitaire.formaterAr(debit)%></b></td>                    
                        <td align="right"><b><%= Utilitaire.formaterAr(credit)%></b></td>                            
                    </tr>  
                    <tr>
                        <td colspan="3"><b>SOLDE</b></td>
                        <td align="right"><b><%= Utilitaire.formaterAr(soldedebit)%></b></td>                    
                        <td align="right"><b><%= Utilitaire.formaterAr(soldecredit)%></b></td>                            
                    </tr>  
                </table>
                </div>
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
                    <div class="row" style="text-align: center">
                        <label>exporter excel :</label>
                        <button onclick="exporterCsv()">
                            <img src="../../../dist/img/file_xls.png" alt="csv-export">	
                        </button>
                    </div>
                </div>
            </div>
            <form id="form-export" action="../../../download" method="post">
                <input id="excel-input"  type="hidden" name="table" value="">
                <input type="hidden" name="ext"  value="xls"  checked="checked">                    
                <input type="hidden" name="donnee" value="0" checked="checked">
                <input type="hidden" value="Exporter" class="btn btn-default">
            </form>
        </div>
                <script>
                    
                    
        
        function chargerExport()
        {
            var excel = $('#table-container').html();
            
            
            var excelInput = document.getElementById("excel-input");
            excelInput.value = excel;
            console.log("valeur de l'excel" + excelInput.value);
        }
           
        function exporterCsv()
        {
            chargerExport()
            var form = $("#form-export");
            form.submit();
        }
                </script>
    </body>   
</html>