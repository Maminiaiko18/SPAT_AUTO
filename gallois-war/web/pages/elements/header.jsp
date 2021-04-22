<%@page import="mg.cnaps.messagecommunication.MessageNonLu"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@page import="javax.ejb.ConcurrentAccessTimeoutException"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.messagecommunication.Message"%>
<%@page import="mg.cnaps.messagecommunication.MessageLibelle"%>
<%@page import="historique.MapUtilisateur"%>

<%@page import="user.UserEJB"%>
<%@ page import="utilitaire.Constante" %>
<%
    HttpSession sess = request.getSession();
    String lang = "fr";
    if (request.getParameter("lang") != null) {
        lang = request.getParameter("lang");

        sess.setAttribute("lang", lang);
    }
    if (sess.getAttribute("lang") != null) {
        lang = String.valueOf(sess.getAttribute("lang"));
    }
    ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));
%>  
<%
    String lien = (String) session.getValue("lien");
    try {
        UserEJB ue = (UserEJB) session.getValue("u");
        MapUtilisateur u = ue.getUser();
        String receiver = u.getTeluser();
        MapUtilisateur map = ue.getUser();
        String awhere = " and receiver='" + receiver + "' ";

        //int inbox = ue.getMessagesNonLu();
        //int inboxNotif = ue.getNotificationNonLus();
        //MessageNonLu[] utilisateurs = ue.getMessagesNonLus(awhere);
        MapUtilisateur[] u2 = (MapUtilisateur[]) (CGenUtil.rechercher(new MapUtilisateur(), null, null, ""));
%>
<script>
    function verifEditerTef(et, name){
    if (et < 11){
    alert('Impossible d\'editer Tef. ' + name + ' non vis� ');
    } else{
    document.tef.submit();
    }
    }
    function verifLivraisonBC(et){
    if (et < 11){
    alert('Impossible d effectuer la livraison du bon de commande');
    } else{
    document.tef.submit();
    }
    }
    function CocherToutCheckBox(ref, name) {
    var form = ref;
    while (form.parentNode && form.nodeName.toLowerCase() != 'form') {
    form = form.parentNode;
    }

    var elements = form.getElementsByTagName('input');
    for (var i = 0; i < elements.length; i++) {
        if (elements[i].type == 'checkbox' && elements[i].name == name) {
            elements[i].checked = ref.checked;
        }
    }
    }
    
</script>
<style type="text/css">
  
    .breadcrumb {
        padding-left: 20px;
    }
    
</style>
<header class="main-header" style="position: fixed; left: 0; right: 0;">
    <!-- Logo -->
            <a style="background-color:#ffffff; height:150px;" href="<%=lien%>?but=accueil/menuprincipal.jsp" class="logo">
                    <!-- mini logo for sidebar mini 50x50 pixels -->
                    <span class="logo-mini" style="color: <%=Constante.constanteCouleur%>;font-weight: 600;">SPAT</span>
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg"><img style="width: 220px;height: 148px;" src="${pageContext.request.contextPath}/assets/img/logo-spat-p.png"/></span>
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav style="background:#ffffff;  height: 10px;" class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" style="color:<%=Constante.constanteCouleur%>" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <!--
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" id="navbar-search-input" placeholder="Recherche menu">
                    </div>
                </form>
                -->
                <div class="navbar-form navbar-left">
                    <button class="btn btn-default">
                        <a href="<%=lien%>?but=accueil/menuprincipal.jsp" style="color:#444444"><i class="fa fa-home"></i>&nbsp; MENU PRINCIPAL </a></li>
                    </button>
                </div> 
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="notifications-menu">
                            <a href="<%=lien%>?but=notification/notification-liste.jsp" style="color:#444444">
                              <i class="fa fa-bell-o"></i>
                              <span class="label label-warning"></span>
                            </a>
                        </li>
                        
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="hidden-xs" style="color:<%=Constante.constanteCouleur%>"><%=map.getLoginuser()%></span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li style="background:<%=Constante.constanteCouleur%>;" class="user-header">
                                    <img src="${pageContext.request.contextPath}/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image" />
                                    <p>
                                        <%=map.getNomuser()%>
                                    </p>
                                </li>
                                <!-- Menu Body -->
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="<%=lien%>?but=utilisateur/profil-modif.jsp&refuser=<%=map.getRefuser()%>" class="btn btn-default btn-flat">Modifier Profil</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="deconnexion.jsp" class="btn btn-default btn-flat">D�connexion</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
            
</header>
                    
            <div class="modal fade" id="modalSendMessage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="message-chat-title"></h4>
                        </div>
                        <div class="modal-body clearfix">
                            <div class="message-chat-content clearfix" id="message-chat-content">

                            </div>
                            <br/>
                            <form>
                                <textarea id="messagefrom" onkeypress="keypressedsendMessage(this, 1)" class="form-control" rows="3" placeholder="Votre message ici" ></textarea>
                                <br/><br/>
                                <input type="button" class="btn btn-primary pull-right" style="margin-left: 5px;" onclick="keypressedsendMessage(this, 2)" value="Envoyer"/>
                                <input type="reset" class="btn btn-danger pull-right" value="Annuler"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalSendMessageTo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="min-height: 200px">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <ul  > <%
                                for (MapUtilisateur utilisateur : u2) {%>
                            <li class="fa fa-envelope-o "> 
                                    <a href="module.jsp?but=notification/message-envoi.jsp&to=<%=utilisateur.getTeluser()%>"> <%=utilisateur.getNomuser()%></a> 
                          
                            </li><br/>
                            <%}
                            %>
                            </ul>
                        </div>
                        
                    </div>
                </div>
            </div>

            <%
                } catch (ConcurrentAccessTimeoutException e) {
                    out.println("<script language='JavaScript'> document.location.replace('/cnaps-war/');</script>");
                }
            %>
