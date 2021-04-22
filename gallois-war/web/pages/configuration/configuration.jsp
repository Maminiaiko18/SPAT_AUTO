<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.configuration.*" %>
<%
    String typeconfig = "", titre = "";
    if(request.getParameter("typeconfig") != null)
        typeconfig = request.getParameter("typeconfig");
    if(request.getParameter("titre") != null)
        titre = request.getParameter("titre");
    else
        titre = request.getParameter("typeconfig");
    Configuration conf = new Configuration();
    conf.setTypeconfig(typeconfig);
    String libEntete[] = {"id", "valmin", "valmax", "desce", "remarque", "daty", "typeconfig"};
    String listeCrt[] = {"id", "valmin", "valmax", "desce", "remarque", "daty", "typeconfig"};
    String listeInt[] = null;
    PageRecherche pr = new PageRecherche(conf, request, listeCrt, listeInt, 3, libEntete, 7);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres(request.getParameter("but"));
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

%>
<div class="content-wrapper">
    <section class="content-header">
        <h2>Configuration <%= titre %></h2>
    </section>
    <section class="content">
        <form method="post" action="${pageContext.request.contextPath}/ConfigurationSaisie">
            <div class="box box-primary">
                <div class="box-header">
                    <h3>Ajout<h3>
                </div>  
                <div class="box-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Description</th>
                            <th>Valeur minimale</th>
                            <th>Valeur maximale</th>
                            <th>Remarque</th>
                        </tr>
                        <tr>
                            <td><input type="text" name="desce" /></td>
                            <td><input type="text" name="valmin" /></td>
                            <td><input type="text" name="valmax" /></td>
                            <td><input type="text" name="remarque" /></td>
                            <input type="hidden" name="typeconfig" value="<%= typeconfig %>" />
                            <input type="hidden" name="titre" value="<%= titre %>" />
                        </tr>
                    </table>
                </div>
                <div class="box-footer">
                    <input class="btn btn-primary" type="submit" value="Ajouter" />
                </div>
            </div>
        </form>
        <% if(pr.getTableau().getData().length != 0) { %>                
            <form method="post" action="${pageContext.request.contextPath}/ConfigurationModif">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3>Modification<h3>
                    </div>  
                    <div class="box-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>Description</th>
                                <th>Valeur minimale</th>
                                <th>Valeur maximale</th>
                                <th>Remarque</th>
                                <th>Dernière modification</th>
                            </tr>
                            <% for(Configuration element : (Configuration[]) pr.getTableau().getData()) { %>
                            <tr>
                            <input type="hidden" value="<%= pr.getTableau().getData().length %>" />
                                <td><input type="text" name="desce" value="<%= element.getDesce() %>"></td>
                                <td><input type="text" name="valmin" value="<%= element.getValmin() %>"></td>
                                <td><input type="text" name="valmax" value="<%= element.getValmax() %>"></td>
                                <td><input type="text" name="remarque" value="<%= element.getRemarque() %>"></td>
                                <td>
                                    <input type="text" name="daty" value="<%= Utilitaire.datetostring(element.getDaty()) %>" disabled />
                                    <input type="hidden" name="daty" value="<%= element.getDaty() %>" />
                                </td>
                                <input type="hidden" name="typeconfig" value="<%= typeconfig %>" >
                                <input type="hidden" name="titre" value="<%= titre %>" >
                                <input type="hidden" name="id" value="<%= element.getId() %>" >
                            </tr>
                            <% } %>
                        </table>
                    </div>
                    <div class="box-footer">
                        <input class="btn btn-primary" type="submit" value="Modifier" />
                    </div>
                </div>
            </form>  
        <% } %>
    </section>
</div>
