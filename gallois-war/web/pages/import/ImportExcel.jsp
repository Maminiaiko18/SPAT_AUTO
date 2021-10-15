
<%@page import="user.UserEJB"%>
<%
    UserEJB u = (user.UserEJB) session.getValue("u");
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-7 col-md-offset-2">

            <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> Export Données 
                </h1>
                <form action="<%=(String) session.getValue("lien")%>?but=import/apresImport.jsp?acte=import" method="post" enctype="multipart/form-data">
                    <div class="box-body">
                        <input type="file" name="file">

                        <div class="box-footer">

                            <hr>
                            <button type="submit">importer</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>