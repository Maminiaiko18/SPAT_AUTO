<%@page import="facture.Recurrent"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    
    String  mapping = "facture.Recurrent",
            nomtable = "recurrent",
            titre = "Récurrent",
            bute = "facture/factureclient-fiche-vaovao.jsp",
            idFacture = request.getParameter("id") ;
    
    Recurrent objet = new Recurrent();
    objet.setNomTable(nomtable);
    
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet o = new TypeObjet();
        o.setNomTable("TYPEFREQUENCE");
        liste[0] = new Liste("typefrequence", o, "desce", "id");      
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("typefrequence").setLibelle("Type Fréquence");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=apresRecurrent.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="recurrent">
        <input name="id" type="hidden" id="nature" value="<%=idFacture%>">
        <input name="bute" type="hidden" id="nature" value="<%=bute%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>