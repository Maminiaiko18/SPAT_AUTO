
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
    ComptaBilanRecapPA cbrpa=ComptaService.getRecapPA(null, date1, date2);
    ComptaBilan[] actif = null;
    ComptaBilan[] passif = null;
    if( cbrpa!=null ){
        actif=cbrpa.getListeActif();
        passif=cbrpa.getListePassif();
    }
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>BILAN</h1>
    </section>
    <section class="content">
        <form action="globalnegoce.jsp?but=compta/compta-bilan-actif-passif.jsp" method="post" name="listebilletage" id="listebilletage">
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
                    <div class="col-md-6">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <caption style="text-align: center;">ACTIFS</caption>
                            <thead>
                                <tr>
                                    <th style="background-color:#103a8e;color:#fff;">Rubrique</th>
                                    <th colspan="5" style="background-color:#103a8e;color:#fff;">Montant</th>
                                </tr>
                                <% 
                                    if(actif != null){
                                        for(int i=0; i<actif.length; i++){
                                %>
                                            <tr>
                                                <td><%=actif[i].getRubrique()%></td>
                                                <td align="right"><a href="<%= session.getValue("lien") %>?but=compta/details-ecriture-rubrique-credit.jsp&reference=<%= actif[i].getReference() %>&date1=<%=dateString1%>&date2=<%=dateString2%>"><%=Utilitaire.formaterAr(actif[i].getEc_montant())%></a></td>
                                            </tr>
                                        <%}%>
                                        <tr style="border-bottom: 0px solid #ccc;">
                                            <td colspan=1 align="center"><b>TOTAL ACTIF</b></td>
                                            <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(cbrpa.getMtActif())%></b></td>
                                        </tr>
                                    <%}%>
                            </thead>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <caption style="text-align: center;">PASSIFS</caption>
                            <thead>
                                <tr>
                                    <th style="background-color:#103a8e;color:#fff;">Rubrique</th>
                                    <th colspan="5" style="background-color:#103a8e;color:#fff;">Montant</th>
                                </tr>
                                <% 
                                    if(passif != null){
                                        for(int i=0; i<passif.length; i++){
                                %>
                                            <tr>
                                                <td><%=passif[i].getRubrique()%></td>
                                                <td align="right"><a href="<%= session.getValue("lien") %>?but=compta/details-ecriture-rubrique-debit.jsp&reference=<%= passif[i].getReference() %>&date1=<%=dateString1%>&date2=<%=dateString2%>"><%=Utilitaire.formaterAr(passif[i].getEc_montant())%></a></td>
                                            </tr>
                                        <%}%>
                                            <tr>
                                                <td>Résultat de la période</td>
                                                <td align="right"><%= Utilitaire.formaterAr(cbrpa.getResultat()) %></td>
                                            </tr>
                                        <tr style="border-bottom: 0px solid #ccc;">
                                            <td colspan=1 align="center"><b>TOTAL PASSIF</b></td>
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
