<%-- 
    Document   : details-ecriture-rubrique
    Created on : 26 févr. 2020, 11:46:24
    Author     : Admin
--%>

<%@page import="bean.AdminGen"%>
<%@page import="mg.spat.compta.DetailsRubrique"%>
<%@page import="mg.spat.compta.ComptaBilan"%>
<%@page import="utilitaire.*"%>
<%
    try{
    String reference = request.getParameter("reference");
    String dateString1 = request.getParameter("date1");
    String dateString2 = request.getParameter("date2");
    String cpt_rubrique = Utilitaire.champNull(request.getParameter("cpt_rubrique"));
    
    
    DetailsRubrique[] details = ComptaBilan.getSolde(reference, "comptabilanactif", "Debit", dateString1, dateString2,cpt_rubrique);
    double total=AdminGen.calculSommeDouble(details, "ec_montant");
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Détails écriture rubrique</h1>
    </section>
    <section class="content">
        <form action="globalnegoce.jsp?but=compta/details-ecriture-rubrique-credit.jsp" method="post" name="listebilletage" id="listebilletage">
            <div class='row'>
                <div class='row col-md-12'>
                    <div class='box box-solid collapsed collapsed-box'>
                        <div style='background:#103a8e; color:white;'class='box-header with-border'>
                            <h3 class='box-title' color='#edb031'><span color='#edb031'>Recherche avanc&eacute;e</span></h3>
                            <div class='box-tools pull-right'>
                                <button data-original-title='Collapse' class='btn btn-box-tool' data-widget='collapse' data-toggle='tooltip' title=''><i class='fa fa-plus'></i></button> </div>
                        </div>
                        <div class='box-body' id='pagerecherche'>
                            <div class='form-group'>
                                <div class='col-md-4'>
                                    <label for="cpt_rubrique" min>Numero de compte</label>
                                    <input name="cpt_rubrique" type=text class='form-control' value="<%=cpt_rubrique%>" id="cpt_rubrique" onkeydown='return searchKeyPress(event)'>
                                </div>
                                <div class='col-md-4'>
                                    <label for="date1" min>Date min</label>
                                    <input name="date1" type=text class='form-control datepicker' value="<%=dateString1%>" id="date1"  onkeydown='return searchKeyPress(event)'>
                                </div>
                                <div class='col-md-4'>
                                    <label for="date2">Date max</label>
                                    <input name="date2" type=text class='form-control datepicker'  id="date2"  value="<%=dateString2%>" onkeydown='return searchKeyPress(event)'>
                                </div>
                                    <input name="reference" type=hidden value="<%=reference%>" id="reference"  >
                            </div>
                            <div class='form-group'>
                                <div class='col-xs-6' align='right'>
                                    <button type='submit' class='btn' style='background:#103a8e; color:white' id='btnListe'>Afficher</button>
                                </div>
                                <div class='col-xs-6' align='left'>
                                    <button type='reset' class='btn btn-default'>R&eacute;initialiser</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>
    <div class="box box-solid">
        <div style="background:#ffb401; color:white;" class="box-header">
            <h3 class="box-title" align="center">Détails écriture rubrique</h3>
        </div>
        <div class="box-body table-responsive no-padding">                           
            <div class="box-body table-responsive no-padding">
                <div id="selectnonee">
                    <div class="col-md-12">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                           <thead>
                                <tr>
                                   <th style="background-color:#103a8e;color:#fff;">Numero de compte</th>
                                     <th  style="background-color:#103a8e;color:#fff;">Libellé</th>
                                    <th style="background-color:#103a8e;color:#fff;">Montant</th>
                                </tr>
                                <% 
                                    if(details != null){
                                        for(int i=0; i<details.length; i++){
                                %>
                                            <tr>
                                               <td><%=details[i].getCpt_rubrique()%></td>
                                                 <td><%=details[i].getLibelle_cpt_rubrique()%></td>
                                                <td align="right"><%=Utilitaire.formaterAr(details[i].getEc_montant())%></td>
                                            </tr>
                                        <%}%>
                                    <%}%>
                                    
                                <tr style="font-weight:bold">
                                    <td colspan="2" align="center" >TOTAL</td>
                                    <td align="right"><%=Utilitaire.formaterAr(total)%></td>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>                            
        </div>
    </div>
</div>
<%
} catch(Exception e){
e.printStackTrace();
}
%>