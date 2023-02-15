<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.PaiementFacture"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PaiementFacture cht = new PaiementFacture();
    cht.setNomTable("PAIEMENTFACTUREBPCPL");
    String libEntete[] = {"id","idmvt","daty","designation","montant","numfact"};
    String listeCrt[] = {"idfact"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.setApres("facture/inc/etatprovision.jsp");
    String[] colSomme = {};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id","MOUVEMENT","DATE","DESIGNATION","MONTANT","NUMFACT"};
    pr.getTableau().setLibeEntete(libEnteteAffiche);    
    if(pr.getTableau().getHtml() != null)
    {
        out.println(pr.getTableau().getHtml());
        PaiementFacture[] liste=(PaiementFacture[])pr.getTableau().getData();

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
%>

