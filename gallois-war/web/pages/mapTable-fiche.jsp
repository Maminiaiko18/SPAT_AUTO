<%@page import="mg.cnaps.compta.ComptaSousEcriture"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.st.*" %>
<%!
    ClassMAPTable objet;
%>
<%
    String classe = request.getParameter("classe");
    objet = (ClassMAPTable) (Class.forName(classe).newInstance());
    PageConsulte pc = new PageConsulte(objet, request, (user.UserEJB) session.getValue("u"));
    ComptaSousEcriture[] sousecritureliste=null;
     double montantDebit = 0, montantCredit = 0;
    if (classe.compareToIgnoreCase("mg.cnaps.compta.ComptaEcriture") == 0) {
         UserEJB u = (UserEJB) session.getAttribute("u");
        String ligneEcritureId = " AND MERE = '" + request.getParameter("id") + "' order by debit desc";
        ComptaSousEcriture sousecriture = new ComptaSousEcriture();
        sousecritureliste = (ComptaSousEcriture[]) u.getData(sousecriture, null, null, null, ligneEcritureId);
    }
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">Details</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%if(sousecritureliste!=null){%>
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">Détails</h1>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>Compte</th>
                                <!--<th>Compte tiers</th>-->
                                <th>Débit</th>
                                <th>Crédit</th>
                                <th>Designation</th>
                                
                            </tr>
                            <%for (int i = 0; i < sousecritureliste.length; i++) {
                                if(sousecritureliste[i].getCompte()!=null && sousecritureliste[i].getCompte().compareTo("")!=0){
                                    montantDebit = montantDebit + sousecritureliste[i].getDebit();
                                    montantCredit = montantCredit + sousecritureliste[i].getCredit();
                            %>
                            <tr>
                                <td align="left"><%=sousecritureliste[i].getCompte()%></td>
                                <!--<td><%=Utilitaire.champNull(sousecritureliste[i].getCompte_aux())%></td>-->
                                <td align="right"><%=Utilitaire.formaterSansVirgule(sousecritureliste[i].getDebit())%></td>
                                <td align="right"><%=Utilitaire.formaterSansVirgule(sousecritureliste[i].getCredit())%></td>
                                <td><%=Utilitaire.champNull(sousecritureliste[i].getRemarque())%></td>
                                
                            </tr>
                            <% }} %>
                            <tr>
                                <td ><b>TOTAL</b></td>
                                <td align="right"><b><%= Utilitaire.formaterAr(montantDebit) %></b></td>
                                <td align="right"><b><%= Utilitaire.formaterAr(montantCredit) %></b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%}%>
</div>
