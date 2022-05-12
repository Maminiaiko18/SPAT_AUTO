<%-- 
    Document   : details-bc
    Created on : 14 déc. 2020, 10:13:13
    Author     : ASUS
--%>

<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="data.DetailsBcData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DetailsBcData data=new DetailsBcData(request.getParameter("id"));                                 
    data.setBCOrderByProduitAsc("AS_BONDECOMMANDE_LIBELLE_lib","BC_BL_LIVRE");
    BonDeCommandeFille[] liste = data.getBcFille();
    data.attribuerLigne();
    double total = data.getBc().getMontantTTC();
    double tva=data.getBc().getMontanttva();
    double remise=data.getBc().getMontantRemise();
%>
                <div class="box-title with-border">
                    <h1 class="box-title">D&eacute;tails bon de commande</h1>
                </div>
                <div class="box-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>N°</th>
                                <th>Produit</th>
                                <th>Quantit&eacute; command&eacute;e</th>
                                <th>Quantit&eacute; livr&eacute;e</th>
                                <th>Reste à livrer</th>
                                <th>Unit&eacute;</th>
                                <th>P.U</th>
                                <th>Montant</th>
                                <th>Montant Remise</th>
                                <th>TVA</th>
                                <th>Montant BL</th>
                                <th>Montant BL reste</th>
                                <th>Observation</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%   
                                double nbrligne=0;
                                for (int i = 0; i < liste.length; i++) {
                                    nbrligne = nbrligne + 1;
                            %>
                            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                <td  align="center"><%=liste[i].getNumeroLigne()%> </td>
                                <td  align="center"><%=Utilitaire.champNull(liste[i].getProduit())%> </td>
                                <td  align="center"><%=Utilitaire.formaterAr(liste[i].getQuantite())%></td>
                                <td  align="center"><%=Utilitaire.formaterAr(liste[i].getQuantitelivre())%></td>
                                <td  align="center"><%=Utilitaire.formaterAr(liste[i].getQuantitereste())%></td>
                                <td  align="center"><%=Utilitaire.champNull(liste[i].getUnite())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(liste[i].getPu())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(liste[i].getMontantHTSansRemise())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(liste[i].getMontantremise())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(liste[i].getTva())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(liste[i].getMontantbl())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(liste[i].getMontantblreste())%></td>
                                <td  align="right"><%=liste[i].getObservation()%></td>
                            </tr>
                            <%
                                     
                                }

                               
                            %>
                            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                <td  colspan="5" rowspan="4"></td>
                                <th  align="right">Montant HT</th>
                                <td  align="right"><%=Utilitaire.formaterAr(data.getBc().getMontantHTSansRemise())%></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                <th  align="right">Montant Remise</th>
                                <td  align="right"><%=Utilitaire.formaterAr(remise)%></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                <th  align="right">Montant TVA</th>
                                <td  align="right"><%=Utilitaire.formaterAr(tva)%></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                <th  align="right">Montant TTC</th>
                                <td  align="right"><%=Utilitaire.formaterAr(total)%></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                <th  align="right">Nombre de ligne</th>
                                <td  align="right"><%=nbrligne%></td>
                            </tr>

                        </tbody>
                    </table>
                </div>