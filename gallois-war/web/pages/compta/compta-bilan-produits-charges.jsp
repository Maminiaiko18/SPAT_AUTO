
<%@page import="mg.spat.compta.ComptaBilan"%>
<%@page import="java.sql.Date"%>
<%@page import="mg.spat.compta.ComptaBilanRecapPA"%>
<%@page import="service.ComptaService"%>
<%@page import="utilitaire.*"%>
<%
    String dateString1=request.getParameter("date1");
    String dateString2=request.getParameter("date2");
    Date date1=Utilitaire.stringDate(Utilitaire.getDebutAnnee(""+Utilitaire.getAnneeEnCours()));
    Date date2=Utilitaire.stringDate(Utilitaire.getFinAnnee(""+Utilitaire.getAnneeEnCours()));
    if(dateString1!=null && dateString1.compareTo("")!=0){
        date1=Utilitaire.stringDate(dateString1);
    }else{
        dateString1=Utilitaire.getDebutAnnee(""+Utilitaire.getAnneeEnCours());
    }if(dateString2!=null && dateString1.compareTo("")!=0){
        date2=Utilitaire.stringDate(dateString2);
    }else{
        dateString2=Utilitaire.getFinAnnee(""+Utilitaire.getAnneeEnCours());
    }
    ComptaBilanRecapPA cbrpa=ComptaService.getRecapPC(null, date1, date2);
    if( cbrpa!=null ){
    ComptaBilan[] produit=cbrpa.getListeActif();
    System.out.println("actif="+produit.length);
    ComptaBilan[] charges=cbrpa.getListePassif();
    System.out.println("passif="+charges.length);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>COMPTE DE RESULTAT</h1>
    </section>
    <section class="content">
        <form action="globalnegoce.jsp?but=compta/compta-bilan-produits-charges.jsp" method="post" name="listebilletage" id="listebilletage">
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
                                    <label for="date1" min>Date min</label>
                                    <input name="date1" type=text class='form-control datepicker' value="<%=dateString1%>" id="date1"  onkeydown='return searchKeyPress(event)'>
                                </div>
                                <div class='col-md-4'>
                                    <label for="date2">Date max</label>
                                    <input name="date2" type=text class='form-control datepicker'  id="date2"  value="<%=dateString2%>" onkeydown='return searchKeyPress(event)'>
                                </div>
                                
                            </div>
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
        </form>
    </section>
    
    <div class="box box-solid">
        <div style="background:#ffb401; color:white;" class="box-header">
            <h3 class="box-title" align="center">Bilan</h3>
        </div>
        <div class="box-body table-responsive no-padding">                           
            <div class="box-body table-responsive no-padding">
                <div id="selectnonee">
                    <div class="row">
                        <div class="col-md-6">
                            <section class="content-header">
                                <h5 class="text-center">PRODUITS</h5>
                            </section>
                        </div>
                        <div class="col-md-6">
                            <section class="content-header">
                                <h5 class="text-center">CHARGES</h5>
                            </section>
                        </div>
                    </div>
                    <div class="row">
                    <div class="col-md-6">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th style="background-color:#103a8e;color:#fff;">Rubrique</th>
                                    <th colspan="5" style="background-color:#103a8e;color:#fff;">Montant</th>
                                </tr>
                                <% 
                                    if(produit != null){
                                        for(int i=0; i<produit.length; i++){
                                %>
                                            <tr>
                                                <td><%=produit[i].getRubrique()%></td>
                                                <td align="right"><a href="<%= session.getValue("lien") %>?but=compta/details-ecriture-rubrique-produits.jsp&reference=<%= produit[i].getReference() %>&date1=<%=dateString1%>&date2=<%=dateString2%>"><%=Utilitaire.formaterAr(produit[i].getEc_montant())%></a></td>
                                            </tr>
                                        <%}%>
                                        <tr style="border-bottom: 0px solid #ccc;">
                                            <td colspan=1 align="center"><b>TOTAL PRODUITS</b></td>
                                            <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(cbrpa.getMtActif())%></b></td>
                                        </tr>
                                    <%}%>
                            </thead>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th style="background-color:#103a8e;color:#fff;">Rubrique</th>
                                    <th colspan="5" style="background-color:#103a8e;color:#fff;">Montant</th>
                                </tr>
                                <% 
                                    if(charges != null){
                                        for(int i=0; i<charges.length; i++){
                                %>
                                            <tr>
                                                <td><%=charges[i].getRubrique()%></td>
                                                <td align="right"><a href="<%= session.getValue("lien") %>?but=compta/details-ecriture-rubrique-charges.jsp&reference=<%= charges[i].getReference() %>&date1=<%=dateString1%>&date2=<%=dateString2%>"><%=Utilitaire.formaterAr(charges[i].getEc_montant())%></a></td>
                                            </tr>
                                        <%}%>
                                        <tr style="border-bottom: 0px solid #ccc;">
                                            <td colspan=1 align="center"><b>TOTAL CHARGES</b></td>
                                            <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(cbrpa.getMtPassif())%></b></td>
                                        </tr>
                                <%}%>
                            </thead>
                        </table>
                    </div>
                    </div>
                </div>
            </div>                            
        </div>
    </div> 
</div>

    

<% } %>