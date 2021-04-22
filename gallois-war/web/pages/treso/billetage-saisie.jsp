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
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = (user.UserEJB) session.getValue("u");
        Billetage billetage = new Billetage();
        DetailsBilletage billetageFille = new DetailsBilletage();
        
        PageInsertMultiple pi = new PageInsertMultiple(billetage, billetageFille, request, 1, u);
        pi.setLien((String) session.getValue("lien"));
        
        affichage.Champ[] liste = new affichage.Champ[1];
        
        TypeObjet esc = new TypeObjet();
        esc.setNomTable("CAISSE_PHYSIQUE");
        liste[0] = new Liste("caisse", esc, "VAL", "id");

        pi.getFormu().changerEnChamp(liste);
        
        pi.preparerDataFormu();
        
        pi.getFormu().getChamp("daty").setDefaut(""+new Utilitaire().dateDuJour());
        pi.getFormu().getChamp("montant").setVisible(false);
        pi.getFormufle().getChamp("idmere").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("daty").setLibelle("Date");
        
        String[] billets = {"20000", "10000", "5000", "2000", "1000", "500", "200","100","50","20","10","5","2","1"};
        int size = billets.length;
%>
<div class="content-wrapper">
    <h1>Saisie Billetage</h1>
    <form action="<%=pi.getLien()%>?but=apresInsertMultiple.jsp" method="post" name="attInscription" id="attInscription" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            //pi.getFormufle().makeHtmlInsertTableauIndex();
            //System.out.println(pi.getFormu().getHtmlTableauInsert());
            out.println(pi.getFormu().getHtmlInsert());
            //out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <div class="row">
            <div class="row col-md-12">
                <div class="box">
                    <div class="box box-primary">
                        <div class="box-body" id="tableauLigne">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <th style="background-color:#bed1dd">
                                            <label for="billet" tabindex="2">billet</label>
                                        </th>
                                        <th style="background-color:#bed1dd">
                                            <label for="nombre" tabindex="3">nombre</label>
                                        </th>
                                        <th style="background-color:#bed1dd">
                                            <label for="montant" tabindex="4">montant</label>
                                        </th>
                                    </tr>
                                <%
                                    for(int i=0;i<size;i++){ %>
                                        <tr>
                                            <td><input name="billet_<%= i %>" type="textbox" class="form-control" id="billet_<%= i %>" value="<%= billets[i] %>" readonly></td>
                                            <td><input name="nombre_<%= i %>" type="textbox" class="form-control" id="nombre_<%= i %>" onchange="afficherMontant('billet_<%= i %>','nombre_<%= i %>','montant_<%= i %>')"></td>
                                            <td><input name="montant_<%= i %>" type="textbox" class="form-control" id="montant_<%= i %>" readonly></td>
                                        </tr>
                                <%  }  %>
                                    <tr>
                                        <td></td>
                                        <td>TOTAL</td>
                                        <td ><input type="textbox" class="form-control" id="totalBillet" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>        
                    </div>
                </div>
            </div>
        </div>
        <input name="size" type="hidden" id="size" value="<%=size%>">
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="treso/billetage-saisie.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.Billetage">
        <input name="classefille" type="hidden" id="classefille" value="mg.spat.DetailsBilletage">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= size %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="idmere">
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
