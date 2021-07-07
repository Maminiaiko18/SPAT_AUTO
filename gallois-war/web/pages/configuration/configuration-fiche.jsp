<%-- 
    Document   : configuration-fiche
    Created on : 7 juil. 2021, 15:13:52
    Author     : Andriamiary
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="affichage.PageConsulte" %>
<%@ page import="mg.cnaps.configuration.Configuration" %>
<%
    try {
    Configuration configuration = new Configuration();
    configuration.setNomTable("configuration");
    
    //String[] libelleTiersFiche = {"id", "desce", "daty","remarque", "valmin", "valmax","typeconfig","compte_credit"};
    PageConsulte pc = new PageConsulte(configuration, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    //pc.setLibAffichage(libelleTiersFiche);
    
    pc.setTitre("Fiche configuration");
    
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("valmin").setLibelle("Min");
    pc.getChampByName("valmax").setLibelle("Max");
    pc.getChampByName("desce").setLibelle("Description");
    pc.getChampByName("remarque").setLibelle("Remarque");
    pc.getChampByName("typeconfig").setVisible(false);
    pc.getChampByName("compte_credit").setVisible(false);
    
    Configuration base=(Configuration)pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche col-md-12">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=configuration/configuration-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                       
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=configuration/configuration-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + base.getId()%>&acte=valider&bute=configuration/configuration-fiche.jsp&id=<%=base.getId()%>&classe=mg.cnaps.configuration.Configuration" style="margin-right: 10px">Viser</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=configuration/configuration-liste.jsp&classe=mg.cnaps.configuration.Configuration"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>