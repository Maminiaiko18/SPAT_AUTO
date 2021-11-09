<%@page import="facture.PaiementFacture"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PaiementFacture cht = new PaiementFacture();
    cht.setNomTable("paiementfactureF");
    String libEntete[] = {"id", "idfact", "montant"};
    String listeCrt[] = {"idmvt"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.setApres("treso/inc/ventilation-ff.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"Id", "Facture", "Montant"};
    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
    String colonneLien[] = {"idfact"};
    String urlLien[] = {"idfact"};
    String urlLienAff[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setUrlLien(urlLien);
    pr.getTableau().setUrlLienAffiche(urlLienAff);
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);    
    if(pr.getTableau().getHtml() != null)
    {
        out.println(pr.getTableau().getHtml());
      

        double totalMontant=AdminGen.calculSommeDouble(pr.getTableau().getData(),"montant");
%>   
    <table class="table table-striped table-bordered table-condensed table-responsive tree" >
        <tr>
            <th align="right"></th>
            <th width="14%">Montant total</th>
        </tr>
        <tr>
            <td align="right"></td>
            <td align="right"><%=Utilitaire.formaterAr(totalMontant)%></td>
        </tr>
    </table>

    <% }else{
        %><center><h4>Aucun résultat </h4></center><%
    }
%>

