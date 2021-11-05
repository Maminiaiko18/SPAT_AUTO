<%-- 
    Document   : bordereauxFF-fiche
    Created on : 28 avr. 2021, 14:10:27
    Author     : nyamp
--%>

<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="bordereau.BordereauLibComplet" %>
<%@ page import="bordereau.BordereauFilleLibComplet" %>
<%
    try{
    BordereauLibComplet res;
%>
<%
    UserEJB u = (UserEJB) session.getAttribute("u");
    res = new BordereauLibComplet();
    res.setNomTable("bordereauFF_libcomplet");
    if( request.getParameter("idmere")!=null){
        res.setId(request.getParameter("idmere"));
    }
    PageConsulte pc = new PageConsulte(res, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    res = (BordereauLibComplet) pc.getBase();
   
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("tiers").setVisible(false);
    pc.setTitre("Fiche bordereau facture fournisseur");
    String id=res.getId();
    BordereauFilleLibComplet fille=new BordereauFilleLibComplet();
    fille.setIdbordereau(id);
    fille.setNomTable("liaisonbordereauFF_libcomplet");
    BordereauFilleLibComplet[] liste = (BordereauFilleLibComplet[]) CGenUtil.rechercher(fille, null, null, "");
    double total=AdminGen.calculSommeDouble(liste, "montant");
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
                            <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerBed2&id=<%=id%>" style="margin-right: 10px">Imprimer</a>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/bordereauxFF-details-saisie.jsp&idbordereau="+id%>" style="margin-right: 10px">Ajouter facture</a> 
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=valider&bute=ded/bordereauxFF-fiche.jsp&classe=bordereau.BordereauFF&nomtable=bordereauFF" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/bordereauxFF-modif.jsp&id=" + id %>" style="margin-right: 10px">Modifier</a>

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
                        <h2 class="box-title" style="margin-left: 10px;">Liste détails bordereaux</h2>
                    </div>
                    <div class="box-body">
                                
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th style="background-color:#bed1dd;">ID</th>
                                    <th style="background-color:#bed1dd;">Designation</th>
                                    <th style="background-color:#bed1dd;">Facture</th>
                                    <th style="background-color:#bed1dd;">Code Dir</th>
                                    <th style="background-color:#bed1dd;">Montant OP</th>
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
                                    <td align="right"><%=utilitaire.Utilitaire.champNull(detail.getCode_etablissement())%></td>
                                    <td align="right"><%=utilitaire.Utilitaire.formaterAr(detail.getMontant())%></td>
                                    <td><a style="margin-right : 20px" class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + detail.getId() %>&acte=delete&bute=ded/bordereauxFF-liste.jsp&classe=bordereau.BordereauFilleFF&nomtable=liaisonbordereauFF" style="margin-right: 10px">Supprimer</a></td>
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
   <%
   }catch(Exception e){
    e.printStackTrace();
}
   %>