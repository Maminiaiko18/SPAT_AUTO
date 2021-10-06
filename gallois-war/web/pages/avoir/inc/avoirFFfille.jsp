<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="avoir.AvoirFCFille"%>
<%
    String id = request.getParameter("id");
    AvoirFCFille avoirFille=new AvoirFCFille();
    avoirFille.setNomTable("AVOIRFFFILLE_MONTANTFACTURE");
    AvoirFCFille[] detail= (AvoirFCFille[]) CGenUtil.rechercher(avoirFille , null, null, " and idmere = '" + id+ "'");
    
%>
    <!--    detail      -->
    <div class="row">
       <div class="col-md-12">
           <div class="box-body">
               <table class="table table-striped table-bordered table-condensed table-responsive tree">
                    <thead>
                        <tr>
                            <th style="background-color:#bed1dd;">Id</th>
                            <th style="background-color:#bed1dd;">Detail Facture</th>
                            <th style="background-color:#bed1dd;">D&eacute;signation</th>
                            <th style="background-color:#bed1dd;">Montant</th>
                            <th style="background-color:#bed1dd;">Compte</th>
                            <th style="background-color:#bed1dd;">Devise</th>
                        </tr>
                       </thead>
                    <tbody>
                          <%if(detail==null || detail.length==0){%>
                          <tr>
                               <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                           </tr>
                         <%} else{
                               for(AvoirFCFille item : detail){%> 
                           <tr class="treegrid-1 treegrid-expanded">
                               <td><%=Utilitaire.champNull(item.getId())%></td>
                               <td><%=Utilitaire.champNull(item.getIddetailfacture())%></td>
                               <td><%=Utilitaire.champNull(item.getDesignation())%></td>
                               <td><%=Utilitaire.formaterAr(item.getMontant())%></td>
                               <td><%=Utilitaire.champNull(item.getCompte())%></td>
                               <td><%=Utilitaire.champNull(item.getDevise())%></td>
                           </tr>
                           <%}}%>
                    </tbody>
               </table>
           </div>
       </div>
    </div>