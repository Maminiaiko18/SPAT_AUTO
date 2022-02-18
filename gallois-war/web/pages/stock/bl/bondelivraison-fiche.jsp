<%-- 
    Document   : bondelivraison-fiche
    Created on : 25 nov. 2020, 17:50:10
    Author     : ASUS
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.stock.BonDeLivraisonFille"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<%@page import="java.sql.Date"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        BonDeLivraison inventaire = new BonDeLivraison();
        inventaire.setNomTable("AS_BONDELIVRAISON_BC");
        PageConsulte pc = new PageConsulte(inventaire, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.getChampByName("idbc").setLibelle("Num FF");
        pc.getChampByName("id_bc").setLibelle("Numero Bon de Commande");
        pc.getChampByName("id_bc").setLien((String) session.getValue("lien") + "?but=stock/bc/asBonDeCommande-fiche.jsp", "id=");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("remarque").setLibelle("Numero BL");
        pc.getChampByName("numbc").setLibelle("Numero  BC");
        pc.getChampByName("montant").setLibelle("Montant HT");
        pc.getChampByName("montanttva").setLibelle("Montant TVA");
        pc.getChampByName("montantttc").setLibelle("Montant TTC");
        pc.getChampByName("point").setVisible(false);
        pc.getChampByName("idbc").setVisible(false);
        pc.setTitre("Fiche bon de livraison");

        BonDeLivraison livraison= (BonDeLivraison)pc.getBase();
        /*Onglets*/
        String tab = null;
        Map<String, String> map = new HashMap<String, String>();
        map.put("detail-bl", "");
        map.put("facture-fournisseur-liste", "");

        String id = request.getParameter("id");
        tab = request.getParameter("tab");
        if (tab == null) {
            tab = "detail-bl";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=stock/bl/asBonDeLivraison-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + livraison.getId()%>&acte=annulerVisa&bute=stock/bl/bondelivraison-fiche.jsp&classe=mg.spat.stock.BonDeLivraison&nomtable=AS_BONDELIVRAISON" style="margin-right:10px">Annuler</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=stock/bl/bondelivraison-modif.jsp&id=" + livraison.getId()%>" style="margin-right:10px">Modifier</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=mg.spat.stock.BonDeLivraison&bute=stock/bl/bondelivraison-fiche.jsp&id=" + livraison.getId()%>" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-saisie-vaovao.jsp&idBL=" + livraison.getId()%>" style="margin-right:10px">Facturer</a>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-10 col-md-offset-1">
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
                <li class="<%= map.get("detail-bl")%>"><a href="globalnegoce.jsp?but=stock/bl/bondelivraison-fiche.jsp&id=<%=request.getParameter("id")%>&tab=detail-bl">Détails</a></li>
                <li class="<%= map.get("facture-fournisseur-liste")%>"><a href="globalnegoce.jsp?but=stock/bl/bondelivraison-fiche.jsp&id=<%=request.getParameter("id")%>&tab=facture-fournisseur-liste&idbl=<%=livraison.getId()%>">Facture fournisseur</a></li>
            </ul>

            <div class="tab-content">       
                 <jsp:include page="<%=tab%>" /> 
            </div>
        </div>           
        </div>           
    </div>


</div>
<% } catch (Exception ex) {
        ex.printStackTrace();
        throw new Exception(ex.getMessage());
    }%>