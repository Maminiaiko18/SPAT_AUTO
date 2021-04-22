<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.formation.*" %>
<%
    try {

        FormFormation crt = new FormFormation();
        FormFormation[] listeplanning = (FormFormation[]) CGenUtil.rechercher(crt, null, null, "");

        //FormParticipantInfo
%>

<link href="${pageContext.request.contextPath}/assets/calendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/assets/calendar/bootstrapmodal.css" rel="stylesheet" type="text/css" />


<div class="content-wrapper">
    <div class="col-md-12">
        <div class="box box-primary">
            <div class="box-head">
                <h1 class="box-title">Calendrier Formation</h1>
            </div>

        </div>
    </div>

    <div class="col-md-12">
        <div id="calendar"></div>
        <div id="fullCalModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 id="modalTitle" class="modal-title"></h1>                        
                    </div>
                    <div id="modalBody" class="modal-body"></div>
                    <div id="modalInfo" class="modal-info"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/calendar/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/calendar/jquery.min.js"></script>        
    <script src="${pageContext.request.contextPath}/assets/calendar/fullcalendar.min.js"></script>       
    <script src="${pageContext.request.contextPath}/assets/calendar/fr.js"></script>       
    <script src="${pageContext.request.contextPath}/assets/calendar/bootstrapmodal.min.js"></script> 

    <script>
        $(document).ready(function () {
            var calendar = [
        <%
            int taille = listeplanning.length;
            for (int i = 0; i < taille; i++) {
                String heuredebut = listeplanning[i].getHeure_debut();
                String heurefin = listeplanning[i].getHeure_fin();

                String temp1 = (heuredebut != null && !heuredebut.isEmpty()) ? heuredebut : "00:00:00";
                String temp2 = (heurefin != null && !heurefin.isEmpty()) ? heurefin : "00:00:00";
                
                String intitule = listeplanning[i].getIntitule() == null ? "Formation sans intitulé" : Utilitaire.remplaceMot(listeplanning[i].getIntitule(), "'", " ");
                String col = "" ; 
                col = listeplanning[i].getEtat() == 1 ?  "blue" : col ;
                col = listeplanning[i].getEtat() == 11 ? "red" : col ;
                col = listeplanning[i].getEtat() == 12 ? "green" : col ;
        %>
                {
                    "title": "<%=intitule%>",
                    "description": "<%= FormService.makeDescriptionHtml(listeplanning[i])%>",
                    "start": "<%=listeplanning[i].getDate_debut().toString()%>T<%=temp1.toString().length() == 7? "0"+temp1 : temp1 %>",
                    "end": "<%=listeplanning[i].getDate_fin().toString()%>T<%=temp2.toString().length() == 7? "0"+temp2 : temp2 %>",
                    "backgroundColor":"<%=col %>"
                }
        <%
            boolean pasfin = i < taille - 1;
            if (pasfin) {
        %>
                ,
        <%
                }
            }
        %>
        ];
        
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay,listWeek'
                },
                defaultDate: '<%=Utilitaire.dateDuJourSql().toString()%>',
                navLinks: true,
                editable: true,
                eventLimit: true,
                events: calendar,
                eventClick:  function (event, jsEvent, view) {
                    $('#modalTitle').html(event.title);
                    $('#modalBody').html(event.description);
                    $('#eventUrl').attr('href', '#');
                    $('#fullCalModal').modal();
                    }
            });
                                                        });
    </script>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>