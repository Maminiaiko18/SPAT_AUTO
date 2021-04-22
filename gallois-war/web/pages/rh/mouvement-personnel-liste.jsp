<%@page import="java.util.Map"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.relationhumaine.MouvementPersonnel"%>
<%@page import="service.SpatService"%>
<%@page import="java.util.HashMap"%>
<%
    String date=request.getParameter("dateMouvement");
    if(date==null || date.compareTo("")==0) date=Utilitaire.dateDuJour();
    Date dateString=Utilitaire.stringDate(date) ;
    HashMap<String,MouvementPersonnel> mp= SpatService.getMouvementPersonnel(dateString);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>MOUVEMENT POSTE</h1>
    </section>
    <section class="content">
        <form action="globalnegoce.jsp?but=rh/mouvement-personnel-liste.jsp" method="post" name="listebilletage" id="listebilletage">
            <div class='row'>
                <div class='row col-md-12'>
                    <div class='box box-solid collapsed collapsed-box'>
                        <div style='background-color:#103a8e; color:white;'class='box-header with-border'>
                            <h3 class='box-title' color='#edb031'><span color='#edb031'>Recherche avanc&eacute;e</span></h3>
                            <div class='box-tools pull-right'>
                                <button data-original-title='Collapse' class='btn btn-box-tool' data-widget='collapse' data-toggle='tooltip' title=''><i class='fa fa-plus'></i></button> </div>
                        </div>
                        <div class='box-body' id='pagerecherche'>
                            <div class='form-group'>
                                <div class='col-md-4'>
                                    <label for=Date min>Date</label>
                                    <input name=dateMouvement type=text class='form-control datepicker' value="<%=date%>" id=dateMouvement  onkeydown='return searchKeyPress(event)'>
                                </div>
                            </div>
                            <div class='col-xs-6' align='right'>
                                <button type='submit' class='btn' style='background:#3c2517; color:white' id='btnListe'>Afficher</button>
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
                    <div class="col-md-12">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th style="background-color:#103a8e;color:#fff;">Motif</th>
                                    <th style="background-color:#103a8e;color:#fff;">Mois anterieur</th>
                                    <th style="background-color:#103a8e;color:#fff;">Mois en cours</th>
                                    <th style="background-color:#103a8e;color:#fff;">Cumul</th>
                                </tr>
                                <% 
                                    if(mp != null){
                                       for (Map.Entry mapentry : mp.entrySet()) {
                                        MouvementPersonnel mouvp=(MouvementPersonnel)mapentry.getValue();
                                %>
                                            <tr>
                                                <td><%=mouvp.getMotif()%></td>
                                                <td ><%=mouvp.getMois_anterieur() %></td>
                                                <td ><%=mouvp.getMois_encours()%></td>
                                                <td ><%=mouvp.getCumul() %></td>
                                            </tr>
                                        <%}%>
                                        
                                    <%}%>
                            </thead>
                        </table>
                    </div>
                    
                </div>
            </div>                            
        </div>
    </div> 
</div>
                        