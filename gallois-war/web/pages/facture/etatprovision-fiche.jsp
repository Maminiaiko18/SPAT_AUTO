<%-- 
    Document   : compte-client-1 dfiche
    Created on : 7 sept. 2021, 09:16:02
    Author     : Rija
--%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.EtatProvision"%>
<%@page import="affichage.*"%>
<%
    try{
    EtatProvision a = new EtatProvision();
    a.setNomTable("etat_provisionlib");
    PageConsulte pc = pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("idnavire").setVisible(false);
    pc.getChampByName("idmode").setVisible(false);
    pc.getChampByName("idbanque").setVisible(false);
      pc.getChampByName("numpiece").setLibelle("Numero du piece");
    pc.getChampByName("numProvision").setLibelle("Numero du provision");
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("idnavirelib").setLibelle("Navire");
    
    pc.getChampByName("idmodelib").setLibelle("Mode");
    pc.getChampByName("idbanquelib").setLibelle("Banque");
    pc.getChampByName("IdFacturelib").setLibelle("Facture");
    pc.setTitre("Fiche etat provision");
    a=(EtatProvision)pc.getBase();
    pc.getChampByName("idnavirelib").setLien((String) session.getValue("lien") + "?but=capitainerie/navire-fiche.jsp&id="+a.getIdnavire(), "id=");
    String id = a.getId();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/etatprovision-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        </div>
                        <div class="box-footer" style="margin-left:30%">
                            <a class="btn btn-primary pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerEtatProvision&id=<%=id%>" style="margin-right: 10px">Etat de provision</a>
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
 