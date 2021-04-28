<%-- 
    Document   : bordereauxFF-details-fiche
    Created on : 28 avr. 2021, 16:11:05
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
    BordereauFilleLibComplet res;
%>
<%
    UserEJB u = (UserEJB) session.getAttribute("u");
    res = new BordereauFilleLibComplet();
    res.setNomTable("liaisonbordereauFF_libcomplet");
    
    PageConsulte pc = new PageConsulte(res, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    res = (BordereauFilleLibComplet) pc.getBase();
   
    pc.getChampByName("idbordereau").setLibelle("Bordereau");
    pc.getChampByName("idfacture").setLibelle("Facture");
    pc.getChampByName("idop").setLibelle("Ordonner payement");
    pc.getChampByName("idbordereaulib").setLibelle(" Designation bordereau");
    pc.getChampByName("idbordereau").setLien("module.jsp?but=ded/bordereauxFF-fiche.jsp", "id=");
    pc.getChampByName("idfacture").setLien("module.jsp?but=facture/facture-fournisseur-fiche.jsp", "id=");

    pc.setTitre("Fiche detail bordereau facture fournisseur");
    String id=res.getId();
     
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">
                            <!--<a href="<%=(String) session.getValue("lien")%>?but=ded/bordereaux-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a>-->
                            <%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <!--<a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/bordereauxFF-modif.jsp&id=" + id %>" style="margin-right: 10px">Modifier</a>-->

                        </div>
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