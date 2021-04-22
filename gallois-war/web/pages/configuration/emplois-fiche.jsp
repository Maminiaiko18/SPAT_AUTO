 
<%@page import="affichage.PageConsulte"%>
<%@page import="mg.cnaps.sig.SigEmplois"%>
<%!
    SigEmplois emp;
%>
<%
    emp = new SigEmplois();
    emp.setNomTable("SIG_EMPLOIS_LIBELLE");

    String[] libelleEmplois = {"id", "Matricule travailleur", "Matricule Employeur", "Date d'embauche", "Date debauche", "Date d&eacute;but chomage", "Date fin chomage", "BAF", "Auto", "Fonction emploi","ID travailleur"};
    PageConsulte pc = new PageConsulte(emp, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setLibAffichage(libelleEmplois);
//pc.getFormu().getChamp("dateNaissance").setLibelle("Date de naissance");
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">Fiche  Emplois</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                    </div>
                    <div class="box-footer">
                        <p>
                            <a href="<%=(String) session.getValue("lien") + "?but=employeurs/emplois-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=emplois/emplois-liste.jsp&classe=mg.cnaps.sig.SigEmplois"><button class="btn btn-danger">Supprimer</button></a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
