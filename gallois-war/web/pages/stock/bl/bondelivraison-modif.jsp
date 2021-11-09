<%-- 
    Document   : bondelivraison-modif
    Created on : 25 nov. 2020, 17:50:25
    Author     : ASUS
--%>


<%@page import="bean.CGenUtil"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<%@page import="mg.spat.stock.BonDeLivraisonFille"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BonDeLivraison cmd = new BonDeLivraison();
	
    PageUpdate pi = new PageUpdate(cmd, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    
//    affichage.Champ[] liste = new affichage.Champ[1];
//    TypeObjet depo = new TypeObjet();
//    depo.setNomTable("point");
//    liste[0] = new Liste("point", depo, "val", "id");
//    
//    pi.getFormu().changerEnChamp(liste);
//    
    pi.getFormu().getChamp("point").setVisible(false);
    pi.getFormu().getChamp("remarque").setLibelle("Numero BL");
    pi.getFormu().getChamp("id_bc").setLibelle("N° Bon de commande");
    pi.getFormu().getChamp("id_bc").setAutre("readonly");

    pi.getFormu().getChamp("idbc").setVisible(false);

//    POPUP BON DE COMMANDE
//     pi.getFormu().getChamp("idbc").setAutre("readonly");
//      pi.getFormu().getChamp("idbc").setPageAppel("choix/listeFactureFournisseurChoix.jsp");
	pi.getFormu().getChamp("etat").setVisible(false);
	pi.preparerDataFormu();
%>
<div class="content-wrapper">
    
    <form action="<%=pi.getLien()%>?but=stock/bl/apresBL.jsp" method="post" name="bondelivraison" id="bondelivraison" data-parsley-validate>
       
            <div class="col-md-6 col-md-offset-3">
                <div class="">       
                    <h1 class="box-title">Modification bon de livraison</h1>
<!--                    <div class="box-body">-->
                        <%
                            pi.getFormu().makeHtmlInsertCommande();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                    <!--</div>-->
                </div>
            </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="box-content">
                    <div class="box">
                        <div class="box-title with-border">
                            <h1 class="box-title">D&eacute;tails</h1>
                        </div>
                        <div class="box-body">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th style="background-color:#bed1dd">ID</th>
                                        <th style="background-color:#bed1dd">Libelle</th>
                                        <th style="background-color:#bed1dd">Quantite</th>
                                    </tr></thead>
                                <tbody>
                                    <%
                                        BonDeLivraisonFille p = new BonDeLivraisonFille();      
                                        p.setNomTable("as_bondelivraison_fille");
                                        BonDeLivraisonFille[] listef = (BonDeLivraisonFille[]) CGenUtil.rechercher(p, null, null, " and NUMBL='"+request.getParameter("id").trim()+"'");
                                    %>
                                        <input type="hidden" class="form form-control" name="nb" id="nb" value="<%=listef.length%>">
                                    <%        
                                        if(listef.length > 0 && listef != null){
                                            for (int i = 0; i < listef.length; i++) {
                                    %>
                               
                                <tr>
                                    <td><input type="hidden" class="form form-control" name="idFille" id="idFille<%=i%>" value="<%=listef[i].getId()%>"><%=listef[i].getId()%></td>
                                    <td><%=listef[i].getProduit()%></td>
                                    <td><input type="text" class="form form-control" name="quantite" id="quantite<%=i%>" value="<%=listef[i].getQuantite()%>"></td>
                                </tr>
                                <%
                                        }
                                    }else{   
                                %>
                                <tr>
                                    <td colspan="4" class="text-center bold"> Aucune données </td>
                                </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                                
        <input name="acte" type="hidden" id="nature" value="updateBL">
        <input name="bute" type="hidden" id="bute" value="stock/bl/bondelivraison-fiche.jsp?id=<%= request.getParameter("id") %>">
        <input name="classe" type="hidden" id="classe" value="mg.spat.stock.BonDeLivraison">
        <button type="submit" name="Submit2" class="btn btn-success pull-right" style="margin-right: 25px;">Enregistrer</button>
        <button type="reset" name="Submit2" class="btn btn-default pull-right" style="margin-right: 15px;">R&eacute;initialiser</button>
    </form>
</div>