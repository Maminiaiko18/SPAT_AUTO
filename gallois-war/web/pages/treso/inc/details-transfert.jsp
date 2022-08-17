
<%@page import="mg.spat.MvtIntraCaisseFille"%>
<%@page import="java.util.Date"%>
<%@page import="bon.RegulBP"%>
<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String condition = "";
        MvtIntraCaisseFille ff = new MvtIntraCaisseFille();       
        ff.setNomTable("mvtintracaisse_fille");
        String libEntete[] = {"id"};
        String listeCrt[] = {"id"};
        String listeInt[] = {""};
        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/inc/details-tranfert.jsp");
        String[] colSomme = null;
        if(request.getParameter("id") != null){
            condition = "and idmere='"+request.getParameter("id")+"'";
        }
        pr.setAWhere(condition);
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
    <section class="">
        <%
            //String lienTableau[] = {pr.getLien() + "?but=treso/transfert-caisse-fiche.jsp"};
            //String colonneLien[] = {"id"};
            //pr.getTableau().setLien(lienTableau);
            //pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id", "reference", "remarque"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            if(pr.getTableau().getHtml() != null){
                out.println(pr.getTableau().getHtml());   
            }else{%>
            <center><h3>Aucun résultat</h3></center>
            <%}
            
        %>
    </section>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>