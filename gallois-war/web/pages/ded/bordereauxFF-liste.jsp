<%-- 
    Document   : borderaux-liste
    Created on : 21 janv. 2021, 09:51:38
    Author     : ACER
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="bordereau.Bordereau"%>
<%@page import="bordereau.BordereauFF"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilisateur.*"%>
<% 
    BordereauFF bordereaux = new BordereauFF();
    bordereaux.setNomTable("BORDEREAUFF_LIB_MONTANT");
    UserEJB u = (user.UserEJB) session.getValue("u");
    Prioritaire prioritaire = new Prioritaire();
    String aWhere = prioritaire.makeListConfidentiality(u,"directionlib");

        System.out.println("aWhere "+aWhere);
    
    if(request.getParameter("etatvue")!=null && request.getParameter("etatvue").length()>0){
        bordereaux.setNomTable(request.getParameter("etatvue"));
    }
    
    String libEntete[] = {"id", "daty","projetlib","directionlib","numfsb","numero","designation","tiers","montant"};
    String listeCrt[] = {"id","designation","typebordereau","numfsb","projetlib","directionlib", "daty","tiers","numero"};
    String listeInt[] = {"daty"};
    PageRecherche pr = new PageRecherche(bordereaux, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ded/bordereauxFF-liste.jsp");
    
    affichage.Liste[] listes= new affichage.Liste[1];
        
    TypeObjet type = new TypeObjet();
    type.setNomTable("TYPEBORDEREAU");
    listes[0] = new Liste("typebordereau", type, "VAL", "id");
    
    pr.getFormu().changerEnChamp(listes);
    pr.getFormu().getChamp("typebordereau").setLibelle("Type Bordereau");
    pr.getFormu().getChamp("daty1").setLibelle("date de début");
    pr.getFormu().getChamp("daty2").setLibelle("date fin");
    pr.getFormu().getChamp("numfsb").setLibelle("Num FSB");
    pr.getFormu().getChamp("projetlib").setLibelle("projet");
    pr.getFormu().getChamp("directionlib").setLibelle("direction");
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
    pr.setAWhere(aWhere);

    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete, colSomme);
%>

<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste bordereaux facture fournisseur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ded/bordereauxFF-liste.jsp" method="post" name="travaux" id="travaux">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div> <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="BORDEREAUFF_LIB_MONTANT" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("BORDEREAUFF_LIB_MONTANT")==0) {
                                out.print(" selected");
                            }%>>Tous</option>
                        <option value="BORDEREAUFF_LIB_MONTANTV" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("BORDEREAUFF_LIB_MONTANTC") == 0) {
                                out.print("selected");
                            }%>>Engag&eacute;(s)</option>
                        <option value="BORDEREAUFF_LIB_MONTANTC" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("BORDEREAUFF_LIB_MONTANTV") == 0) {
                                out.print("selected");
                            }%>>Non engag&eacute;(s)</option>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
            </div>
        </form>
            <%
                String lienTableau[] = {pr.getLien() + "?but=ded/bordereauxFF-fiche.jsp"};
                String colonneLien[] = {"id"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setColonneLien(colonneLien);
                out.println(pr.getTableauRecap().getHtml());
            %>
            <br>
            <%
                String libEnteteAffiche[] = {"id", "Date","Type Bordereau","projet","direction","Num FSB","num&eacute;ro","Désignation","Tiers","Montant"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                out.println(pr.getTableau().getHtml());
                out.println(pr.getBasPage());
            %>
    </section>
</div>