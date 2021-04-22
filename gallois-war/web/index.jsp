<%@page import="java.util.Locale"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="bean.CGenUtil"%>
<%/*@page import="mg.cnaps.log.LogService"*/%>
<%@page import="utilitaire.Utilitaire"%>

<%@ page import="java.io.*" %>
<% 
  String lang = "fr"; 
  if(request.getParameter("lang")!=null){
      lang = request.getParameter("lang");
      HttpSession sess = request.getSession();
      sess.setAttribute("lang", lang);
  }
  ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));
%>    

<%!
    String but = "";
    String queryString = "";
    //LogService[] lls;
%>
<%
    try{
        queryString = request.getQueryString();
        but = "pages/testLogin.jsp";
        if(queryString != null && !queryString.equals("")){
            but += "?" + queryString;
        }
        //LogService ls = new LogService();
        //lls = (LogService[])CGenUtil.rechercher(ls, null, null, " order by libelle asc");
    }
    catch(Exception ex){ %>
        <script language="JavaScript">
        alert(<%=ex.getMessage()%>);
        document.location.replace("../index.jsp");
        </script>
   <% }
%>
<!DOCTYPE html>
  <html lang="<%=lang%>">
    <head>
      <meta charset="UTF-8">
      <title>Identification</title>
      <!-- Tell the browser to be responsive to screen width -->
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
      <!-- Bootstrap 3.3.4 -->
      <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
      <!-- Font Awesome Icons -->
      <link href="${pageContext.request.contextPath}/dist/js/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
      <!-- Theme style -->
      <link href="${pageContext.request.contextPath}/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
      <link href="${pageContext.request.contextPath}/dist/css/stylecustom.css" rel="stylesheet" type="text/css" />
      <!-- iCheck -->
      <link href="${pageContext.request.contextPath}/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />

      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
    </head>
    <body class="login-page">
      <div class="login-box loginBody">
        <div class="login-logo">
          <a href="index.jsp"><br/><b>S P A T</a>
        </div><!-- /.login-logo -->
        <div class="login-box-body">
            <p class="login-box-msg"><%= RB.getString("label.identification") %></p>
          <form action="<%=but%>" method="post">
            <div class="input-group">
              <span class="input-group-addon"><i class="fa fa-user"></i></span>
              <input type="text" name="identifiant" class="form-control" placeholder="Utilisateur" autofocus="autofocus"/>
            </div><br/>
            <div class="input-group">
              <span class="input-group-addon"><i class="fa fa-lock"></i></span>
              <input type="password" name="passe" class="form-control" placeholder="Mot de passe" />
            </div><br/>
            <!--<div class="row">
                <div class="col-xs-3"> 
                    <label>Interim</label>
                    <input type="checkbox" name="interim" value="1"/>
                </div>
                <div class="col-xs-9">
                    <label for="Service">Service</label>
                    <select name="service" class="form-control">
                        <option value="-"></option>
                        <%/*for(int i=0; i<lls.length ; i++){*/%>
                        <option value="<%/*=lls[i].getId()*/%>"><%/*=lls[i].getLibelle() */%></option>
                        <%/*}*/%>
                    </select>
                </div>
            </div>-->
            <br/>
            <div class="row">
              <div class="col-xs-7">
                  <p><b>Version du : <%@include file="dateBuild.txt" %></b></p>
              </div><!-- /.cosl -->
              <div class="col-xs-5">
                <button type="submit" class="btn btn-primary btn-block btn-flat"><%= RB.getString("connection") %></button>
              </div><!-- /.col -->
            </div>
          </form>
        </div><!-- /.login-box-body -->
      </div><!-- /.login-box -->

      <!-- jQuery 2.1.4 -->
      <script src="${pageContext.request.contextPath}/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
      <!-- Bootstrap 3.3.2 JS -->
      <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
      <!-- iCheck -->
      <script src="${pageContext.request.contextPath}/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
      <script>
        $(function () {
          $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
          });
        });
      </script>
    </body>
  </html>