<%-- 
    Document   : bon-provisoire-modif
    Created on : 30 nov. 2019, 13:38:48
    Author     : rajao
--%>
<%@page import="mg.spat.Report"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%@ page import="mg.spat.Caisse"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Report bonprovisoire=new Report();
    PageUpdate pi = new PageUpdate(bonprovisoire, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste = new affichage.Champ[2];
    
    TypeObjet esc = new TypeObjet();
    esc.setNomTable("CAISSE");
    liste[0] = new Liste("caisse", esc, "VAL", "id");
    
    TypeObjet dev = new TypeObjet();
    dev.setNomTable("devisedemat");
    liste[1] = new Liste("devise", dev, "VAL", "ID");
    
    pi.getFormu().changerEnChamp(liste);
    
    
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
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
                        <input name="bute" type="hidden" id="bute" value="treso/report-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Report">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="report">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>