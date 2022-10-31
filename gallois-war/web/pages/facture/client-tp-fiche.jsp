<%-- 
    Document   : client-tp-fiche
    Created on : 31 oct. 2022, 11:39:40
    Author     : Jacques
--%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.ClientTP"%>
<%@page import="affichage.*"%>
<%
    try{
    ClientTP a = new ClientTP();
    a.setNomTable("client_tplib");
    PageConsulte pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("valide").setVisible(false);
    pc.setTitre("Fiche Client TP");
    a=(ClientTP)pc.getBase();
    String id = a.getCdclt();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/client-tp-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        </div>
                        <div class="box-footer" style="margin-left:30%">
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien")%>?but=facture/client-tp-modif.jsp&id=<%=id%>" style="margin-right: 10px">Modifier</a>
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