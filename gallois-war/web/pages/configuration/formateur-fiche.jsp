<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.formation.*" %>
<%!
     FormFormateur formateur;
%>
<%
    formateur = new FormFormateur();
    formateur.setNomTable("FORM_FORMATEUR_LIBELLE_2");
    String[] libelleFormateurFiche = {"Id", "Nom", "Niveau", "Exp&eacute;rience", "Description", "Remarque", "Etablissement"};
    PageConsulte pc = new PageConsulte(formateur, request, (user.UserEJB) session.getValue("u"));
    pc.setLibAffichage(libelleFormateurFiche);
    pc.setCanUploadFile(true);
    pc.setFichier_table_cible("FORM_FORMATEUR_PJ");
    pc.setFichier_table_procedure("getseqformformateurpj"); 
    pc.setTitre("Fiche FORMATEUR");
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=configuration/formateur-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                    <div class="box-footer">
                        <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=configuration/formateur-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=configuration/formateur-liste.jsp&classe=mg.cnaps.formation.FormFormateur" style="margin-right: 10px">Supprimer</a>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%out.println(pc.getBasPage());%>
</div>
