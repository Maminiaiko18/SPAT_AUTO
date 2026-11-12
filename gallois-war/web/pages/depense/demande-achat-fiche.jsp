<%@page import="mg.spat.DemandeAchatMere"%>
<%@page import="utilitaire.Constante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private String escapeN8nDaseHtml(Object value) {
        if (value == null) {
            return "";
        }
        return String.valueOf(value).replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    DemandeAchatMere e = new DemandeAchatMere();
    e.setNomTable("dem_achat_merelib");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE DASE");
    e = (DemandeAchatMere) pc.getBase();
    String id= e.getId();
    String idengagement=e.getIdengagement();
    String lien = (String) session.getValue("lien");
       
    pc.getChampByName("idengagementlib").setVisible(false);
    pc.getChampByName("codeetablissementlib").setLibelle("Code &eacute;tablissement");
    pc.getChampByName("projetlib").setLibelle("Projet");
    pc.getChampByName("num").setLibelle("Num&eacute;ro");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("idengagement").setVisible(false);
    pc.getChampByName("codeetablissement").setVisible(false);
    pc.getChampByName("projet").setVisible(false);
    pc.getChampByName("idengagementlib").setLien(lien + "?but=depense/engagement-fiche.jsp","id="+idengagement+"&id=");
    pc.getChampByName("etatlib").setVisible(false);
    pc.getChampByName("idcategorieachatlib").setLibelle("Cat&eacute;gorie achat");
    pc.getChampByName("idcategorieachat").setVisible(false);
    pc.getChampByName("patrimoine").setVisible(false);
    pc.getChampByName("montantengager").setLibelle("Montant engag&eacute;");

    pc.getChampByName("patrimoinelib").setLibelle("Patrimoine");
    
    Map<String, String> map = new HashMap();
    map.put("details-demande-achat","");
    map.put("liste-bc_1", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "details-demande-achat";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";

%>

<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-8 col-md-offset-2">
         <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> <%=pc.getTitre()%> 
                </h1>
                <div class="box-body">
                    <%
                        Object validationFlash = session.getAttribute("n8nDaseValidation:" + id);
                        if (validationFlash instanceof Map) {
                            session.removeAttribute("n8nDaseValidation:" + id);
                            Map<String, Object> validationResult = (Map<String, Object>) validationFlash;
                            Object validationStatusValue = validationResult.get("statut");
                            String validationStatus = validationStatusValue == null ? "INDISPONIBLE" : String.valueOf(validationStatusValue);
                            boolean validationOk = "VALIDE".equalsIgnoreCase(validationStatus);
                            Object validationErrors = validationResult.get("errors");
                    %>
                        <div class="alert <%= validationOk ? "alert-success" : "alert-warning" %>" role="alert">
                            <strong>Contrôle automatique n8n — <%= escapeN8nDaseHtml(validationStatus) %></strong>
                            <p>La DASE est enregistrée. Résultat du contrôle :</p>
                    <%
                            if (validationErrors instanceof java.util.List) {
                                for (Object validationError : (java.util.List) validationErrors) {
                    %>
                            <p><%= escapeN8nDaseHtml(validationError) %></p>
                    <%
                                }
                            } else if (validationErrors != null) {
                    %>
                            <p><%= escapeN8nDaseHtml(validationErrors) %></p>
                    <%
                            }
                    %>
                        </div>
                    <%
                        }
                        out.println(pc.getHtml());
                    %>
                </div>
                <div class="box-footer">
                    <p>
                        <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annuler&id=" + e.getId()%>&bute=depense/demande-achat-fiche.jsp&classe=mg.spat.DemandeAchatMere"><button class="btn btn-danger" style=" margin-right: 5px" >Annuler</button></a>
                        <%if(e.getEtat() == ConstanteEtat.getEtatValider()){%>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&id=" + e.getId()%>&bute=depense/demande-achat-fiche.jsp&classe=mg.spat.DemandeAchatMere"><button class="btn btn-info" style="margin-right: 5px" >Annuler visa</button></a>
                            <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but=stock/bc/bondecommande-multiple.jsp&idDa=" + id %>" style="margin-right: 10px">Saisir BC</a>    
                        <% } else { %>
                             <a class="btn btn-success"   href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=mg.spat.DemandeAchatMere&bute=depense/demande-achat-fiche.jsp&id=" + id%>" style="margin-right: 5px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=depense/demande-achat-modif.jsp&id=" + id %>" style="margin-right:10px">Modifier</a>
                        <% } %>
                        <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerDemandeAchat&id=<%=id%>" style="margin-right: 10px">Imprimer DASE</a>
                    </p>
                    <hr>
                </div>
            </div>
        </div>
    </div>
     <div class="row">
        <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("details-demande-achat")%>"><a href="module.jsp?but=depense/demande-achat-fiche.jsp&id=<%=e.getId()%>&tab=details-demande-achat">Détails DASE</a></li>
                     <li class="<%= map.get("liste-bc_1")%>"><a href="module.jsp?but=depense/demande-achat-fiche.jsp&id=<%=e.getId()%>&tab=liste-bc_1">Liste bon de commande</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-content">       
                        <jsp:include page="<%=tab%>">
                            <jsp:param name='idengagement' value="<%=e.getId()%>"/> 
                        </jsp:include>
                    </div>
                </div>
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

