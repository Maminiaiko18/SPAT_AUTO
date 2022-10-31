<%-- 
    Author     : Michel
--%>
<%@page import="bean.CGenUtil"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="mg.spat.ClientQuit"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    try{
        String 
                acte = "update",
                but = "apresTarif.jsp",
                table = "client_quit",
                classe = "mg.spat.ClientQuit",
                bute = "facture/client-quit-fiche.jsp",
                titre = "Modification Quittance",
                cdclt = request.getParameter("cdclt")
        ;
        ClientQuit o = new ClientQuit();
        o.setNomTable("client_quit");
        PageUpdate pi = new PageUpdate(o, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        
        o =(ClientQuit)pi.getBase();
        
        pi.getFormu().getChamp("cdclt").setLibelle("Id");
        pi.getFormu().getChamp("cdclt").setPageAppel("choix/listeClientDBspatChoix.jsp","cdclt;cdcltlibelle");
       
        pi.getFormu().getChamp("dtquit").setLibelle("Date");
        pi.getFormu().getChamp("dtquit").setDefaut(utilitaire.Utilitaire.dateDuJour());

        pi.getFormu().getChamp("quit").setLibelle("Quittance");

        
        pi.getFormu().getChamp("valide").setVisible(false);
        
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1><%= titre %></h1>
                    <form action="<%=pi.getLien()%>?but=<%= but %>" method="post" name="starticle" id="starticle">
                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="nature" value="<%= acte %>">
                    <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                    <input name="nomtable" type="hidden" id="nomtable" value="<%= table %>">
                    <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                    <input name="rajoutLien" type="hidden" id="rajoutLien" value="<%= "cdclt" %>">
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</div>

    <%
    }catch(Exception e){
e.printStackTrace();
}
    %>