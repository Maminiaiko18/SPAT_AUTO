<%-- 
    Document   : asBonDeLivraison-direct
    Created on : 1 déc. 2020, 09:44:52
    Author     : Finaritra 
--%>


<%@page import="bean.CGenUtil"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BonDeLivraison cmd = new BonDeLivraison();
    String idbc = request.getParameter("idbc");

    PageInsert pi = new PageInsert(cmd, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    if (request.getParameter("id_bc") != null) {
        idbc = request.getParameter("id_bc");
        pi.getFormu().getChamp("id_bc").setLibelle("N° Bon de commande");
        pi.getFormu().getChamp("id_bc").setAutre("readonly");
        pi.getFormu().getChamp("idbc").setVisible(false);
    }else{
        pi.getFormu().getChamp("idbc").setAutre("readonly");
        pi.getFormu().getChamp("id_bc").setVisible(false);
    }
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("remarque").setLibelle("numero BL");
    pi.getFormu().getChamp("idbc").setLibelle("N° Bon de commande");
    pi.getFormu().getChamp("idbc").setDefaut(idbc);
    pi.getFormu().getChamp("id_bc").setDefaut(idbc);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("point").setVisible(false);

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="col-md-12">
        <h1>Enregistrer bon de livraison</h1>
        <form action="<%=pi.getLien()%>?but=stock/bl/apresBL.jsp" method="post" name="bondelivraison" id="bondecommande" data-parsley-validate>
            <%
                pi.getFormu().makeHtmlInsertCommande();
                out.println(pi.getFormu().getHtmlInsert());
            %>
            <div class="row">
                    <div class="box-content">
                        <div class="box">
                            <div class="box-title with-border">
                                <h1 class="box-title">D&eacute;tails</h1>
                            </div>
                            <div class="box-body">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th style="background-color:#bed1dd">ID Bon de commande</th>
                                            <th style="background-color:#bed1dd">Produit</th>
                                            <th style="background-color:#bed1dd">Quantité</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            BonDeCommandeFille p = new BonDeCommandeFille();
                                            p.setNomTable("BC_BL_LIVRE");
                                            BonDeCommandeFille[] listef = (BonDeCommandeFille[]) CGenUtil.rechercher(p, null, null, " and idbc='" + idbc + "'");
                                            for (int i = 0; i < listef.length; i++) {
                                        %>
                                    <input type="hidden" class="form form-control" name="nb" id="nb" value="<%=listef.length%>">
                                    <tr>
                                        <td><input type="hidden" class="form form-control" name="id" id="id<%=i%>" value="<%=listef[i].getId()%>"><%=listef[i].getId()%></td>
                                        <td><input type="hidden" class="form form-control" name="produit" id="produit<%=i%>" value="<%=listef[i].getProduit()%>"><%=listef[i].getProduit()%></td>
                                        <td><input type="text" class="form form-control" name="quantite" id="quantite<%=i%>" value="<%=listef[i].getQuantitereste()%>"></td>
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

            <input name="acte" type="hidden" id="nature" value="insertBLDirect">
            <input name="bute" type="hidden" id="bute" value="stock/bl/bondelivraison-fiche.jsp">
            <input name="classe" type="hidden" id="classe" value="mg.spat.stock.BonDeLivraison">
            <button type="submit" name="Submit2" class="btn btn-success pull-right" style="margin-right: 25px;">Enregistrer</button>
            <button type="reset" name="Submit2" class="btn btn-default pull-right" style="margin-right: 15px;">R&eacute;initialiser</button>
        </form>
    </div>
    
</div>