<%-- 
    Document   : mouvement-liste
    Created on : 4 nov. 2019, 15:02:33
    Author     : john
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="lignecredit.LigneCredit"%>
<%@page import="mg.spat.Prevision"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
      try{
          user.UserEJB u = (user.UserEJB) session.getValue("u");
    LigneCredit ligncredit = new LigneCredit();
     
    String nomTable = "SITUATIONLCDEPENSE2";    
    if(request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0){
        nomTable = request.getParameter("table");
    }
    ligncredit.setNomTable(nomTable);
    
    //String listeCrt[] = {"id","escale","nomnavire", "valconsignataire", "valcargaison", "valquaisdestination","datearrivee", "date_depart","quaisdestination"};
    String listeCrt[] = {"id", "direction", "projet", "designation","compte","annee","comptestr","niveau1", "niveau2", "niveau3", "niveau4"};
    String listeInt[] = {"annee"};
    String libEntete[] = {"id", "direction", "projet", "designation","compte","annee","montant","facture","pourcEngage","paye","pourcPaye","arecouvrir","restebudget"};
    PageRecherche pr = new PageRecherche(ligncredit, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur(u);
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("annee1").setLibelle("Ann&eacute;e min");
    pr.getFormu().getChamp("annee1").setDefaut(Utilitaire.getAnneeEnCours());
    pr.getFormu().getChamp("annee2").setLibelle("Ann&eacute;e max");
    pr.getFormu().getChamp("annee2").setDefaut(Utilitaire.getAnneeEnCours());
    pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pr.getFormu().getChamp("comptestr").setLibelle("Compte Pur");
    String[] colSomme = {"montant","facture","paye","arecouvrir","restebudget"};
    pr.creerObjetPage(libEntete, colSomme);
	pr.getTableauRecap().setLibeEntete(new String[]{"", "Nombre", "Somme De Montant","Somme De Factur&eacute;","Somme De Pay&eacute;","Somme De A Recouvrir","Somme De Reste Sur Budget"});
%>
<script>
    function changerDesignation() {
        document.listemouvement.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Ligne Cr&eacute;dit D&eacute;pense</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/liste-ligneCreditDepense.jsp" method="post" name="listemouvement" id="listemouvement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("SITUATIONLCDEPENSE2") == 0) {%>    
                        <option value="SITUATIONLCDEPENSE2" selected>Tous</option>
                        <% } else { %>
                        <option value="SITUATIONLCDEPENSE2" >Tous</option>
                        <% } %>
                 
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("SITUATIONLCDEPENSEC2") == 0) {%>
                        <option value="SITUATIONLCDEPENSEC2" selected> Cr&eacute;e  </option>
                        <% } else { %>
                        <option value="SITUATIONLCDEPENSEC2"> Cr&eacute;e  </option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("SITUATIONLCDEPENSEVSD2") == 0) {%>
                        <option value="SITUATIONLCDEPENSEVSD2" selected> Vis&eacute;  </option>
                        <% } else { %>
                        <option value="SITUATIONLCDEPENSEVSD2"> Vis&eacute;  </option>
                        <% } %>
                        
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/fiche-ligneCreditDepense.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Direction", "Projet", "D&eacute;signation","Compte","Ann&eacute;e","Montant","Factur&eacute;","% factur&eacute;","Pay&eacute;","% pay&eacute;"," A recouvrir","reste sur budget"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
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
