
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.spat.LibererLib"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    LibererLib liberer = new LibererLib();
    String[] etatVal = {"LIBERERLIB", "LIBERERLIBC", "LIBERERLIBV"};
    String[] etatAff = {"Tous", "Créée(s)", "Visée(s)"};
    liberer.setNomTable(etatVal[0]);        
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        liberer.setNomTable(request.getParameter("etat"));
    }

    String listeCrt[] = {"id",  "montant", "etat", "etatLib", "remarque", "daty","num", "codeEtablissementLib", "projetLib"}; 
    String listeInt[] = {"daty"};       
    String libEntete[] = {"id",  "montant", "etat", "etatLib", "remarque", "daty","num", "codeEtablissementLib", "projetLib"};
    PageRecherche pr = new PageRecherche(liberer, request, listeCrt, listeInt, 3, libEntete, libEntete.length);

    pr.setTitre("Historique liberer");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ligneCredit/historique-Liberer.jsp");
   
//    affichage.Champ[]liste = new affichage.Champ[1];
//    TypeObjet caisse = new TypeObjet();
//    caisse.setNomTable("CAISSE");
//    liste[0] = new affichage.Liste("caisse", caisse, "val", "val");

//    String debutDate = "01/01/"+Utilitaire.getAnnee(Utilitaire.dateDuJourSql());
//    String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", Utilitaire.dateDuJourSql());
//    if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
//        pr.getFormu().getChamp("daty1").setDefaut(debutDate);
//        pr.getFormu().getChamp("daty2").setDefaut(dateFin);
//    }    
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("MONTANT").setLibelle("Montant");
    pr.getFormu().getChamp("ETAT").setLibelle("Etat");
    pr.getFormu().getChamp("ETATLIB").setLibelle("Etat Lib");
    pr.getFormu().getChamp("REMARQUE").setLibelle("Remarque");
    pr.getFormu().getChamp("NUM").setLibelle("Numero");
    pr.getFormu().getChamp("CODEETABLISSEMENTLIB").setLibelle("Code Etab");
    pr.getFormu().getChamp("PROJETLIB").setLibelle("Projet Lib");

//    pr.getFormu().changerEnChamp(liste);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=ligneCredit/historique-liberer.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles ï¿½ afficher
    String libEnteteAffiche[] = {"id",  "montant", "etat", "etatLib", "remarque", "daty","num", "codeEtablissementLib", "projetLib"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/historique-Liberer.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = etatVal[i].equalsIgnoreCase(liberer.getNomTable()) ? "selected" : "";
                        %>
                        <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                        <%}%>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
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
    }catch(Exception e){

        e.printStackTrace();
    }
%>