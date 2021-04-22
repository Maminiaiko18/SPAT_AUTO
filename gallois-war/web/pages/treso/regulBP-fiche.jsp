<%@page import="bon.RegulBP"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    RegulBP e = new RegulBP();
    e.setNomTable("regulbp_libcomplet");
    String[] libelleFiche = {"Id", "idbon", "Montant", "Date", "Etat"};
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.getChampByName("iduser").setVisible(false);
    
    pc.getChampByName("iduserlib").setLibelle("User");
    pc.setTitre("FICHE Régul BP");
    pc.setLibAffichage(libelleFiche);
    pc.getChampByName("idbon").setLien("?but=treso/bon-provisoire-fiche.jsp", "id=");
    pc.getChampByName("idbon").setLibelle("Bon");
    e = (RegulBP) pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1 class="box-title">
                        <%=pc.getTitre()%> 
                    </h1>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                    </div>
                </div>
            </div>
            <div class="box-footer">                        
                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" +e.getId()%>&acte=valider&nomtable=regulbp&bute=treso/regulBP-fiche.jsp&classe=bon.RegulBP" style="margin-right: 10px">Valider</a>                        
            </div>
        </div>
    </div>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

