<%@page import="mg.spat.compta.ComptaEtatService"%>
<%@page import="mg.spat.compta.ComptaEtatGrandLivre"%>
<%@page import="bean.CGenUtil"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="utilitaire.Utilitaire" %>
<%@page import="java.sql.Date" %>

<%
    String compte, libelle_compte, date1, date2, plage1, plage2, exercice, typecompte, aux;
    ComptaEtatGrandLivre grandLivre, lsGrandLivre[];
    compte = request.getParameter("compte");
    aux = request.getParameter("aux");    
    libelle_compte = request.getParameter("libelle_compte");
    date1 = Utilitaire.formatterDaty(Utilitaire.stringDate(request.getParameter("date1")));
    date2 = Utilitaire.formatterDaty(Utilitaire.stringDate(request.getParameter("date2")));
    plage1 = request.getParameter("plage1");
    plage2 = request.getParameter("plage2");
    exercice = request.getParameter("exercice");
    typecompte = request.getParameter("typecompte");
    grandLivre = new ComptaEtatGrandLivre();
    String apresWhere = "";
   if(compte!= null && !compte.isEmpty()){
      apresWhere = " and compte ='"+compte+"'"; 
   }
   if(aux!=null && !aux.isEmpty() && typecompte!=null && !typecompte.isEmpty()){
       apresWhere = " and compte ='"+typecompte+"' and auxiliaire = '"+aux+"'";

   }
    if (request.getParameter("tablee") != null && request.getParameter("tablee").compareToIgnoreCase("") != 0) {
        grandLivre.setNomTable(request.getParameter("tablee"));
    }
    lsGrandLivre = (ComptaEtatGrandLivre[]) CGenUtil.rechercher(grandLivre, null, null, apresWhere+ " AND daty >= '" + date1 + "' AND daty <= '" + date2 + "' order by daty asc");
    ComptaEtatService.traiterGrandLivre(lsGrandLivre);
    double sommeDebit = 0;
    double sommeCredit = 0;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Grand livre du compte <%=aux%> <%= libelle_compte%></title>
        <!-- Tell the browser to be responsive to screen width-->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../../elements/css.jsp'/>

        <script>
            function changerDesignation() {
                document.incident.submit();
            }
        </script>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1 id="titre-export">Grand livre du compte <%=Utilitaire.champNull(aux)%> <%= Utilitaire.champNull(libelle_compte)%></h1>
            </section>
            <section class="content">
                <a href="/gallois/pages/compta/etat/grandLivreCompte-etat.jsp?aux=<%=Utilitaire.champNull(request.getParameter("aux"))%>&compte=<%=request.getParameter("compte")%>&libelle_compte=<%=request.getParameter("libelle_compte")%>&plage1=<%=request.getParameter("plage1")%>&plage2=<%=request.getParameter("plage2")%>&date1=<%=date1%>&date2=<%=date2%>&exercice=<%=request.getParameter("exercice")%>&typecompte=<%=request.getParameter("typecompte")%>&tablee=COMPTA_GRAND_LIVRE_NONLETTRE" class="btn btn-danger">Non lettré</a>
                <a href="/gallois/pages/compta/etat/grandLivreCompte-etat.jsp?aux=<%=Utilitaire.champNull(request.getParameter("aux"))%>&compte=<%=request.getParameter("compte")%>&libelle_compte=<%=request.getParameter("libelle_compte")%>&plage1=<%=request.getParameter("plage1")%>&plage2=<%=request.getParameter("plage2")%>&date1=<%=date1%>&date2=<%=date2%>&exercice=<%=request.getParameter("exercice")%>&typecompte=<%=request.getParameter("typecompte")%>&tablee=COMPTA_GRAND_LIVRE_LETTRE" class="btn btn-success">Lettré</a> 
                <a href="/gallois/pages/compta/etat/grandLivreCompte-etat.jsp?aux=<%=Utilitaire.champNull(request.getParameter("aux"))%>&compte=<%=request.getParameter("compte")%>&libelle_compte=<%=request.getParameter("libelle_compte")%>&plage1=<%=request.getParameter("plage1")%>&plage2=<%=request.getParameter("plage2")%>&date1=<%=date1%>&date2=<%=date2%>&exercice=<%=request.getParameter("exercice")%>&typecompte=<%=request.getParameter("typecompte")%>&tablee=COMPTA_GRAND_LIVRE" class="btn btn-success">Tous</a> 

                <div id="table-container">
                <table class="table table-bordered">
                    <tr>
                        <th>Compte</th>
                        <th>JL</th>
                        <th>Date</th>
                        <th>Libelle</th>
                        <th>Lettrage</th>
                        <th>D&eacute;bit</th>
                        <th>Cr&eacute;dit</th>
                        <th>D&eacute;biteur</th>
                        <th>Cr&eacute;diteur</th>
                    </tr>
                    <% for (ComptaEtatGrandLivre uneLigne : lsGrandLivre) {
                            sommeDebit += uneLigne.getDebit();
                            sommeCredit += uneLigne.getCredit();
                    %>
                    <tr>
                        <td><a onclick="ecranEcritureComptable('<%= uneLigne.getId()%>')"><%= compte %></a></td>
                        <td><%= uneLigne.getJournal()%></td>                    
                        <td><%= Utilitaire.formatterDaty(uneLigne.getDaty())%></td> 
                        <td><%= uneLigne.getLibelle()%></td> 
                        <td><%= Utilitaire.champNull(uneLigne.getLettrage())%></td> 
                        <td align="right"><%= Utilitaire.formaterAr(uneLigne.getDebit())%></td>                    
                        <td align="right"><%= Utilitaire.formaterAr(uneLigne.getCredit())%></td>  
                        <td align="right"><%= Utilitaire.formaterAr(uneLigne.getDebiteur())%></td>                    
                        <td align="right"><%= Utilitaire.formaterAr(uneLigne.getCrediteur())%></td>  
                    </tr>    
                    <% }%>
                    <tr>
                        <td></td>
                        <td><b>Total</b></td>                    
                        <td></td> 
                        <td></td> 
                        <td></td> 
                        <td align="right"><b><%= Utilitaire.formaterAr(sommeDebit)%></b></td>                    
                        <td align="right"><b><%= Utilitaire.formaterAr(sommeCredit)%></b></td>                          
                    </tr>
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
                            <img src="../dist/img/file_xls.png" alt="csv-export">	
                        </button>
                        <label>exporter pdf :</label>
                        <button data-toggle="modal" data-target="#grandLivreCompte" style="margin-right: 10px"><img src="../dist/img/file_pdf.png" alt="csv-export"></button>  
                    </div>
            </div>
            <form id="form-export" action="../download" method="post">
                <input id="excel-input"  type="hidden" name="table" value="">
                <input type="hidden" name="ext"  value="xls"  checked="checked">                    
                <input type="hidden" name="donnee" value="0" checked="checked">
                <input type="hidden" value="Exporter" class="btn btn-default">
            </form>
        </div>
