<%-- 
    Document   : engagement-listefcc.jsp
    Created on : 4 janv. 2023, 15:37:15
    Author     : Zo
--%>
<%@page import="mg.spat.Engagement"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        Engagement eng = new Engagement();
        eng.setNomTable("engagementlib");
        String nomTableEtat = request.getParameter("nomTableEtat");
        if(nomTableEtat!=null && !nomTableEtat.isEmpty()){
        eng.setNomTable(nomTableEtat);
        }

        String listeCrt[] = {"id", "designation","codeetablissementlib","projetlib", "daty", "tierslib","num"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "designation", "montant","montantOP", "montantreste","dispoavant","dispoapres","codeetablissementlib","projetlib", "tierslib", "daty","num"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("codeetablissementlib").setLibelle("Code &eacute;tablissemment");
        pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("id").setLibelle("Id");
        pr.getFormu().getChamp("num").setLibelle("No.");
        pr.setApres("depense/engagement-liste.jsp");
        String[] colSomme ={"montant"};
        pr.creerObjetPage(libEntete, colSomme);
        String[] etatVal = {"engagementlib", "engagementlibC", "engagementlibV"};
    String[] etatAff = {"Tous", "Cr&eacute;&eacute;", "Vis&eacute;"};

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
            String libEnteteAffiche[] ={"Id", "D&eacute;signation", "Montant", "Montant d'ordre payment","Disponibilit&eacute;","Disponibilit&eacute; avant","Disponibilit&eacute; apr&egrave;s","Code &eacute;tablissement","Projet", "Tiers", "Date","No."};
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