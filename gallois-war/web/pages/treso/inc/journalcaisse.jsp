<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String condition = "";
        JournalCaisseLibComplet jc = new JournalCaisseLibComplet();       
        jc.setNomTable("JOURNALCAISSELIBCOMPLET");
        String libEntete[] = {"id", "libelle", "valcaisse", "dateeffet", "debit", "credit"};
        String listeCrt[] = {"idmvtcaisse"};
        String listeInt[] = {};
        PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/inc/journalcaisse.jsp");
        String[] colSomme = null;
        if(request.getParameter("id") != null){
            condition = " and idmvtcaisse='"+request.getParameter("id")+"'";
        }
        pr.setAWhere(condition);
        pr.creerObjetPage(libEntete, colSomme);

        
        String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"ID", "Libell&eacute;", "Caisse", "Date", "D&eacute;bit", "Cr&eacute;dit"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);  
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());   
        }else{%>
            <center><h3>Aucun résultat</h3></center>
        <%} 
            
        %>
    </section>
<% }catch (Exception e) {
        e.printStackTrace();
    }%>