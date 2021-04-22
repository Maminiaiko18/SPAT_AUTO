<%-- 
    Document   : transfert-caisse
    Created on : 16 janv. 2021, 00:42:39
    Author     : Sanda
--%>

<%@page import="mg.spat.MvttIntraCaisse"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "mg.spat.MvttIntraCaisse",
            nomtable = "mvtintracaisse",
            apres = "treso/transfert-caisse-fiche.jsp",
            titre = "Transfert Caisse";
    
    MvttIntraCaisse  objet = new MvttIntraCaisse();
    objet.setNomTable(nomtable);
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    
    affichage.Champ[] liste = new affichage.Champ[3];
    Caisse liste1 = new Caisse();
    liste1.setNomTable("caisse");
    liste[0] = new Liste("caissedepart", liste1, "val", "id");
    liste[1] = new Liste("caissearrivee", liste1, "val", "id");
    TypeObjet liste2 = new TypeObjet();
    liste2.setNomTable("MODEPAIEMENT");
    liste[2] = new Liste("modepaiement", liste2, "val", "id");     
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("remarque").setLibelle("Numéro chèque");
    pi.getFormu().getChamp("caissedepart").setLibelle("Départ");
    pi.getFormu().getChamp("caissearrivee").setLibelle("Arrivée");
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
            
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
