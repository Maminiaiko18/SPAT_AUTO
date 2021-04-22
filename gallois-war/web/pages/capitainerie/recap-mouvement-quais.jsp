
<%@page import="mg.spat.RecapQuai"%>
<%@page import="mg.spat.Quais"%>
<%@page import="mg.spat.Prevision"%>
<%@page import="mg.spat.Mouvement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datas.RecapQuaisDatas"%>
<%@page import="mg.spat.RecapOccupationQuais"%>
<%@page import="java.util.Map"%>
<%@page import="bean.TypeObjet"%>
<%@page import="java.sql.Date"%>
<%@page import="service.SpatService"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.RecapMouvementQuais"%>
<%
    try{
    Date date_d = Utilitaire.dateDuJourSql();
    Date date_f = Utilitaire.dateDuJourSql();
    String type = "";
    
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
    if(request.getParameter("occup_typequaidestination")!=null)
        type = request.getParameter("occup_typequaidestination");
    
    
    RecapQuaisDatas service = new RecapQuaisDatas(date_d,date_f,type);
    ArrayList<HashMap<String,Object>> autres = service.getAutres();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Récapitulation des mouvements quais</h1>
    </section>
    <section class="content">
        <form action="<%=(String) session.getValue("lien")%>?but=capitainerie/recap-mouvement-quais.jsp" method="post" name="listenavire" id="listenavire">
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
                            <div class="col-md-4">
                                <label for="Date" début="">Date début</label>
                                <input name="occup_date_arrivee1" type="text" class="form-control datepicker" id="occup_date_arrivee1" value="<%=Utilitaire.formatterDaty(date_d)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                            <div class="col-md-4">
                                <label for="Date" fin="">Date fin</label>
                                <input name="occup_date_arrivee2" type="text" class="form-control datepicker" id="occup_date_arrivee2" value="<%=Utilitaire.formatterDaty(date_f)%>" onkeydown="return searchKeyPress(event)">
                            </div>
                            <div class="col-md-4">
                                <label for="Type" quais="" occupation="">Type quais occupation</label>
                                <input name="occup_typequaidestination" type="textbox" class="form-control" id="occup_typequaidestination" value="" onkeydown="return searchKeyPress(event)">
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
                                        <th style="background-color:#103a8e;color:#fff;">Dénomination</th>
                                        <th colspan="7" style="background-color:#103a8e;color:#fff;">Occupation</th>
                                        <th colspan="6" style="background-color:#103a8e;color:#fff;">Prévision</th>
                                    </tr>
                                    <tr>
                                        <th>Dénomination</th>
                                        <th>Numéro escale</th>
                                        <th>Type mouvement</th>
                                        <th>Navire</th>
                                        <th>Consignataire</th>
                                        <th>Cargaison</th>
                                        <th>Date arrivée</th>
                                        <th>Date départ</th>
                                        <th>Navire</th>
                                        <th>Consignataire</th>
                                        <th>Cargaison</th>
                                        <th>Date arrivée</th>
                                        <th>Date départ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        Mouvement mouvement = new Mouvement();
                                       
                                        Prevision prevision = new Prevision();
                                        
                                        for(int i=0;i<autres.size();i++){
                                            Quais rq=(Quais)autres.get(i).get("quais");
                                            ArrayList<RecapQuai> prev=(ArrayList<RecapQuai>)autres.get(i).get("Occupation");
                                        if(prev!=null){
                                            for(int j=0;j==0 || j<prev.size() || j<prev.size();j++){
                                    %>
                                        <tr>
                                            <td><a href="<%=((String) session.getValue("lien"))+"?but=capitainerie/mouvement-liste.jsp&quaisdestination="+prev.get(j).getIdquai()%>"><%=Utilitaire.champNull(prev.get(j).getNomquai()) %></a></td>   
                                            <td><%=Utilitaire.champNull(prev.get(j).getNumeroescale_occup()) %></td>
                                            <!--type mouvement-->
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getValmvt()).equals("-")) { %><%=mouvement.getCouleur() %><% } %>;"><%=Utilitaire.champNull(prev.get(j).getValmvt()) %></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getNomnavire_occup()).equals("-")) { %><%=mouvement.getCouleur() %><% } %>;"><%=Utilitaire.champNull(prev.get(j).getNomnavire_occup()) %></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getValconsignataire_occup()).equals("-")) { %><%=mouvement.getCouleur() %><% } %>;"><%=Utilitaire.champNull(prev.get(j).getValconsignataire_occup())%></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getCargval_occup()).equals("-")) { %><%=mouvement.getCouleur() %><% } %>;"><%=Utilitaire.champNull(prev.get(j).getCargval_occup())%></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getValmvt()).equals("-") && !Utilitaire.champNull(prev.get(j).getNomnavire_occup()).equals("-") && !Utilitaire.champNull(prev.get(j).getValconsignataire_occup()).equals("-") && !Utilitaire.champNull(prev.get(j).getCargval_occup()).equals("-")) { %><%=mouvement.getCouleur() %><% } %>;"><%=Utilitaire.formatterDaty(prev.get(j).getDate_arrivee_occup())%></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getValmvt()).equals("-") && !Utilitaire.champNull(prev.get(j).getNomnavire_occup()).equals("-") && !Utilitaire.champNull(prev.get(j).getValconsignataire_occup()).equals("-") && !Utilitaire.champNull(prev.get(j).getCargval_occup()).equals("-")) { %><%=mouvement.getCouleur() %><% } %>;"><%=Utilitaire.formatterDaty(prev.get(j).getDate_depart_occup())%></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getNomnavire_prev()).equals("-")) { %><%=prevision.getCouleur() %><% } %>;"><%=Utilitaire.champNull(prev.get(j).getNomnavire_prev()) %></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getValconsignataire_prev()).equals("-")) { %><%=prevision.getCouleur() %><% } %>;"><%=Utilitaire.champNull(prev.get(j).getValconsignataire_prev())%></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getCargval_prev()).equals("-")) { %><%=prevision.getCouleur() %><% } %>;"><%=Utilitaire.champNull(prev.get(j).getCargval_prev())%></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getNomnavire_prev()).equals("-") && !Utilitaire.champNull(prev.get(j).getValconsignataire_prev()).equals("-") && !Utilitaire.champNull(prev.get(j).getCargval_prev()).equals("-")) { %><%=prevision.getCouleur() %><% } %>;"><%=Utilitaire.formatterDaty(prev.get(j).getDate_arrivee_prev())%></td>
                                            <td style="background-color: <% if(!Utilitaire.champNull(prev.get(j).getNomnavire_prev()).equals("-") && !Utilitaire.champNull(prev.get(j).getValconsignataire_prev()).equals("-") && !Utilitaire.champNull(prev.get(j).getCargval_prev()).equals("-")) { %><%=prevision.getCouleur() %><% } %>;"><%=Utilitaire.formatterDaty(prev.get(j).getDate_depart_prev())%></td>
                                        </tr>
                                    <% }} else{%>
                                        <tr>
                                            <td><a href="<%=((String) session.getValue("lien"))+"?but=capitainerie/mouvement-liste.jsp&quaisdestination="+((Quais)autres.get(i).get("quais")).getId()%>"><%=Utilitaire.champNull(((Quais)autres.get(i).get("quais")).getVal()) %></a></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
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