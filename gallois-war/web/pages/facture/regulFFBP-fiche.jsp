
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.RegulFFBP"%>
<%@page import="affichage.*"%>
<%
    try{
    RegulFFBP a = new RegulFFBP();
    String lien = (String)session.getValue("lien");
    PageConsulte pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("id").setVisible(false);
    pc.getChampByName("idbp").setLibelle("Bon provisoire");
    pc.getChampByName("idff").setLibelle("Facture fournisseur");
    pc.getChampByName("montant").setLibelle("Montant");
    pc.getChampByName("idbp").setLien(lien+"?but=facture/facture-fournisseur-fiche-vaovao.jsp", "id=");
    pc.getChampByName("idff").setLien(lien+"?but=facture/facture-fournisseur-fiche-vaovao.jsp", "id=");
    pc.setTitre("Regularisation Facture via Bon provisoire");
    a=(RegulFFBP)pc.getBase();
    String id = a.getId();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/regulFFBP-saisie.jsp "><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        </div>
                        <div class="box-footer" style="margin-left:30%">
                            <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id")%>&bute=facture/regulFFBP-fiche.jsp&classe=mg.spat.RegulFFBP" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien")%>?but=facture/regulFFBP-modif.jsp&id=<%=id%>" style="margin-right: 10px">Modifier</a>
                            
                        </div>                    
                </div>
            </div>
        </div>
    </div>
  
</div><%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
 