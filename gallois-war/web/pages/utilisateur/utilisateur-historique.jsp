<%@page import="historique.MapHistorique"%>
<%@page import="affichage.PageRecherche"%>
<%

    MapHistorique d = new MapHistorique();
    d.setNomTable("historique_libelle");
    String listeCrt[] = {"idhistorique", "datehistorique", "heure", "objet", "action", "idutilisateur", "refobjet"};
    String listeInt[] = {"datehistorique"};
    String libEntete[] = {"idhistorique", "datehistorique", "heure", "objet", "action", "idutilisateur", "refobjet"};
    PageRecherche pr = new PageRecherche(d, request, listeCrt, listeInt, 3, libEntete, 7);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("datehistorique1").setLibelle("date historique min");
    pr.getFormu().getChamp("datehistorique2").setLibelle("date historique max");
    pr.getFormu().getChamp("idutilisateur").setLibelle("Utilisateur");
    pr.setLien((String) session.getValue("lien"));
    pr.setOrdre(" ORDER BY idhistorique DESC ");
    pr.setApres("utilisateur/utilisateur-historique.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

    MapHistorique[] liste = (MapHistorique[]) pr.getTableau().getData();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Historique utilisateur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/utilisateur-historique.jsp" method="post" name="listeUtilisateur" id="listeUtilisateur">
            <%
                pr.getFormu().getChamp("idhistorique").setLibelle("Identifiant");
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>

        <div class="row">
            <div class="row col-md-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title" align="center">LISTE</h3>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover">
                                <thead>
                                    <tr class="head">
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Identifiant
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Date
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Heure
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Objet
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Action
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Utilisateur
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Reference
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for(int i = 0; i < liste.length; i++){%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                        <td width="14%" align="center"><%=liste[i].getIdHistorique()%></td>
                                        <td width="14%" align="center"><%=utilitaire.Utilitaire.datetostring(liste[i].getDateHistorique()) %> </td>
                                        <td width="14%" align="center"><%=liste[i].getHeure() %></td>
                                        <td width="14%" align="center">
                                            
                                            <%=liste[i].getObjet().replace("mg.cnaps.", " ") %> </td>
                                        <td width="14%" align="center"><%=liste[i].getAction() %> </td>
                                        <td width="14%" align="center"><%=liste[i].getIdUtilisateur() %></td>
                                        <td width="14%" align="center">
                                            <a href="<%=pr.getLien()%>?but=mapTable-fiche.jsp&classe=<%=liste[i].getObjet()%>&id=<%=liste[i].getRefObjet()%>"><%=liste[i].getRefObjet() %> </a>
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            out.println(pr.getBasPage());
        %>
    </section>
</div>