<div class="modal fade" id="grandLivreCompte" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post" action="${pageContext.request.contextPath}/EtatComptable?action=etatdeveloppementsolde">
                <input type="hidden" name="compte" value="<%=compte%>">
                <input type="hidden" name="libellecompte" value="<%=libelle_compte%>">
                <input type="hidden" name="auxiliaire" value="<%=aux%>">
                <input type="hidden" name="typecompte" value="<%=typecompte%>">
                <input type="hidden" name="table" value="<%=request.getParameter("tablee")%>">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Export Grand Livre</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="pull-center">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Mois</label>
                                    <select name="mois">
                                        <% for(int i=Utilitaire.getMois(Utilitaire.stringDate(date1));i<=Utilitaire.getMois(Utilitaire.stringDate(date2));i++){
                                        %>
                                        <option value="<%=i%>"><%=Utilitaire.nbToMois(i)%></option>
                                        <%
                                        }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Année</label>
                                    <select name="annee">
                                        <% for(int i=Utilitaire.getAnnee(Utilitaire.stringDate(date1));i<=Utilitaire.getAnnee(Utilitaire.stringDate(date2));i++){
                                        %>
                                        <option value="<%=i%>"><%=i%></option>
                                        <%
                                        }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-default">Imprimer</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
                </div>
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
            document.location.replace('../../../ExportServlet?titre='+titre+"&htmlcontent="+excel);
        }
        function chargerExport()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();
            
            
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
        
        function ecranEcritureComptable(id) {
            url = 'compta/etat/ecritureComptable-etat.jsp?id=' + id;
            window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
        }
    </script>    
</html>
