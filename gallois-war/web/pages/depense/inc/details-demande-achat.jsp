<%@page import="mg.spat.DemandeAchatFille"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DemandeAchatFille j = new DemandeAchatFille();
    j.setNomTable("dem_achat_fillelib");
    j.setIdmere(request.getParameter("id"));
    String libEntete[] = {"id", "designation", "pu","qte","unitelib"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setAWhere("and idmere='"+request.getParameter("id")+"'");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setOrdre(" order by designation asc");
    pr.setNpp(1000);
    pr.creerObjetPage(libEntete, null);

    pr.getTableau().setLibelleAffiche(new String[]{"ID", "D&eacute;signation", "PU","Qantit&eacute;","Unit&eacute;"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtml();
    DemandeAchatFille[] da = (DemandeAchatFille[])pr.getTableau().getData();
    if (html != null) {%>

     <div class="box-title with-border">
                    <h1 class="box-title">D&eacute;tails DASE</h1>
                </div>
                <div class="box-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>N°</th>
                                <th>D&eacute;signation</th>
                                <th>Prix Unitaire</th>
                                <th>Quantit&eacute;</th>
                                <th>Unit&eacute;</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%   
                                int nbrligne=0;
                                for (int i = 0; i < da.length; i++) {
                                    nbrligne = nbrligne + 1;
                            %>
                            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                <td  align="center"><%= nbrligne %> </td>
                                <td  align="center"><%=Utilitaire.champNull(da[i].getDesignation())%> </td>
                                <td  align="center"><%=Utilitaire.formaterAr(da[i].getPu())%> </td>
                                <td  align="center"><%= da[i].getQte() %></td>
                                <td  align="center"><%=Utilitaire.champNull(da[i].getUnitelib())%></td>
                            </tr>
                            <%
                                     
                                }

                               
                            %>
                        </tbody>
                    </table>
                </div>
    
</form
<% } else {
%><center><h4>Pas de r�sultat</h4></center><%
    }
    %>
