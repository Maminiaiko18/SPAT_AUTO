<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="facture.FactureClientDetailsGrouper"%>
<%@page import="facture.FactureClient"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureClientDetailsGrouper cht = new FactureClientDetailsGrouper();
    //cht.setNomTable("facture_client_fille_gp");
    String libEntete[] = {"idRubrique","designationRubrique","quantite","pu","montant"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"Rubrique","Designation","Quantite","PU","Montant"};
    String lienTableau[] = {pr.getLien() + "?but=exploitants/rubrique-fiche.jsp"};
    
    String colonneLien[] = {"idRubrique"};
    String[] urlLienMultiple = {"idRubrique"};
    String[] urlLienAffiche = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);           
    pr.getTableau().setUrlLienAffiche(urlLienAffiche);
    pr.getTableau().setUrlLien(urlLienMultiple);
    
    
    FactureClientDetailsGrouper[] liste=(FactureClientDetailsGrouper[])pr.getTableau().getData();
    
    
    
    
    if(pr.getTableau().getHtml() != null)
    {%>
    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerFactureClient&id=<%=request.getParameter("id")%>" style="margin-right: 10px">Imprimer</a>

    <%    pr.getTableau().setLibeEntete(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
         double total=0;
        total=AdminGen.calculSommeDouble(liste,"montant");
%>
      

        
    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
