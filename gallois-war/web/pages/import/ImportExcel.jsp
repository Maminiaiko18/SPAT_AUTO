
<%@page import="bean.CGenUtil"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="user.UserEJB"%>
<%
    UserEJB u = (user.UserEJB) session.getValue("u");
    affichage.Liste listed = new affichage.Liste();
    TypeObjet o = new TypeObjet();
    o.setNomTable("mois");
    TypeObjet[] mois=(TypeObjet[]) CGenUtil.rechercher(o, "select * from mois");
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2" style=" margin-top: 20px;">
            <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> Import Trafic TC
                </h1>
                <div class="box-body table-responsive no-padding">
                            <table class="table table-striped table-hover table-bordered" width="100%" cellspacing="3" cellpadding="3" border="0" align="center">
                                <thead>
                                    <tr class="head">
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">A</th>
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">B</th>
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">C</th>
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">D</th>
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">E</th>
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">F</th>
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">G</th>
                                        <th style="background-color:#bed1dd" width="9%" valign="top" align="center">H</th>
                                                 
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''" style="">
                                        <td width="9%" align="left">POSTE QUAI</td>
                                        <td width="9%" align="left">NOM DU NAVIRE</td>
                                        <td width="9%" align="left">N° VOYAGE</td>
                                        <td width="9%" align="right">DATE D' ARRIVEE</td>
                                        <td width="9%" align="left">DISCHARGING</td>
                                        <td width="9%" align="left">LOADING</td>
                                        <td width="9%" align="left">IMP/EXP</td>
                                        <td width="9%" align="right">DISCHARGING TRANSHIP</td>
                                    </tr>
                                </tbody>
                            </table>                                 
                </div>
                <form action="<%=(String) session.getValue("lien")%>?but=import/apresImport.jsp?acte=import" method="post" enctype="multipart/form-data">
                    <div class="box-body">
                        <div class="row" style=" padding: 22px;">
                            <input type="file" name="file" tabindex="1" class="form-control" style="height: 35px;">
                        </div>
                        <div class="row" style=" padding-left: 50px;">
                            <div class="col-md-3"><label for="escale" onchange="modifierPage()">Choix escale :</label></div>
                            <div class="col-md-8"><input name="escalelibelle" type="textbox" class="form-control" id="escalelibelle" value="" tabindex="2" onchange="modifierPage()" readonly><input type="hidden" value="" name="escale" id="escale"></div>
                            <div class="col-md-1"><input name="choix" type="button" class="submit" onclick="pagePopUp('choix/listePrevisionChoix.jsp?champReturn=escale;escalelibelle&amp;apresLienPageAppel=')" value="..."></div>
                        </div>
                        <div class="row" style=" margin-top: 15px;padding-left: 50px;">
                            <div class="col-md-3"><label for="escale" onchange="modifierPage()">mois  :</label></div>
                            <div class="col-md-8">
                                <select name="mois" class="form-control" id="mois" data-parsley-id="12" tabindex="3">
                                <% for(int imois=0 ; imois<mois.length ; imois++) { %>
                                    <option value="<%= mois[imois].getId()%>"><%= mois[imois].getDesce() %></option>
                                <% } %>
                                </select>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        <div class="row" style=" margin-top: 15px;padding-left: 50px;">
                            <div class="col-md-3"><label for="escale" onchange="modifierPage()">Annee  :</label></div>
                            <div class="col-md-8">
                                <input type="text" name="annee" class="form-control">
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        <div class="box-footer" style="text-align: center;">
                            <button class="btn btn-primary" type="submit">importer</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>