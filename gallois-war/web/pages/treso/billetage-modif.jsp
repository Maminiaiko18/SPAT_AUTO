<%-- 
    Document   : billetage-saisie
    Created on : 6 nov. 2019, 15:57:44
    Author     : john
--%>

<%@page import="mg.spat.Billetage"%>
<%@page import="mg.spat.DetailsBilletage"%>
<%@page import="mg.spat.Cloture"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        
        out.print("*********************************************************************************");
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = (user.UserEJB) session.getValue("u");
        Billetage billetage = new Billetage();
        DetailsBilletage billetageFille = new DetailsBilletage();
        billetageFille.setIdmere(request.getParameter("id"));
        DetailsBilletage[] liste = (DetailsBilletage[])CGenUtil.rechercher(billetageFille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(billetage, billetageFille, liste , request,(user.UserEJB) session.getValue("u") , 1);
        pi.setLien((String) session.getValue("lien"));
      
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
        
        for(int i = 0 ; i < pi.getFormufle().getNbLigne() ; i ++ )
        {
            pi.getFormufle().getChamp("idmere_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("id_"+i).setAutre("readonly");
        }
        
        pi.getFormufle().getChamp("id_0").setLibelle("Id");
        pi.getFormufle().getChamp("idmere_0").setLibelle("Id mere");
        pi.getFormufle().getChamp("billet_0").setLibelle("Billet BL");
        pi.getFormufle().getChamp("nombre_0").setLibelle("Nombre");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
        
        
        
        pi.preparerDataFormu();
        
        String buteLien = "treso/billetage-modif.jsp" , 
                classeMere = "mg.spat.Billetage" , 
                classeFille = "mg.spat.DetailsBilletage" , 
                colonneMereDansFille = "idmere" , 
             buteApresVisa = "facture/bondelivraison-client-fiche.jsp";   
        
        TypeObjet esc = new TypeObjet();
        esc.setNomTable("CAISSE_PHYSIQUE");
      
%>
<div class="content-wrapper">
    <h1>Modification Billetage</h1>
               <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">

        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
      

        
         <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <%
                    out.println(pi.getFormufle().getHtmlTableauInsert());
                %>
            </div>
        </div>
   
      
        <input name="acte" type="hidden" id="nature" value="updateInsert">
        <input name="bute" type="hidden" id="bute" value="<%= buteLien %>?id=<%=billetage.getId()%>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille %>">
    </form>
</div>
<script>
    
function afficherMontant(billet,quantite,montant) {
    var x = document.getElementById(billet).value;
    var y = document.getElementById(quantite).value;
    var result = x*y;
    document.getElementById(montant).value =  result;
    var size=document.getElementById('size').value;
    var total=0;
    for(i=0;i<size;i++){
        montant=document.getElementById('montant_'+i).value;
        if(montant === null || montant===""){
            montant=0;
        }
        total+=parseInt(montant);
    }
    document.getElementById('totalBillet').value =  total;
}
</script>
<%}catch(Exception e){
    e.printStackTrace();
}%>
