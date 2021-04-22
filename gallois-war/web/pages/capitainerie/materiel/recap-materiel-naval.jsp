
<%@page import="mg.spat.RecapMateriel"%>
<%@page import="mg.spat.RecapQuai"%>
<%@page import="mg.spat.RecapMaterielData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="mg.spat.MaterielNaval"%>
<%@page import="mg.spat.RecapMaterielNaval"%>
<%@page import="bean.TypeObjet"%>
<%@page import="java.sql.Date"%>
<%@page import="service.SpatService"%>
<%@page import="mg.spat.RecapMouvement"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.PageRecherche"%>

<%
    try{
        Date date_d = Utilitaire.dateDuJourSql();
        Date date_f = Utilitaire.dateDuJourSql();

        if(request.getParameter("occup_date_arrivee1")!=null){
            date_d = Utilitaire.stringDate(request.getParameter("occup_date_arrivee1"));
        }else{
            date_d = Utilitaire.stringDate(Utilitaire.dateDuJour());
        }  
        if(request.getParameter("occup_date_arrivee2")!=null){
            date_f = Utilitaire.stringDate(request.getParameter("occup_date_arrivee2"));
        }else{
            date_f = Utilitaire.stringDate(Utilitaire.dateDuJour());
        }

        RecapMaterielData service = new RecapMaterielData(date_d,date_f);
        ArrayList<HashMap<String,Object>> autres = service.getAutres();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Récapitulation des matériels navals</h1>
    </section>
    <section class="content">
        <form action="<%=(String) session.getValue("lien")%>?but=capitainerie/materiel/recap-materiel-naval.jsp" method="post" name="listenavire" id="listenavire">
            <div class="row col-md-12">
                <div class="box box-solid collapsed">
                    <div style="background-color:#103a8e; color:white;" class="box-header with-border">
                        <h3 class="box-title" color="#edb031"><span color="#edb031">Recherche avancée</span></h3>
                        <div class="box-tools pull-right">
                            <button data-original-title="Collapse" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title=""><i class="fa fa-minus"></i></button>
                        </div>
                    </div>
                    <div class="box-body" id="pagerecherche" style="display: block;">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label for="Date" début="">Date début</label>
                                <input name="occup_date_arrivee1" type="text" class="form-control datepicker" id="occup_date_arrivee1" value="<%=Utilitaire.formatterDaty(date_d)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                            <div class="col-md-6">
                                <label for="Date" fin="">Date fin</label>
                                <input name="occup_date_arrivee2" type="text" class="form-control datepicker" id="occup_date_arrivee2" value="<%=Utilitaire.formatterDaty(date_f)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                            
                        </div>
                        <div class="form-group">
                            <div class="col-md-4"></div>
                        </div>
                    </div>
                    <div class="box-footer" style="display: block;">
                        <div class="row col-md-12"></div>
                                    <div class="row col-md-12">
                            <div class="col-xs-6" align="right">
                                <button type="submit" class="btn" style="background:#103a8e; color:white" id="btnListe">Afficher</button>
                            </div>
                            <div class="col-xs-6" align="left">
                                <button type="reset" class="btn btn-default">Réinitialiser</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="row">
            <div class="row col-md-12">
                <div class="box box-solid">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">LISTE</h3>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th style="background-color:#103a8e;color:#fff; text-align: center;">Dénomination</th>
                                        <th colspan="4" style="background-color:#103a8e;color:#fff; text-align: center;">Occupation actuelle</th>
                                        <th colspan="4" style="background-color:#103a8e;color:#fff; text-align: center;">Prévision de la journée</th>
                                    </tr>                               
                                </thead>
                                <tbody>
                                    <tr>
                                        <th></td>
                                        <th>Opération</th>
                                        <th>Position</th>
                                        <th>Heure début</th>
                                        <th>Heure fin</th>
                                        <th>Opération</th>
                                        <th>Position</th>
                                        <th>Heure début</th>
                                        <th>Heure fin</th>
                                    </tr>
                                    <%
                                        for(int i=0;i<autres.size();i++){
                                            ArrayList<RecapMateriel> prev=(ArrayList<RecapMateriel>)autres.get(i).get("Occupation");
                                            %>
                                    
                                    <%
                                        if(prev!=null){
                                            for(int j=0;j==0 || j<prev.size() || j<prev.size();j++){
                                    %>
                                        <tr>
                                            <td><a href="<%=((String) session.getValue("lien"))+"?but=capitainerie/materiel/materiel-naval-liste.jsp&id="+prev.get(j).getIdmateriel_naval_occup() %>"><%=Utilitaire.champNull(prev.get(j).getDenomination_occup()) %></a></td>   
                                            <td><%=Utilitaire.champNull(prev.get(j).getNature_occup()) %></td>
                                            <td><%=Utilitaire.champNull(prev.get(j).getPosition_occup()) %></td>
                                            <td><%=Utilitaire.champNull(prev.get(j).getHeuredebut_occup())%></td>
                                            <td><%=Utilitaire.champNull(prev.get(j).getHeurefin_occup())%></td>
                                            <td><%=Utilitaire.champNull(prev.get(j).getNature_prev())%></td>
                                            <td><%=Utilitaire.champNull(prev.get(j).getPosition_prev())%></td>
                                            <td><%=Utilitaire.champNull(prev.get(j).getHeuredebut_prev()) %></td>
                                            <td><%=Utilitaire.champNull(prev.get(j).getHeurefin_prev())%></td>
                                        </tr>
                                    <% }} else{%>
                                        <tr>
                                            <td><a href="<%=((String) session.getValue("lien"))+"?but=capitainerie/materiel/materiel-naval-liste.jsp&id="+((MaterielNaval)autres.get(i).get("materiel")).getId()%>"><%=Utilitaire.champNull(((MaterielNaval)autres.get(i).get("materiel")).getDenomination()) %></a></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    <% }} %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%  }catch(Exception ex){
    ex.printStackTrace();
    System.out.println(" ex : "+ex);
}%>