
<%@page import="user.UserEJB"%>
<%
    UserEJB u = (user.UserEJB) session.getValue("u");
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
                        <div class="">
                            <input type="file" name="file" class="form-control" style="height: 35px;">
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