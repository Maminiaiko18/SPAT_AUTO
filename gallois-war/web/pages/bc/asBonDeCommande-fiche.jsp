<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%
    BonDeCommande dma;
    double total = 0.0;
%>
<%
    dma = new BonDeCommande();
    dma.setNomTable("AS_BONDECOMMANDE_LIBELLE");
    PageConsulte pc = new PageConsulte(dma, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("modepaiement").setLibelle("Mode de paiement");
    pc.setTitre("Fiche Bon de commande");
    
    BonDeCommande bondecommande = (BonDeCommande)pc.getBase();

	//
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=bc/asBonDeCommande-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
							<% if (bondecommande.getEtat() == ConstanteEtat.getEtatCreer()){ %>
								<a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annuler&bute=bc/asBonDeCommande-fiche.jsp&classe=mg.spat.stock.BonDeCommande&id=" + bondecommande.getId()%>" style="margin-right: 10px">Annuler</a>
								<a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=bc/asBonDeCommande-modif.jsp&id=" + bondecommande.getId()%>" style="margin-right: 10px">Modifier</a>
								<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&bute=bc/asBonDeCommande-fiche.jsp&classe=mg.spat.stock.BonDeCommande&id=" + bondecommande.getId()%>" style="margin-right: 10px">Viser</a>
							<% }%>
							<% if (bondecommande.getEtat() == ConstanteEtat.getEtatValider()){ %>
								<a class="btn btn-primary pull-right"  href="#" onclick="pagePopUp('bc/asBonDeCommande-achat.jsp?id=<%=bondecommande.getId()%>')" style="margin-right: 10px">Aper&ccedil;u</a>
								<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=bc/apresBC.jsp&acte=generateOPByBC&bute=ded/ordonnerpayement-fiche.jsp&id="+bondecommande.getId()%>" style="margin-right: 10px" >Editer OP</a>
								<a class="btn btn-default pull-right"  href="<%=(String) session.getValue("lien") + "?but=bl/asBonDeLivraison-direct.jsp&idbc=" + bondecommande.getId()%>" style="margin-right: 10px">Reception</a>
							<% } %>
                            <% 
								if (bondecommande.getEtat() == ConstanteEtat.getEtatLivraison()){ 
									BonDeLivraison liv = new BonDeLivraison();
									String idbl = " AND idbc = '" + bondecommande.getId().trim() + "'";

									BonDeLivraison[] filles = (BonDeLivraison[]) CGenUtil.rechercher(liv, null, null, idbl);
							%>
								<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=bl/bondelivraison-fiche.jsp&id=" + filles[0].getId()%>" style="margin-right: 10px">Etat de livraison</a>
							<% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%out.println(pc.getBasPage());%>
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">D&eacute;tails bon de commande</h1>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Produit</th>
                                    <th>Quantit&eacute;</th>
                                    <th>P.U</th>
                                    <th>Montant</th>
                                    <th>Remarque</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    BonDeCommandeFille p = new BonDeCommandeFille();
									p.setNomTable("as_bondecommande_fille_libelle"); // vue
                                    BonDeCommandeFille[] liste = (BonDeCommandeFille[]) CGenUtil.rechercher(p, null, null, " and idbc = '" + bondecommande.getId() + "'");

                                    for (int i = 0; i < liste.length; i++) {
										double montant = liste[i].getQuantite() *liste[i].getPu();
                                %>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                    <td  align="center"><%=liste[i].getProduit()%> </td>
                                    <td  align="center"><%=liste[i].getQuantite()%></td>
                                    <td  align="right"><%=Utilitaire.formaterAr(liste[i].getPu())%></td>
                                    <td  align="right"><%=Utilitaire.formaterAr(montant)%></td>
                                    <td  align="center"><%=Utilitaire.champNull(liste[i].getRemarque())%></td>
                                </tr>
                                <%
                                    total += ((liste[i].getQuantite() * liste[i].getPu()));
                                    }
                                    double tva = (total * bondecommande.getTva()) / 100;
                                %>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                    <td  align="center"></td>
                                    <td  align="right"></td>
                                    <td  align="right">TVA</td>
                                    <td  align="right"><%=Utilitaire.formaterAr(tva)%></td>
                                    <td  align="center"></td>
                                </tr>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                    <td  align="center"></td>
                                    <td  align="right"></td>
                                    <td  align="right">Total</td>
                                    <td  align="right"><%=Utilitaire.formaterAr(tva + total)%></td>
                                    <td  align="center"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
