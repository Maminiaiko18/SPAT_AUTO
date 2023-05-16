<%@page import="mg.spat.stock.BonDeLivraisonFille"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<%@page import="java.sql.Date"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
        BonDeLivraisonFille fille = new BonDeLivraisonFille();
        //fille.setNomTable("as_bondelivraison_fille_lib");
        fille.setNomTable("AS_BONDELIVRAISON_FILLE_MTT");

        String idbl = " AND NUMBL = '" + request.getParameter("id").trim() + "' order by produit";

        BonDeLivraisonFille[] filles = (BonDeLivraisonFille[]) CGenUtil.rechercher(fille, null, null, idbl);
        double sommeHT = AdminGen.calculSommeDouble(filles, "montantHT");
        double sommeTVA = AdminGen.calculSommeDouble(filles, "montanttva");
        double sommeTTC = sommeHT + sommeTVA;
%>
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title">D�tails</h1>
                </div>
                <div class="box-body no padding">
                    <table class="table table-bordered">
                        <tr>
                            <th align="center">ID</th>
                            <th align="center">Produit</th>
                            <th align="center">Quantit&eacute;</th>
                            <th align="center">Montant HT</th>
                            <th align="center">Montan TVA</th>
                             <th align="center">Montan TTC</th>
                            <!--<th align="center"></th>-->
                        </tr>

                        <%
                            for (int i = 0; i < filles.length; i++) {%>
                        <tr>
                            <td align="left"><%=filles[i].getId()%></td>
                            <td align="left"><%=filles[i].getProduit()%></td>
                            <td align="right"><%=Utilitaire.formaterAr(filles[i].getQuantite())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(filles[i].getMontantHT())%></td>
                             <td align="right"><%=Utilitaire.formaterAr(filles[i].getMontanttva())%></td>
                              <td align="right"><%=Utilitaire.formaterAr(filles[i].getMontanttc())%></td>
                            <!--<td  align="right"> <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=delete&classe=mg.spat.stock.BonDeLivraisonFille&bute=stock/bl/bondelivraison-fiche.jsp&id=" + filles[i].getId()%>" style="margin-right: 10px">Supprimer</a>-->
                        </tr>
                        <% }%> 
                        
                        <tr>
                            <th colspan="3" style="text-align: end">Total</th>
                            <th style="text-align: end"><%=Utilitaire.formaterAr(sommeHT)%></th>
                            <th style="text-align: end"><%=Utilitaire.formaterAr(sommeTVA)%></th>
                            <th style="text-align: end"><%=Utilitaire.formaterAr(sommeTTC)%></th>
                        </tr>
                    </table>
                </div>
        </div>            
