
<%@page import="bean.CGenUtil"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="user.UserEJB"%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2" style=" margin-top: 20px;">
            <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> Import Ligne cr&eacute;dit d&eacute;pense
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
                                                 
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''" style="">
                                        <td width="9%" align="left">DIRECTION</td>
                                        <td width="9%" align="left">PROJET</td>
                                        <td width="9%" align="left">DESIGNATION</td>
                                        <td width="9%" align="left">COMPTE</td>
                                        <td width="9%" align="right">ANNEE</td>
                                        <td width="9%" align="right">MONTANT</td>
                                    </tr>
                                </tbody>
                            </table>                                 
                </div>
                <form action="<%=(String) session.getValue("lien")%>?but=import/apresImport.jsp?acte=importLCDepense" method="post" enctype="multipart/form-data">
                    <div class="box-body">
                        <div class="row" style=" padding: 22px;">
                            <input type="file" name="file" tabindex="1" class="form-control" style="height: 35px;">
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