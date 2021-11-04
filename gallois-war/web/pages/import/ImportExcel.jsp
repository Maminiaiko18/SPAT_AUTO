
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
                        <div class="box-footer" style="text-align: center;">
                            <button class="btn btn-primary" type="submit">importer</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>