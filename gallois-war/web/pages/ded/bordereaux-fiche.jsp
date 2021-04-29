<%-- 
    Document   : bordereaux-fiche.jsp
    Created on : 21 janv. 2021, 09:36:23
    Author     : nyamp
--%>
<%-- 
    Document   : facture-client-fiche
    Created on : 5 oct. 2017, 16:20:14
    Author     : BillySycher
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
//    res.setNomTable("PAIEMENTFACTURECLIENT");
//    String[] libellePaiementFiche = {"Id", "Date", "Client", "Designation", "Compte CR", "TVA (%)", "Etat", "Devise", "Compte", "R&eacute;f&eacute;rence facture", "Cours devise", "Montant","Avoir ", "Montant TVA", "Montant Total a payer", "Montant encaiss&eacute;", "Reste à payer"};
    PageConsulte pc = new PageConsulte(res, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    res = (BordereauLibComplet) pc.getBase();
   
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("tiers").setVisible(false);
    pc.setTitre("Fiche bordereau");
    String id=res.getId();
    BordereauFilleLibComplet fille=new BordereauFilleLibComplet();
    fille.setIdbordereau(id);
    BordereauFilleLibComplet[] liste = (BordereauFilleLibComplet[]) CGenUtil.rechercher(fille, null, null, "");
//    pc.getChampByName("tiers").setLien((String) session.getValue("lien") + "?but=cms/ordonnance/ordonnance-externe-fiche.jsp"+res.getTiers(), "id=");
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
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/bordereaux-modif.jsp&id=" + id %>" style="margin-right: 10px">Modifier</a>
                            <a style="margin-right : 20px" class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=valider&bute=ded/bordereaux-fiche.jsp&classe=bordereau.Bordereau" style="margin-right: 10px">Viser</a>
                            <a style="margin-right : 20px" class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=payerBordereau&bute=ded/bordereaux-fiche.jsp&classe=bordereau.Bordereau" style="margin-right: 10px">Payer Bordereau</a>

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
                                    <th style="background-color:#bed1dd;">Ordonner payement</th>
                                    <th style="background-color:#bed1dd;">Montant OP</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%if (liste != null && liste.length > 0) {
                                        for (BordereauFilleLibComplet detail : liste) {%>
                                <tr>
                                    <td><%=utilitaire.Utilitaire.champNull(detail.getId())%></td>
                                    <td><%=utilitaire.Utilitaire.champNull(detail.getRemarque())%></td>
                                    <td>
                                        <a href="<%=(String) session.getValue("lien")%>?but=facture/facture-fournisseur-fiche.jsp&id=<%=utilitaire.Utilitaire.champNull(detail.getIdfacture())%>">
                                            <%=utilitaire.Utilitaire.champNull(detail.getIdfacture())%>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="<%=(String) session.getValue("lien")%>?but=ded/ordonnerpayement-fiche.jsp&id=<%=utilitaire.Utilitaire.champNull(detail.getIdop())%>">
                                            <%=utilitaire.Utilitaire.champNull(detail.getIdop())%> 
                                        </a>
                                    </td>
                                    <td align="right"><%=utilitaire.Utilitaire.formaterAr(detail.getMontant())%></td>
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
   <%
   }catch(Exception e){
    e.printStackTrace();
}
   %>