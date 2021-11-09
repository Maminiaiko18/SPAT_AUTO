<%-- 
    Document   : depense-liste
    Created on : 14 janv. 2021, 15:31:09
    Author     : Lenovo
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.JournalCaisseMivadika"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    JournalCaisse jc = new JournalCaisse();
    jc.setNomTable("journalcaisselibrecette");
    
    if (request.getParameter("etatvue") != null) {
        jc.setNomTable(request.getParameter("etatvue"));
    }
 
    String listeCrt[] = {"id","folio", "valcaisse", "libelle", "remarque", "dateEffet","idtypecheque","idplacement"};
    String listeInt[] = {"dateEffet"};
    String libEntete[] =  {"id", "folio", "valcaisse","idtypecheque", "numPiece", "numcheque","libelle", "dateSaisie", "dateEffet", "credit", "debit","idplacement"};
    PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("treso/recette-liste.jsp");
    
    /*String where = " and credit = 0 ";
    pr.setAWhere(where);*/
    
    
     if(request.getParameter("caisse")!=null){
        String caisse = request.getParameter("caisse");
        pr.setApres(pr.getApres()+"&caisse="+caisse);
        pr.setAWhere(" and caisse ='"+caisse+"'");
    }
    
    if(request.getParameter("etat")!=null){
        String etat = request.getParameter("etat");
        pr.setApres(pr.getApres()+"&etat="+etat);
        pr.setAWhere(pr.getAWhere()+" and etat="+etat);
    }

        pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        pr.getFormu().getChamp("libelle").setLibelle("Libellé");
        pr.getFormu().getChamp("idtypecheque").setLibelle("Type");
    

  
    String[] colSomme = {"credit"};
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Journal de recette </h1>
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
                        <option value="journalcaisselibrecette" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIBmiv") == 0) {
                                out.print("selected");
                            }%>>Tous</option>
                        <option value="JOURNALCAISSELIBRECETTE_CREE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_CREE_miv") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;e</option>
                        <option value="JOURNALCAISSELIBRECETTE_VISE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_vise_miv") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;</option>

                        
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%                                  
            String libEnteteAffiche[] = {"Id", "Folio", "Caisse","Type", "Num Piece", "num cheque", "Libellé", "Date Saisie", "Date Effet", "Entrée", "Sortie","Source"};
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