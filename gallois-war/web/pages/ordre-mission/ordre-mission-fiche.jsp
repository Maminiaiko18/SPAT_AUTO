<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@ page import="ordremission.OrdreMissionLib" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    try{
    OrdreMissionLib t = new OrdreMissionLib();
    t.setNomTable("ordre_mission_lib");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    
    t = (OrdreMissionLib) pc.getBase();
    String id = t.getId();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("numom").setLibelle("Num OM");
    pc.getChampByName("nom").setLibelle("Nom");
    pc.getChampByName("prenom").setLibelle("Prenom");
    pc.getChampByName("fonction").setLibelle("Fonction");
    pc.getChampByName("matricule").setLibelle("Matricule");
    pc.getChampByName("lieudeplacement").setLibelle("Lieu de Placement");
    pc.getChampByName("datedepart").setLibelle("Date départ");
    pc.getChampByName("duree").setLibelle("Durée");
    pc.getChampByName("idmotifvoyagelib").setLibelle("Motif voyage");
    pc.getChampByName("estForfaitairelib").setLibelle("Est Forfaitaire");
    pc.getChampByName("idindemnitemissionlib").setLibelle("Indemnité de Mission");
    pc.getChampByName("duree").setLibelle("Durée");
    pc.getChampByName("idmotifvoyage").setVisible(false);
    pc.getChampByName("idindemnitemission").setVisible(false);
    pc.getChampByName("estForfaitaire").setVisible(false);
    pc.getChampByName("idtiers").setVisible(false);
    pc.setTitre("Fiche Ordre de Mission");
    String lien = (String) session.getValue("lien");
    String pageModif = "ordre-mission/ordre-mission-modif.jsp";
    String classe = "ordremission.OrdreMission";
    Map<String, String> map = new HashMap<String, String>();
    String bute="ordre-mission/ordre-mission-fiche.jsp"; 
       map.put("bon-provisoire", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "bon-provisoire";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <dOiv class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien %>?but=ordre-mission/ordre-mission-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id")%>&bute=ordre-mission/ordre-mission-fiche.jsp&classe=<%=classe %>" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-danger"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&id=" + request.getParameter("id")%>&bute=ordre-mission/ordre-mission-fiche.jsp&classe=<%=classe %>" style="margin-right: 10px">Annuler Visa</a>
                            <hr>
                            <a class="btn btn-default"  href="<%= lien + "?but=facture/facture-fournisseur-saisie-vaovao.jsp&mode=1&idom=" + id%>" style="margin-right: 10px">Générer Bon Provisoire</a>

                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-10 col-md-offset-1 ">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs nav-center">
                        <li class="<%= map.get("bon-provisoire")%>"><a href="module.jsp?but=<%=bute%>&id=<%=id%>&tab=bon-provisoire">Bon Provisoire</a></li>
                    </ul>
                    <div class="tab-content">       

                        <div class="tab-content">       
                            <jsp:include page="<%=tab%>" >
                                <jsp:param name="idom" value="<%=id%>" />
                            </jsp:include>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
}
%>


