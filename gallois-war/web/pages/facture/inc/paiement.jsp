<%-- 
    Document   : paiement
    Created on : 26 mai 2021, 08:56:48
    Author     : nyamp
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    JournalCaisseLibComplet cht = new JournalCaisseLibComplet();
    cht.setNomTable("paiementFC_tous");
    String libEntete[] = {"id", "libelle", "valcaisse","tierslib","numPiece","dateeffet", "montant","sortie","etatlib"};
    String listeCrt[] = {"idfact","etat"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"credit","debit"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "Libelle", "Caisse","tiers","Num piece","Date", "Entree","Sortie","Etat"};
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche); 
    %>
<script>
    function changerDesignation() {
        var select = document.getElementById('etatFC');
        var option = select.options[select.selectedIndex];
        document.getElementById('etatFC').value = null;
        if(option.value!=="Tous"){
            document.getElementById('etatFC').value = option.value;
        }
        document.incident.submit();
    }
</script>
    <form action="<%=pr.getLien()%>?but=facture/factureclient-fiche-vaovao.jsp&id=<%=request.getParameter("idfact")%>&idfact=<%=request.getParameter("idfact")%>&tab=paiement" method="post" name="incident" id="incident">
        <label>Etat:</label>
        <select name="etat" id="etatFC" onchange="changerDesignation()">
            <option <%if (request.getParameter("etat") == null || request.getParameter("etat").isEmpty() == true) {out.print("selected");}%>>Tous</option>
            <option <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase(String.valueOf(ConstanteEtat.getEtatCreer())) == 0) {out.print(" selected");}%> value="<%=ConstanteEtat.getEtatCreer()%>" >Creee</option>
            <option <%if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase(String.valueOf(ConstanteEtat.getEtatValider())) == 0) {out.print("selected");}%> value="<%=ConstanteEtat.getEtatValider()%>">Visee</option>
        </select>
    </form>
    <%
    if(pr.getTableau().getHtml() != null)
    {
        out.println(pr.getTableau().getHtml());
        JournalCaisseLibComplet[] liste=(JournalCaisseLibComplet[])pr.getTableau().getData();

        double totalCredit=AdminGen.calculSommeDouble(liste,"montant");
%>   
    <table class="table table-striped table-bordered table-condensed table-responsive tree" >
        <tr>
            <th align="right"></th>
            <th width="14%">TOTAL</th>
        </tr>
        <tr>
            <td align="right"></td>
            <td align="right"><%=Utilitaire.formaterAr(totalCredit)%></td>
        </tr>
    </table>

    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
}catch(Exception e){
    e.printStackTrace();
}%>
