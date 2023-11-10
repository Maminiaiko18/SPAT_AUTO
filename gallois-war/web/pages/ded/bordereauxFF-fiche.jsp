<%-- 
    Document   : bordereauxFF-fiche
    Created on : 28 avr. 2021, 14:10:27
    Author     : nyamp
--%>

<%@page import="bordereau.BordereauFF"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="bordereau.BordereauLibComplet" %>
<%@ page import="bordereau.BordereauFilleLibComplet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    BordereauFF res;
%>
<%
    UserEJB u = (UserEJB) session.getAttribute("u");
    res = new BordereauFF();
    res.setNomTable("FSBBED");
    if( request.getParameter("idmere")!=null){
        res.setId(request.getParameter("idmere"));
    }
    PageConsulte pc = new PageConsulte(res, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    res = (BordereauFF) pc.getBase();
   
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("montantbudget").setVisible(false);
    pc.getChampByName("montantav").setVisible(false);
    pc.getChampByName("montantap").setVisible(false);
    pc.getChampByName("numfsb").setVisible(false);
    pc.getChampByName("etat").setVisible(false);
    pc.getChampByName("idfactures").setVisible(false);


    //pc.getChampByName("idfactures").setLibelle("Factures");
    pc.getChampByName("projet").setVisible(false);
    pc.getChampByName("direction").setVisible(false);
    pc.getChampByName("directionlib").setLibelle("Direction");
    pc.getChampByName("projetlib").setLibelle("Projet");
    pc.getChampByName("idengagement").setLien((String) session.getValue("lien") + "?but=depense/engagement-fiche.jsp&id=" + res.getIdengagement(), "");
    pc.getChampByName("idengagement").setLibelle("Engagement");
    pc.getChampByName("typebordereaulib").setLibelle("Type");
    pc.getChampByName("typebordereau").setVisible(false);

    pc.setTitre("Fiche bordereau facture fournisseur");
    String id=res.getId();
    BordereauFilleLibComplet fille=new BordereauFilleLibComplet();
    fille.setIdbordereau(id);
    fille.setNomTable("liaisonbordereauFF_libcomplet");
    BordereauFilleLibComplet[] liste = (BordereauFilleLibComplet[]) CGenUtil.rechercher(fille, null, null, "");
    double total=AdminGen.calculSommeDouble(liste, "montant");
    boolean etatDepense = false;
    String option = "1";
    String btnLib = "Imprimer BED";
    if(res.getTypebordereau() != null && res.getTypebordereau().compareToIgnoreCase(Constante.typeEtatDepense) == 0){
        option = "0";
        etatDepense = true;
        btnLib = "Imprimer Etat de dépenses";
    }
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=ded/bordereaux-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a id="imprimer" class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerBed2&id=<%=id%>&option=<%=option%>" style="margin-right: 10px"> <%= btnLib %></a>
                             <%-- <a  class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerSuiviBudgetaire&id=<%=id%>" style="margin-right: 10px">Imprimer FSB</a> --%>
                            <%-- <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/bordereauxFF-details-saisie.jsp&idbordereau="+id%>" style="margin-right: 10px">Ajouter facture</a>  --%>
                            <!--<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=valider&bute=ded/bordereauxFF-fiche.jsp&classe=bordereau.BordereauFF&nomtable=bordereauFF" style="margin-right: 10px">Viser</a>-->
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=engagerBED&bute=ded/bordereauxFF-fiche.jsp&classe=bordereau.BordereauFF&nomtable=bordereauFF" style="margin-right: 10px">Engager</a>
                        <% 
                                if(res.getIdengagement() == null){
                            %>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/bordereauxFF-modif.jsp&id=" + id %>" style="margin-right: 10px">Modifier</a>
                            <% 
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
                        
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h2 class="box-title" style="margin-left: 10px;">Liste d&eacute;tails bordereaux</h2>
                    </div>
                    <div class="box-body">
                                
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th style="background-color:#bed1dd;">ID</th>
                                    <th style="background-color:#bed1dd;">Designation</th>
                                    <th style="background-color:#bed1dd;">Facture</th>
                                    <th style="background-color:#bed1dd;">Code Dir</th>
                                    <th style="background-color:#bed1dd;">Montant HT</th>
                                    <th style="background-color:#bed1dd;"></th>
                                </tr>
                            </thead>
                            <tbody>
                               
                                <%if (liste != null && liste.length > 0) {
                                        int i= -1;
                                        for (BordereauFilleLibComplet detail : liste) {%>
                                <tr>
                                    <td><%=utilitaire.Utilitaire.champNull(detail.getId())%></td>
                                    <td><%=utilitaire.Utilitaire.champNull(detail.getRemarque())%></td>
                                    <td>
                                        <a href="<%=(String) session.getValue("lien")%>?but=facture/facture-fournisseur-fiche-vaovao.jsp&id=<%=utilitaire.Utilitaire.champNull(detail.getIdfacture())%>">
                                            <%=utilitaire.Utilitaire.champNull(detail.getIdfacture())%>
                                        </a>
                                    </td>
                                    <td align="right"><%=utilitaire.Utilitaire.champNull(detail.getCode_etablissementlib())%></td>
                                    <td align="right"><%=utilitaire.Utilitaire.formaterAr(detail.getMontant())%></td>
                                    <td>
                                    <form action="<%=(String) session.getValue("lien")+"?but=apresTarif.jsp&id=" + detail.getId()%>" method="post">
                                        <input type="hidden" name="acte" value="delete"/>
                                        <input type="hidden" name="bute" value="ded/bordereauxFF-fiche.jsp&id=<%=request.getParameter("id")%>"/>
                                        <input type="hidden" name="classe" value="bordereau.BordereauFilleFF"/>
                                        <input type="hidden" name="nomtable" value="liaisonbordereauFF"/>
                                        <input type="submit" class="btn btn-danger pull-right" value="Supprimer"/>
                                    </form>
                                    </td>
                                </tr>
                                <%}%>
                                 <tr>
                                     <td colspan="4" align="right"><b>Total</b></td>   
                                     <td align="right"><%=utilitaire.Utilitaire.formaterAr(total)%></td>   
                                 </tr>
                                <%} else {%>
                                <tr><td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td></tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
  function choix() {
    var selectedOption = document.getElementById("choix").value;
    var link = document.getElementById("imprimer");
    var href = "<%=(String) session.getValue("lien") + "/../../Paie?action=imprimerBed2&id=" + res.getId()%>"+"&option=" + selectedOption;
    link.href = href;

    var link2 = document.getElementById("imprimerfsb");
    var href2 = "<%=(String) session.getValue("lien") + "/../../Paie?action=imprimerSuiviBudgetaire&id=" + res.getId()%>"+"&option=" + selectedOption;
    link2.href = href2;
  }
</script>

<%
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> 
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
    <% }%>
   

