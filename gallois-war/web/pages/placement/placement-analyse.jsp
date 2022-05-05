<%-- 
    Document   : placement-analyse
    Created on : 3 mai 2022, 15:42:25
    Author     : macos
--%>

<%@page import="mg.spat.placement.Placement"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        
        String[] etatVal = {"PLACEMENT_ANALYSE", "PLACEMENT_ANALYSE_NEW", "PLACEMENT_ANALYSE_RENOUVELLE"};
        String[] etatAff = {"Tous", "Nouveaux", "Renouvelés "};
        
        Placement journal = new Placement();
        journal.setNomTable(etatVal[0]);
       // String etat = request.getParameter("etat");
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            journal.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"entite", "banque", "moisplacementlib", "anneePlacement"};
        String listeInt[] = {"moisplacementlib", "anneeplacement"};

        String[] pourcentage = {};
        String somDefaut[] = {"montant", "montant_terme", "interet_recevoir","interetNet"};
        String colDefaut[] = {"entite", "banque", "moisplacementlib", "anneePlacement"};

        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 3);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("entite").setLibelle("Entite");
        pr.getFormu().getChamp("banque").setLibelle("Banque");
        pr.getFormu().getChamp("moisplacementlib1").setLibelle("Mois de Placement min");
        pr.getFormu().getChamp("moisplacementlib2").setLibelle("Mois de Placement max");

        pr.getFormu().getChamp("anneePlacement1").setLibelle("Annee de Placement min");
        pr.getFormu().getChamp("anneePlacement2").setLibelle("Annee de Placement max");
        
//        pr.getFormu().getChamp("moisplacementlib1");
//        pr.getFormu().getChamp("moisplacementlib2").setDefaut(fin[1]);
        
        affichage.Champ[] liste = new affichage.Champ[2];
        TypeObjet mois = new TypeObjet();
        mois.setNomTable("mois");
        liste[0] = new Liste("moisplacementlib2", mois, "desce", "desce");
        liste[1] = new Liste("moisplacementlib1", mois, "desce", "desce");
        pr.getFormu().changerEnChamp(liste);

        pr.setApres("placement/placement-analyse.jsp");
        pr.creerObjetPagePourc();

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse placement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/placement-analyse.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = etatVal[i].equalsIgnoreCase(journal.getNomTable()) ? "selected" : "";
                            
                        %>
                        <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                        <%}%>
                    </select>
                    <% if(request.getParameter("etat")!= null && ( request.getParameter("etat").compareToIgnoreCase("factureclientAuComptant") == 0 || request.getParameter("etat").compareToIgnoreCase("factureclientACredit") == 0))
                 { %>
                    <div class="box-footer">
                        <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=listesFactEmises&id=<%=request.getParameter("id") %>&daty1=<%=request.getParameter("daty1") %>&daty2=<%=request.getParameter("daty2") %>&tierslib=<%=request.getParameter("tierslib") %>&designation=<%=request.getParameter("designation") %>&armateurlib=<%=request.getParameter("armateurlib")%>&date_echeance1=<%=request.getParameter("date_echeance1")%>&date_echeance2=<%=request.getParameter("date_echeance2")%>&escale=<%=request.getParameter("escale")%>&categorielib=<%=request.getParameter("categorielib")%>&code=<%=request.getParameter("code")%>&etat=<%=request.getParameter("etat")%>&codeFiltre=<%=request.getParameter("codeFiltre")%>" style="margin-right: 10px">Imprimer</a>                            <!--<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=facturegallois/client/facture-client-saisie.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Dupliquer modele</a>-->
                                    <!----<a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=listesFactEmises&id=<%=request.getParameter("id") %>&daty1=<%=request.getParameter("daty1") %>&daty2=<%=request.getParameter("daty2") %>&etat=<%=request.getParameter("etat")%>" style="margin-right: 10px">Imprimer</a>                            <!--<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=facturegallois/client/facture-client-saisie.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Dupliquer modele</a>-->
                   </div>
            <% } %>
                </div>
                    
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
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