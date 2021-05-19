<%-- 
    Document   : bondelivraison
    Created on : 19 mai 2021, 09:21:00
    Author     : nyamp
--%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    BonDeLivraison cht = new BonDeLivraison();
    cht.setNomTable("AS_BONDELIVRAISON_CL_LIBELLE");
    String libEntete[] = {"id", "remarque", "daty","etatlib"};
    String listeCrt[] = {"idbc"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    pr.creerObjetPage(libEntete);
    String libEnteteAffiche[] = {"id", "remarque", "date","etat"};
    String lienTableau[] = {pr.getLien() + "?but=facture/bondelivraison-client-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    pr.getTableau().setNameActe("valider");
   String html=pr.getTableau().getHtmlWithCheckbox();
    if(html != null){ %>
     <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" method="post" name="id" id="id">
         <input type="hidden" name="bute" value="facture/factureclient-fiche-vaovao.jsp&id=<%=request.getParameter("idbc")%>"/>
            <input type="hidden" name="classe" value="mg.spat.stock.BonDeLivraisonClient"/>
            <input type="hidden" name="acte" value="valider"/>
            <% out.println(html); %>
     </form>
    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
