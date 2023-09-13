<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@ page import="mg.spat.MereCA" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    MereCA mereCA = new MereCA();
    mereCA.setNomTable("MERECALIB_CPL");
    PageConsulte pc = new PageConsulte(mereCA, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID( );
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("val").setLibelle("Compte");
    pc.getChampByName("desce").setLibelle("Libell&eacute;");
    pc.getChampByName("idgrandrubriquelib").setLibelle("Grande rubrique");
    pc.getChampByName("idgrandrubrique").setVisible(false);
    pc.getChampByName("idgrandrubriquelib").setLien((String) session.getValue("lien") + "?but=configuration/idvaldesce.jsp&ciblename=grandrubrique","");
    pc.setTitre("Fiche de Mere CA");
    String lien = (String) session.getValue("lien");
    String pageModif = "ca/mereca-modif.jsp";
    String classe = "mg.spat.MereCA";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien + "?but=ca/mereca-liste.jsp"%>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
} %>


