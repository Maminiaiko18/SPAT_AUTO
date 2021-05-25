
<%@page import="facture.TransitionPaiementVide"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="mg.spat.Tva"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    
    String  mapping = "facture.TransitionPaiementVide",
            nomtable = "TRANSITIONPAIEMENTVIDE",
            apres = "apresPaiement.jsp",
            titre = "Transition Paiement",
            acte = "payerFC";
    String[] ids = request.getParameterValues("id");
    String listeId = ids!=null ? Utilitaire.tabToString(ids, "'", ",") : "";
    
    TransitionPaiementVide objet = new TransitionPaiementVide();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[4];
        TypeObjet caisse = new TypeObjet();
        caisse.setNomTable("CAISSE");
        liste[0] = new Liste("caisse", caisse, "val", "id");
        
        TypeObjet modePayement = new TypeObjet();
        modePayement.setNomTable("MODEPAIEMENT");
        liste[1] = new Liste("modepaiement", modePayement, "val", "id");
        
        TypeObjet typeCheque  = new TypeObjet();
        typeCheque.setNomTable("TYPECHEQUE");
        liste[2] = new Liste("typeCheque", typeCheque , "val", "id");
        
        TypeObjet devise= new TypeObjet();
        devise.setNomTable("DEVISE");
        liste[3] = new Liste("iddevise", typeCheque , "val", "id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("typeCheque").setLibelle("Type Chèque");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=<%=apres%>" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="listeId" type="hidden" id="nature" value="<%=listeId%>">
        <input name="acte" type="hidden" id="nature" value="<%=acte%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>