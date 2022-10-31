
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.Client"%>
<%@page import="affichage.*"%>
<%
    try{
    Client a = new Client();
    a.setNomTable("client");
    PageConsulte pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("cdcat").setVisible(false);
    pc.getChampByName("cdclt").setLibelle("ID");
    pc.getChampByName("nomclt").setLibelle("Nom");
    pc.getChampByName("adrclt").setLibelle("Adresse");
    pc.getChampByName("nmsttclt").setLibelle("STAT");
    pc.getChampByName("telclt").setLibelle("Telephone");
    pc.getChampByName("faxclt").setLibelle("FAX");
    pc.getChampByName("nmcin").setLibelle("CIN");
    pc.getChampByName("rc").setLibelle("RC");
    pc.getChampByName("nif").setLibelle("NIF");
    pc.setTitre("Fiche client");
    a=(Client)pc.getBase();
    String id = a.getCdclt();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/client-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        </div>
                        <div class="box-footer" style="margin-left:30%">
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien")%>?but=facture/client-modif.jsp&cdclt=<%=id%>" style="margin-right: 10px">Modifier</a>
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
 