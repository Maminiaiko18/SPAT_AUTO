<%@page import="utilitaire.Utilitaire"%>
<%@page import="avoir.AvoirFCLibComplet"%>
<%@page import="bean.AdminGen"%>
<%@page import="avoir.Avoir"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    AvoirFCLibComplet cht = new AvoirFCLibComplet();
    cht.setNomTable("AVOIRFC_MONTANTLIBETAT");
    String libEntete[] = {"id", "code", "daty", "tierslib", "montantttc", "montantpaye", "montantreste", "etatlib"};
    String listeCrt[] = {"idfacture"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"montant"};
    if(request.getParameter("idfacture") != null){
        pr.setAWhere(" and idfacture = '"+request.getParameter("idfacture")+"' ");
    }
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "Code", "Date", "Client","Montant TTC", "Montant paye", "Montant reste", "Etat"};
    String lienTableau[] = {pr.getLien() + "?but=avoir/avoirFC-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    AvoirFCLibComplet[] liste=(AvoirFCLibComplet[]) pr.getTableau().getData();
    if(pr.getTableau().getHtml() != null){
        out.println(pr.getTableau().getHtml());
        double total=0;
        total=AdminGen.calculSommeDouble(liste,"montantttc");

%>
        
        <table class="table table-striped table-bordered table-condensed table-responsive tree" >
            <tr>
                <td colspan="5"></td>
                <th width="20%" align="right">Montant total</th>
                <td width="20%" align="right"><%=Utilitaire.formaterAr(total)%> Ar</td>
            </tr>
        </table>
    <% }else{
        %><center><h4>Aucun Avoir</h4></center><%
    }
%>
