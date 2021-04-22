<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.cnaps.formation.FormAbsence"%>

<%
    UserEJB u;
    FormAbsence a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new FormAbsence();
	//a.setNomTable("FORM_DEMANDE_LIBELLE");

    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
     
    
    String idform=request.getParameter("idformation");
    String idpers=request.getParameter("idpers");
    if(idform!=null && idform.compareToIgnoreCase("")!=0){
        pi.getFormu().getChamp("id_formation").setDefaut(idform);
        pi.getFormu().getChamp("log_personnel").setDefaut(idpers);
    }
    pi.getFormu().getChamp("id_formation").setLibelle("Formation");
    pi.getFormu().getChamp("log_personnel").setLibelle("Personnel");
    pi.getFormu().getChamp("date_absence").setLibelle("Date d'absence");
    pi.getFormu().getChamp("date_absence").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pi.getFormu().getChamp("motif").setLibelle("Motif");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    
    pi.getFormu().getChamp("id_formation").setPageAppel("choix/formFormationChoix.jsp");
    pi.getFormu().getChamp("log_personnel").setAutre("readonly");
   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'une demande</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formabsence">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="formation/absence-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormAbsence">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="form_absence">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>