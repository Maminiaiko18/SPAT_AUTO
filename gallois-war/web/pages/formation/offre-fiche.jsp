<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.formation.*" %>
<%!
    FormOffreFormation offreformation;
    UserEJB u;
%>
<%
    try {

        u = (UserEJB) session.getAttribute("u");
        offreformation = new FormOffreFormation();
        //offreformation.setNomTable("FORM_OFFRE_FORMATION_LIBELLE");
        offreformation.setNomTable("FORM_OFFRE_FORMATION_LIBELLE3");
        String[] libelleOffreFormationFiche = {"Id", "Type", "Formateur", "Cat&eacute;gorie", "Service", "Date d&eacute;but", "Date fin", "Lieu", "Remarque", "Niveau Requis", "Type coût", "Co&ucirc;t de l'offre", "Etablissement", "Etat"};
        PageConsulte pc = new PageConsulte(offreformation, request, (user.UserEJB) session.getValue("u"));
        pc.setLibAffichage(libelleOffreFormationFiche);
        pc.getChampByName("iduser").setVisible(false);
        pc.setTitre("Offre de Formation");

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=formation/offre-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=formation/offre-fiche.jsp&classe=mg.cnaps.formation.FormOffreFormation" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/offre-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=formation/offre-liste.jsp&classe=mg.cnaps.formation.FormOffreFormation" style="margin-right: 10px">Supprimer</a>
                            <a class="btn btn-default pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/formation-saisie.jsp&idoffre=" + request.getParameter("id")%>" style="margin-right: 10px">Cr&eacute;er la formation</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
            out.println(pc.getBasPage());

        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>
