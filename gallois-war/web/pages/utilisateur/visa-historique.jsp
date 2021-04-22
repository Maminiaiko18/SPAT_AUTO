<%-- 
    Document   : visa-historique
    Created on : 21 déc. 2016, 12:00:58
    Author     : Jetta
--%>

<%@page import="affichage.Liste"%>
<%@page import="mg.cnaps.log.LogService"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.cnaps.commun.VisaObjectLibelle"%>

<%@page import="affichage.PageRecherche"%> 
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%
    VisaObjectLibelle hv = new VisaObjectLibelle();
    String listeCrt[] = {"id", "nomuser", "libelle", "refobjet", "daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "nomuser", "libelle", "refobjet", "daty"};
    PageRecherche pr = new PageRecherche(hv, request, listeCrt, listeInt, 3, libEntete, 5);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("daty1").setLibelleAffiche("Date min");
    pr.getFormu().getChamp("daty2").setLibelleAffiche("Date max");
     String awere = "";
    if ((request.getParameter("daty1") == null && request.getParameter("daty2") == null)) {
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
        awere += " and daty='" + Utilitaire.dateDuJour() + "'";
    }
    pr.setAWhere(awere);
    affichage.Champ[] liste2 = new affichage.Champ[1];
    LogService m = new LogService();
    liste2[0] = new Liste("libelle", m, "libelle", "libelle");
    pr.getFormu().changerEnChamp(liste2);
    pr.getFormu().getChamp("libelle").setLibelleAffiche("Service");
    pr.setApres("utilisateur/visa-historique.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    VisaObjectLibelle[] liste = (VisaObjectLibelle[]) pr.getTableau().getData();%>
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>  Historique visa</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/visa-historique.jsp" method="post" name="listehistorique" id="listeHistorique">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
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
                                            Personnel
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Service
                                        </th>

                                        
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Date
                                        </th>
                                        <th width="14%" align="center" valign="top" style="background-color:#bed1dd">
                                            Reference
                                        </th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < liste.length; i++) {%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                        <td width="14%" align="center"><%=liste[i].getId()%></td>
                                        <td width="14%" align="center"><%= liste[i].getNomuser()%> </td>
                                        <td width="14%" align="center"><%=liste[i].getLibelle()%></td> 
                                        <td width="14%" align="center"><%=Utilitaire.formatterDaty(liste[i].getDaty())%></td>
                                        <td width="14%" align="center">
                                            <a href="<%=pr.getLien()%>?but=mapTable-fiche.jsp&classe=<%=liste[i].getObjet()%>&id=<%=liste[i].getRefobjet()%>"><%=liste[i].getRefobjet()%> </a>
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
    </section>
</div>

