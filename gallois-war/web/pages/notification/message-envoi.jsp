<%-- 
    Document   : message-envoi
    Created on : 20 juin 2017, 16:08:19
    Author     : Doudou Tiarilala
--%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="mg.cnaps.messagecommunication.MessageLibelle"%>
<%@page import="bean.CGenUtil"%>
<%@page import="user.UserEJB"%>
<%
    UserEJB ue = (UserEJB) session.getValue("u");
    MapUtilisateur u = ue.getUser();
    String sender = u.getTeluser();
    String receiver = request.getParameter("to");
    String awhere = " and (sender='" + sender + "' and receiver='" + receiver + "') or (sender='" + receiver + "' and receiver='" + sender + "'  ) order by id asc";
    ue.lireMessage(receiver,sender);
    MessageLibelle a = new MessageLibelle();
    MessageLibelle[] mes = (MessageLibelle[]) (CGenUtil.rechercher(a, null, null, awhere));
   

%>
<%@page import="utilitaire.Utilitaire"%>
<div class="content-wrapper"  >
    <h1 align="center">Message</h1>
    <form action="module.jsp?but=apresTarif.jsp" method="post" name="notification" id="notification" data-parsley-validate="" novalidate="">
        <div class="row pull-center" align="center">
            <div class="col-md-12 pull-center">
                <div class="box">
                    <div class="box box-primary" style="height: 500px;overflow-y: scroll;overflow-style: scrollbar">
                        <div class="box-body">
                                     <div   style="max-height: 500px;overflow-y: scroll;overflow-style: scrollbar">
                            <table class="table table-responsive">
                                <tbody>
                       
                                    <% for (int i = 0; i < mes.length; i++) {%>
                                    <tr>
                                        <td colspan="2">
                                            <div style="padding: 5px;">
                                                <% if (mes[i].getSender().compareToIgnoreCase(sender) != 0) {%>
                                                <div class="col-md-10 pull-left bg-gray" style="text-align: left;border-radius: 20px">
                                                    <span><%=mes[i].getSendername()%>:</span>
                                                    <p>  <i><%=mes[i].getMsg()%></i></p>
                                                </div>
                                                <%} else {%>

                                                <div class="col-md-10 pull-right bg-primary"   style="text-align: right;border-radius: 20px">
                                                    <span>Moi:</span>
                                                    <p><i><%=mes[i].getMsg()%></i></p>
                                                </div>
                                                <%}%>
                                            </div>
                                        </td>
                                    </tr>

                                    <%}%>
                              

                                <tr>

                                    <td>
                                        <input name="dateheure" type="hidden" class="form-control" id="daty" value="<%= Utilitaire.dateDuJour()%>"  /> 
                                        <input name="sender" type="hidden" class="form-control" id="daty" value="<%= u.getTeluser()%>"  /> 
                                        <input name="sender" type="hidden" class="form-control" id="daty" value="<%= u.getTeluser()%>"  /> 
                                        <input name="statut" type="hidden" class="form-control"   value="nonlu"  /> 
                                        <input name="receiver" type="hidden" class="form-control" id="daty" value="<%= receiver%>"  /> 
                                        <input name="receiver" type="hidden" class="form-control" id="daty" value="<%= receiver%>"  /> 
                                        <input name="classe" type="hidden" class="form-control" id="daty" value="mg.cnaps.messagecommunication.Message"  /> 
                                        <input name="bute" type="hidden"  value="notification/message-envoi.jsp&to=<%= receiver%>"  /> 
                                        <input name="idcoversation" type="hidden" class="form-control" id="daty" value="<%= Utilitaire.formatterDaty(Utilitaire.dateDuJourSql())%>" datepicker/></td>

                                </tr>


                                <tr>

                                    <td colspan="2">
                                        <textarea style="border-radius: 30px"  name="msg" type="textbox" class="form-control" id="message" placeholder="Votre message ici...." ></textarea>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                                          </div>
                        </div>
                        <div class="box-footer">
                            <div class="col-xs-12">
                                <button type="submit" name="Submit2" class="btn btn-success pull-right" style="margin-right: 25px;" tabindex="91"><span class="fa fa-suitcase">Envoyer</span></button> 
                                <button type="reset" name="Submit2" class="btn btn-default pull-right" style="margin-right: 15px;" tabindex="92"><span class="fa fa-dropbox">Annuler</span> </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="etat" type="hidden" id="etat" value="1">
        <input name="iduser" type="hidden" id="iduser" value=" ">
        <input name="bute" type="hidden" id="bute" value="notification/notification-liste.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.notification.NotificationMessage">
    </form>
</div>
