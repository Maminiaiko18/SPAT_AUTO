<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="mg.spat.Engagement"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        Engagement eng = new Engagement();
        eng.setNomTable("engagementlib");

        String listeCrt[] = {"id", "designation","projet", "montant", "disponible","dispoavant","dispoapres","etat","codeetablissementlib","projetlib", "daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "designation", "projet", "montant", "disponible","dispoavant","dispoapres","codeetablissementlib","projetlib", "daty"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("dispoavant").setLibelle("Disponibilité avant");
        pr.getFormu().getChamp("dispoapres").setLibelle("Disponibilité  après");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("codeetablissementlib").setLibelle("Code établissemment");
        pr.getFormu().getChamp("designation").setLibelle("Désignation");
        pr.getFormu().getChamp("montant").setLibelle("Montant");
         pr.getFormu().getChamp("disponible").setLibelle("Disponibilité");
        pr.getFormu().getChamp("id").setLibelle("Id");

        pr.setApres("depense/engagement-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String[] etatVal = {"engagementlib", "engagementlibC", "engagementlibV"};
    String[] etatAff = {"Tous", "Créée", "Visée"};

%>
<script>
    function submitFormulaire(){
        document.getElementById("engagement").submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Engagements </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=depense/engagement-liste.jsp" method="post" name="engagement" id="engagement">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row">
                <div class="col-md-12">
                    <br>
                    <select name="nomTableEtat" id="nomTableEtat" onchange="submitFormulaire()" class="form-control"style="max-width: 200px; margin: 0 auto;">
                            <%for(int i=0; i<etatVal.length; i++){
                                String selected = eng.getNomTable().equalsIgnoreCase(etatVal[i]) ? "selected" : "";
                            %>
                            <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                            <%}%>
                        </select>
                    <br>
                </div>
            </div>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=depense/engagement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] ={"Id", "Désignation","Projet", "Montant", "Disponibilité","Disponibilité avant","Disponibilité après","Code établissement","Projet", "Date"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>