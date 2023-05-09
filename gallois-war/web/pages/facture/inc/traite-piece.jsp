<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.AdminGen"%>
<%@page import="avoir.Avoir"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JournalCaisse cht = new JournalCaisse();
    cht.setNomTable("TRAITE_JC");
    String libEntete[] = {"id","numpiece","libelle", "debit", "credit", "iddevise", "montant","datesaisie","etatlib","etatversementlib"};
    String listeCrt[] = {};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.setApres("facture/inc/jc-liste.jsp");
    String[] colSomme = {"montant"};
    if(request.getParameter("id") != null){
        pr.setAWhere(" and idtraite = '"+request.getParameter("id")+"' and etatversement = 0 and credit > 0");
    }
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id","Numero Piece","Libelle", "Debit", "Credit", "Devise", "Montant","Date de saisie", "Etat", "Etat versement"};
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    if(pr.getTableau().getHtml() != null){
        JournalCaisse[] liste=(JournalCaisse[]) pr.getTableau().getData();
        out.println(pr.getTableau().getHtml());
        double total=0;
        total=AdminGen.calculSommeDouble(liste,"montant");

%>
        
        <table class="table table-striped table-bordered table-condensed table-responsive tree" >
            <tr>
                <td colspan="5"></td>
                <th width="20%" align="right">Montant total</th>
                <td width="20%" align="right"><%=Utilitaire.formaterAr(total)%> Ar</td>
            </tr>
        </table>
    <% }else{
        %><center><h4>Aucun Journal Caisse</h4></center><%
    }
%>
