<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.JournalCaisseBordereauPaie"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JournalCaisseBordereauPaie cht = new JournalCaisseBordereauPaie();
    cht.setNomTable("JOURNALCAISSE_BORDEREAUPAIE");
    String libEntete[] = {"numFact", "montant"};
    String listeCrt[] = {"id"};
    String listeInt[] = {};
    String id=request.getParameter("id");

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 2, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.setApres("treso/inc/bordereau-p.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"N°Facture", "Montant"};
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

