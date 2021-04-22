<%-- 
    Document   : depense-liste
    Created on : 14 janv. 2021, 15:31:09
    Author     : Lenovo
--%>

<%@page import="mg.spat.JournalCaisseMivadika"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    JournalCaisseMivadika jc = new JournalCaisseMivadika();
    jc.setNomTable("JOURNALCAISSELIBmiv");
    
    if (request.getParameter("etatvue") != null) {
        jc.setNomTable(request.getParameter("etatvue"));
    }
 
    String listeCrt[] = {"id","folio","caisse","numPiece","dateSaisie","dateEffet"};
    String listeInt[] = {"dateSaisie","dateEffet"};
    String libEntete[] =  {"id","libelle","tierslib","folio","caisse","entree","numcheque","dateSaisie","dateEffet"};
    PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("treso/recette-liste.jsp");
    
    String where = " and credit = 0 ";
    pr.setAWhere(where);
    
    
     if(request.getParameter("caisse")!=null){
        String caisse = request.getParameter("caisse");
        pr.setApres(pr.getApres()+"&caisse="+caisse);
        pr.setAWhere(" and credit = 0 and caisse ='"+caisse+"'");
    }
    
    if(request.getParameter("etat")!=null){
        String etat = request.getParameter("etat");
        pr.setApres(pr.getApres()+"&etat="+etat);
        pr.setAWhere(pr.getAWhere()+" and etat="+etat);
    }

    pr.getFormu().getChamp("dateSaisie1").setLibelle("date de Saisie debut");
    pr.getFormu().getChamp("dateSaisie2").setLibelle("date de Saisie fin");
    pr.getFormu().getChamp("dateEffet1").setLibelle("date Effet");
    pr.getFormu().getChamp("dateEffet2").setLibelle("date Effet");
    

  
    String[] colSomme = {"entree"};
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Recettes </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/recette-liste.jsp" method="post" name="listepostedestinataire" id="listepostedestinataire">
            <% if(request.getParameter("caisse")!=null) { %>
                <input type="hidden" name="caisse" value="<%= request.getParameter("caisse")%>"/>
            <% } %> 
            <% if(request.getParameter("etat")!=null) { %>
                <input type="hidden" name="etat" value="<%= request.getParameter("etat")%>"/>
            <% } %> 
            <% if(request.getParameter("dateEffet1")!=null) { %>
                <input type="hidden" name="dateEffet1" value="<%= request.getParameter("dateEffet1")%>"/>
                <input type="hidden" name="dateEffet2" value="<%= request.getParameter("dateEffet2")%>"/>
            <% } %> 
            
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="JOURNALCAISSELIBmiv" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIBmiv") == 0) {
                                out.print("selected");
                            }%>>Tous</option>
                        <option value="JOURNALCAISSELIB_CREE_miv" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_CREE_miv") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;e</option>
                        <option value="JOURNALCAISSELIB_vise_miv" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_vise_miv") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;</option>

                        
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/recette-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%                                  
            String libEnteteAffiche[] = {"id","libelle","tiers","folio","caisse","Entrée","Numero Chèque","date de Saisie","date Effet"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>