<%-- 
    Document   : factureFournisseur
    Created on : 16 févr. 2022, 09:08:49
    Author     : nyamp
--%>

<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureFournisseur facture = new FactureFournisseur();
    facture.setNomTable("LIAISONOPFF_msum");
    FactureFournisseur[] liste = (FactureFournisseur[]) CGenUtil.rechercher(facture, null, null, " and id2 = '" + request.getParameter("id") + "'");
    int t = liste.length;
    if(t == 0) {
%>
        <center><h4>Aucun details </h4></center>
<%
    }
    else {
%>
<div style="background:#ffb401; color:white;" class="box-header"><h3 class="box-title" align="center">LISTE</h3></div>
<div class="box-body table-responsive no-padding">
    <div id="selectnonee">
        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
            <thead>
                <tr class="head">
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">id</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Date</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Fournisseur</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">N° Facture</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Numero compta</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Projet</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Code direction</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Nature</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Note explicative</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">exercice</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">date echeance</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">montant TTC</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">montant Avoir</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Net à payer</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Montant payé</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Reste à payer</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white">Numero OP</th>
                    <th width="5%" align="center" valign="top" style="background-color:#103a8e;color:white"></th>
                </tr>
            </thead>
            <tbody>
               <%
                    for(int i = 0; i < t; i++){
                %>
                <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''" style="">
                    <td width="5%" align="left"><a href="globalnegoce.jsp?but=facture/facture-fournisseur-fiche-vaovao.jsp&id=<%= liste[i].getId() %>"><%= liste[i].getId() %></a> </td>
                    <td width="5%" align="left"><%= Utilitaire.formatterDaty(liste[i].getDaty()) %></td>
                    <td width="5%" align="left"><%= liste[i].getTierslib() %></td>
                    <td width="5%" align="left"><%= liste[i].getNumeroop() %></td>
                    <td width="5%" align="left"><%= liste[i].getCode() %></td>
                    <td width="5%" align="left"><%= liste[i].getProjetlib() %></td>
                    <td width="5%" align="left"><%= liste[i].getCode_etablissementlib() %></td>
                    <td width="5%" align="left"><%= liste[i].getNaturelib() %></td>
                    <td width="5%" align="left"><%= liste[i].getDesignation() %></td>
                    <td width="5%" align="left"><%= liste[i].getExercice() %></td>
                    <td width="5%" align="left"><%= Utilitaire.formatterDaty(liste[i].getDate_echeance()) %></td>
                    <td width="5%" align="right"><%= Utilitaire.formaterAr(liste[i].getMontantttcvrai()) %></td>
                    <td width="5%" align="left"><%= Utilitaire.formaterAr(liste[i].getMontantavoir()) %></td>
                    <td width="5%" align="right"><%= Utilitaire.formaterAr(liste[i].getMontantttc()) %></td>
                    <td width="5%" align="right"><%= Utilitaire.formaterAr(liste[i].getMontantpaye()) %></td>
                    <td width="5%" align="left"><%= Utilitaire.formaterAr(liste[i].getMontantreste()) %> </td>
                    <td width="5%" align="left"><%= liste[i].getNumOP() %></td>
                    <td>
                        <form action="<%=(String) session.getValue("lien")+"?but=ded/apresOrdonner.jsp&id=" + liste[i].getId()%>" method="post">
                            <input type="hidden" name="acte" value="deleteOPFF"/>
                            <input type="hidden" name="bute" value="ded/ordonnerpayement-fiche.jsp&id=<%=request.getParameter("id")%>"/>
                            <input type="hidden" name="idfacture" value="<%=liste[i].getId()%>"/>
                            <input type="hidden" name="idop" value="<%=request.getParameter("id")%>"/>
                            <input type="hidden" name="classe" value="ded.OrdonnerPayement"/>
                            <input type="hidden" name="nomtable" value="OrdonnerPayement"/>
                            <input type="submit" class="btn btn-danger pull-right" value="Supprimer"/>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
<%
    }
%>