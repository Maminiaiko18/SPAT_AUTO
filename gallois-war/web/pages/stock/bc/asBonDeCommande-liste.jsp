<%-- 
    Document   : as-commande-liste
    Created on : 1 d�c. 2016, 09:52:16
    Author     : Joe
--%>
<%@page import="java.sql.Date"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.*"%>

<% 
    BonDeCommande lv = new BonDeCommande();
    
    String etat = "AS_BONDECOMMANDE_LIBELLE_lib";
    
     
    //PAR DEFAUT
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        etat = request.getParameter("etat");
    }
	
    String libEntete[] = {"id", "daty","code_etab","projet", "fournisseur", "designation", "modepaiement", "remarque","numbc","montant","montantRemise","montanttva","montantTTC","montant_A_payer","restepayergeneral","montantfacture","montant_paye_reel","resteapayerreel","etatlib"};
    String listeCrt[] = {"id","daty","code_etab","projet", "fournisseur", "designation", "modepaiement", "remarque","numbc"};
    String listeInt[] = {"daty"};

    
    lv.setNomTable(etat);
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 2, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.getFormu().getChamp("code_etab").setLibelle("Code");
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
    
    /*affichage.Champ[] liste = new affichage.Champ[1];
	
    TypeObjet ou = new TypeObjet();
    ou.setNomTable("modepaiement");
    liste[0] = new Liste("modepaiement", ou, "VAL", "VAL");
	
    pr.getFormu().changerEnChamp(liste);*/
    
    Date firstDate = Utilitaire.dateDuJourSql();   
    firstDate.setDate(1);        
    Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);

    String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
    String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);

    if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
        pr.getFormu().getChamp("daty1").setDefaut(debutDate);
        pr.getFormu().getChamp("daty2").setDefaut(dateFin);

    }
    
    pr.getFormu().getChamp("daty1").setLibelle("Date debut");
    pr.getFormu().getChamp("daty2").setLibelle("Date fin");

    pr.setOrdre(" order by daty desc");
    
    pr.setApres("stock/bc/asBonDeCommande-liste.jsp");
    String[] colSomme = {"montantTTC"};
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des bons de commande</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=stock/bc/asBonDeCommande-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (etat == null || etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_lib") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_lib" selected>tous</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_lib">tous</option>
                        <% } %>

                        <% if (etat == null || etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_AN") == 0) {%>
                            <option value="AS_BONDECOMMANDE_LIBELLE_AN" selected>Annul&eacute;</option>
                        <% } else { %>
                            <option value="AS_BONDECOMMANDE_LIBELLE_AN">Annul&eacute;</option>
                        <% } %>


                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_CREE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_CREE" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_CREE">Cr&eacute;&eacute;</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_VISE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_VISE" selected>Vis&eacute;</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_VISE">Vis&eacute;</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_LIVRE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_LIVRE" selected>Livr&eacute; </option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_LIVRE">Livr&eacute; </option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_FACT") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_FACT" selected>Factur&eacute;</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_FACT">Factur&eacute;</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIB_ATTPAY") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIB_ATTPAY" selected>En attente de paiement</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIB_ATTPAY">En attente de paiement</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_PAYE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_PAYE" selected>Pay&eacute;</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_PAYE">Pay&eacute;</option>
                        <% } %>


                    </select>
                </div>
                <div class="col-md-4"></div>
            </div><br/><br/>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Date","Code","Projet", "Fournisseur", "Designation", "Mode de paiement", "Remarque","numero BC","Montant HT","Montant Remise","Montant TVA","Montant TTC","Montant BL TTC","Reste � livrer","Montant factur&eacute;","Montant pay� r��l","Reste � payer r�el", "Etat"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
			  
				out.println(pr.getTableau().getHtml());
				out.println(pr.getBasPage());
		%>
    </section>
</div>