<%-- 
    Document   : convocation
    Created on : 29 déc. 2015, 17:19:40
    Author     : user
--%>
<%@ page import="affichage.*" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="mg.cnaps.formation.*" %>
<%
	FormFormation formation = new FormFormation();
	formation.setNomTable("FORM_FORMATION_LIBELLE5");
	PageConsulte pc = new PageConsulte(formation, request, (user.UserEJB) session.getValue("u"));
	FormFormation temp = (FormFormation) pc.getBase();

%>
<div class="content-wrapper" style="min-height: 946px;">
    <section class="content-header">
        <h1><a href="<%=(String) session.getValue("lien")%>?but=paie/formation/formation-fiche.jsp&id=<%=request.getParameter("id")%>"><i class="fa fa-arrow-circle-left"></i></a>G&eacute;n&eacute;ration de Convocation des participants </h1>
    </section>
    <section class="content">
        <form action="${pageContext.request.contextPath}/EtatGRHServlet?action=convocation" method="post">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title"></h3>
                        </div>
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-hover">
                                <tbody>
                                <div class="row"> 
                                    <div class="col-md-6">
                                        <tr>
                                            <td><label>Veuiller donner un titre à la formation : </label></td>
                                            <td><input type="text" name="titre" value="<%=Utilitaire.champNull(temp.getIntitule())%>" class="form-control"></td>
                                        </tr>
                                    </div>
                                </div>
                                <div class="row"> 
                                    <div class="col-md-6">
                                        <tr>
                                            <td><label>Mat&eacute;riel requis: </label></td>
                                            <td><input type="text" name="materiel" name="materiel" class="form-control" value="Il vous est demandé de vous munir de :"></td>
                                        </tr>
                                    </div>
                                </div>
                                        <div class="row"> 
                                    <div class="col-md-6">
                                        <tr>
                                            <td><label>Autres</label></td>
                                            <td><input type="text" name="autre" name="autre" class="form-control"></td>
                                        </tr>
                                    </div>
                                </div>
                                <input type="hidden" value="<%=request.getParameter("id")%>" name="id">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            </br></br>
            <div class="row">
                <div class="col-md-6">

                </div>
                <div class="col-md-6" align="right">
                    <button class="btn btn-primary" type="submit" style="margin-bottom: 10px">Valider</button>
                </div>
            </div>
        </form>
    </section>
</div>