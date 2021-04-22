<%-- 
    Document   : etat-caisse-global
    Created on : 12 janv. 2021, 11:41:53
    Author     : Sanda
--%>

<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@page import="mg.spat.placement.Placement"%>
<%@page import="service.SpatService"%>
<%@page import="service.EtatCaisseService"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.UserEJB"%>
<%@page import="mg.spat.EtatCaisse"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.Date"%>
<%@page import="datas.JournalDatas"%>
<%@page import="java.util.HashMap"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="bean.CGenUtil"%>

<%
    try {

        UserEJB u = (UserEJB) session.getAttribute("u");
        TypeObjet to = u.getCaisse();
        String datyString = request.getParameter("daty");
        String caisse = request.getParameter("caisse");
        Date daty = Utilitaire.dateDuJourSql();
        if (caisse == null || caisse.compareTo("") == 0) {
            caisse = to.getId();
        }
        if (datyString != null && datyString.compareTo("") != 0) {
            daty = Utilitaire.stringDate(datyString);
        } else {
            datyString = Utilitaire.dateDuJour();
        }
        EtatCaisse ec = new EtatCaisse(caisse, daty);
        EtatCaisseService ecS = new EtatCaisseService();
        ecS.genererEtatCaisseData(ec);
        double montantCaisse = ecS.getRecette(caisse, daty,null);
        Caisse[] caisses = ecS.getCaisses();
        JournalCaisse[] debits = ec.getDebits();
//        JournalCaisse[] credits = ec.getCredits();
        PlacementLibComplet[] placement = ec.getListePlacement();
        
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Etat de caisse</h1>
    </section>
    <section class="content">
        <form action="globalnegoce.jsp?but=treso/etat-caisse-global.jsp" method="post" name="listebilletage" id="listebilletage">
            <div class='row'>
                <div class='row col-md-12'>
                    <div class='box box-solid collapsed collapsed-box'>
                        <div style='background:#3c2517; color:white;'class='box-header with-border'>
                            <h3 class='box-title' color='#edb031'><span color='#edb031'>Recherche avanc&eacute;e</span></h3>
                            <div class='box-tools pull-right'>
                                <button data-original-title='Collapse' class='btn btn-box-tool' data-widget='collapse' data-toggle='tooltip' title=''><i class='fa fa-plus'></i></button> </div>
                        </div>
                        <div class='box-body' id='pagerecherche'>
                            <div class='form-group'>
                                <div class='col-md-4'>
                                    <label for=Date min>Date</label>
                                    <input name=daty type=text class='form-control datepicker' value="<%=datyString%>" id=daty  onkeydown='return searchKeyPress(event)'>
                                </div>
                                <div class='col-md-4'>
                                    <label for="caisse">Caisse</label>
                                    <select name="caisse" class="form-control" id="caisse">
                                        <%for (int i = 0; i < caisses.length; i++) {%>
                                        <option value="<%=caisses[i].getId()%>" <%=caisses[i].getId().equalsIgnoreCase(caisse) ? "selected" : ""%>><%=caisses[i].getVal()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class='col-xs-6' align='right'>
                                <button type='submit' class='btn' style='background:#3c2517; color:white' id='btnListe'>Afficher</button>
                            </div>
                            <div class='col-xs-6' align='left'>
                                <button type='reset' class='btn btn-default'>R&eacute;initialiser</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>

    <div class="row">
        <div class="col-md-12">
            <div class="box-body">
                <div class="box">
                    <center>
                        <h3 class="box-title" id="titre-export" align="center">
                            <b>SOCIETE DU PORT A GESTION AUTONOME DE TOAMASINA</b>
                        </h3>
                    </center>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row">
            <div class="col-md-8">
                <center>
                    <h4 class="box-title" id="titre-export" align="center">
                        <b>JOURNAL DE CAISSE</b>
                    </h4>
                </center>
            </div>
            <div class="col-md-4">
                <div class="row">FOLIO N° <%=Utilitaire.champNull(ec.getFolio())%></div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8">
                <center>
                    <h4 class="box-title" id="titre-export" align="center">
                        <b>CAISSE DEPENSE</b>
                    </h4>
                </center>
            </div>
            <div class="col-md-4">
                <div class="row">JOURNEE DU <%= Utilitaire.format(ec.getDaty()) %></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="box-body">
                <div class="box">
                    <div id="table-container">
                        <table border="1" width="100%" style="border-collapse: collapse;">
                            <tr>
                                <th colspan=1 width="10%" style="text-align: center;" align="center">NUM PIECE</th>
                                <th colspan=1 width="40%" style="text-align: center;" align="center">LIBELLE</th>
                                <th colspan=1 width="25%" style="text-align: center;" align="center">DEBIT</th>
                                <th colspan=1 width="25%" style="text-align: center;" align="center">CREDIT</th>
                            </tr>
                            <%
                                for (JournalCaisse jc : debits) {
                            %>
                            <tr style="border-bottom: 0px solid #ccc;">
                                <td colspan=1 align="center"><%=Utilitaire.champNull(jc.getNumPiece())%></td>
                                <td colspan=1 > <%=Utilitaire.champNull(jc.getLibelle())%></td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterArOrNull(jc.getDebit())%> </td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterArOrNull(jc.getCredit())%> </td>
                            </tr>
                            <% } %>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;" >Recette de la caisse SPAT Journ&eacute;e du <%=datyString%></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;" align="right"><%= Utilitaire.formaterAr(montantCaisse)%></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                            </tr>
                            
                            <tr style="border-top: 1px solid  ;" >
                                <td colspan=1></td>
                                <td colspan=1 align="center"><b> Total </b></td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterAr(ec.getTotalDebitJournal())%> </td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterAr(ec.getTotalCreditJournal())%> </td>
                            </tr>

                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> 1 - REPORTS </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                            </tr>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> 2 - SOLDE ANTERIEUR </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;text-align: right;"><%=Utilitaire.formaterAr(ec.getSoldeAnterieur())%></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                            </tr>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> 3 - SOLDE ACTUEL </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;text-align: right;"><%=Utilitaire.formaterAr(ec.getSoldeActuel())%></td>
                            </tr>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> 4 - CUMULS </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                            </tr>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> 5 - BON PROVISOIRE </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;" align="right"><%=Utilitaire.formaterAr(ec.getBonProvisoire())%></td>
                            </tr>

                            <tr style="border-bottom: 1px solid  ;">
                                <td colspan=1></td>
                                <td colspan=1 align="center"> <b>Somme </b></td>
                                <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(ec.getTotalDebit())%> </b></td>
                                <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(ec.getTotalCredit())%> </b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        if (placement != null && placement.length != 0) {
    %>                   
    <div class="row">
        <div class="col-md-12">
            <div class="box-body">
                <div class="box">
                    <div id="table-container">
                        <table border="1" width="100%" style="border-collapse: collapse;">
                            <tr>
                                <th colspan=1 width="10%" style="text-align: center;" align="center">ENTITE</th>
                                <th colspan=1 width="40%" style="text-align: center;" align="center">MONTANT</th>
                            </tr>
                            <%
                                for (PlacementLibComplet pl : placement) {
                            %>
                            <tr style="border-bottom: 0px solid #ccc;">
                                <td colspan=1 ><%=pl.getValentite() + " " + Utilitaire.champNull(pl.getValbanque())%></td>
                                <td colspan=1 style="text-align: right"> <%=Utilitaire.formaterAr(pl.getMontant())%></td>
                            </tr>
                            <% } %>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% }%>
    <br/>
    <div class="row">
        <div class="row">
            <div class="col-md-8">
                <center>
                    <h4 class="box-title" id="titre-export" align="center">
                        <b>JOURNAL DE CAISSE</b>
                    </h4>
                </center>
            </div>
            <!--            <div class="col-md-4">
                            <div class="row">FOLIO N° <%=Utilitaire.champNull(ec.getFolio())%></div>
                        </div>-->
        </div>
        <div class="row">
            <div class="col-md-8">
                <center>
                    <h4 class="box-title" id="titre-export" align="center">
                        <b>COFFRE BMOI</b>
                    </h4>
                </center>
            </div>
            <div class="col-md-4">
                <div class="row">JOURNEE DU <%= Utilitaire.format(ec.getDaty()) %></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="box-body">
                <div class="box">
                    <div id="table-container">
                        <table border="1" width="100%" style="border-collapse: collapse;">
                            <tr>
                                <th colspan=1 width="10%" style="text-align: center;" align="center">NUM PIECE</th>
                                <th colspan=1 width="40%" style="text-align: center;" align="center">LIBELLE</th>
                                <th colspan=1 width="25%" style="text-align: center;" align="center">DEBIT</th>
                                <th colspan=1 width="25%" style="text-align: center;" align="center">CREDIT</th>
                            </tr>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> Espèce en coffre BMOI </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                            </tr>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> Entrée coffre BMOI </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;text-align: right;"><%=Utilitaire.formaterAr(0)%></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                            </tr>
                            <tr style="border-bottom: 0px solid #ccc">
                                <td style="border-bottom: 0px solid #fff"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"> Sortie coffre BMOI </td>
                                <td colspan=1 style="border-top: 0px solid #000 ;"></td>
                                <td colspan=1 style="border-top: 0px solid #000 ;text-align: right;"><%=Utilitaire.formaterAr(0)%></td>
                            </tr>
                            <tr style="border-bottom: 1px solid  ;">
                                <td colspan="2" align="right"> <b>TOTAL </b></td>
                                <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(0)%> </b></td>
                                <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(0)%> </b></td>
                            </tr>
                            <tr style="border-bottom: 1px solid  ;">
                                <td colspan=3 align="center"> <b>COFFRE BMOI </b></td>
                                <td align="right"><b><%=Utilitaire.formaterAr(0)%> </b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
         <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=journalCaisseDepense&caisse=<%=caisse%>&daty=<%=datyString%>" style="margin-right: 10px">Imprimer Journal de caisse</a>
    </div>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();
</script>
<%
        return;
    }
%>
