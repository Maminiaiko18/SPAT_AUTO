<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.formation.*" %>
<%!
    FormEtablissement etablissement;
    UserEJB u;
%>
<%
    u = (UserEJB) session.getAttribute("u");
    etablissement = new FormEtablissement();
    etablissement.setNomTable("FORM_ETABLISSEMENT_LIBELLE");
    String[] libelleEtablissementFiche = {"Id", "Nom", "Sp&eacute;cialisation", "Date de Création", "Adresse", "Pays", "Valeur", "Contact"};
    PageConsulte pc = new PageConsulte(etablissement, request, (user.UserEJB) session.getValue("u"));
    pc.setLibAffichage(libelleEtablissementFiche);
    pc.setTitre("Fiche ETABLISSEMENT");
    UnionIntraTable etablidom = new UnionIntraTable();
    etablidom.setNomTable("FORM_ETABLISSEMENT_DOMAINE");
    String etablissementId = "AND ID1 = '" + request.getParameter("id") + "'";
    UnionIntraTable[] etablidoms = (UnionIntraTable[]) u.getData(etablidom, null, null, null, etablissementId);
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=configuration/etablissement-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                    <div class="box-footer">
                        <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=configuration/etablissement-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=configuration/etablissement-liste.jsp&classe=mg.cnaps.formation.FormEtablissement" style="margin-right: 10px">Supprimer</a>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%out.println(pc.getBasPage());%>
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">Liste des domaines de l'&Eacute;tablissement</h1>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Code</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                for(int i=0;i<etablidoms.length;i++){
                                    TypeObjet domaine = new TypeObjet();
                                    domaine.setNomTable("PAIE_DOMAINE");
                                    String domaineId = "AND ID = '" + etablidoms[i].getId2() + "'";
                                    TypeObjet[] domaines = (TypeObjet[]) u.getData(domaine, null, null, null, domaineId);
                                %>
                                <tr>
                                    <td><%=domaines[0].getId()%></td>
                                    <td><%=domaines[0].getVal()%></td>
                                    <td><%=domaines[0].getDesce()%></td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
