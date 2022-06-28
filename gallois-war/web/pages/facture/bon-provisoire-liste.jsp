<%@page import="mg.spat.Engagement"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="facture.BonProvisoire"%>

<%
    try {

        Engagement eng = new Engagement();
        eng.setNomTable("bon_provisoire_final_lib");
        String nomTableEtat = request.getParameter("nomTableEtat");
        if(nomTableEtat!=null && !nomTableEtat.isEmpty()){
        eng.setNomTable(nomTableEtat);
        }

        String listeCrt[] = {"id","tiers","daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "tiers", "daty","montant", "remaque","etat","tierslib","caisselib","projetlib"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");

       // pr.setApres("facture/bon-provisoire-liste.jsp);
     //   String[] colSomme ={"montant"};
     //   pr.creerObjetPage(libEntete, colSomme);
        String[] etatVal = {"bon_provisoire_final_lib", "bon_provisoire_final_lib_cree", "bon_provisoire_final_lib_vise"};
        String[] etatAff = {"Tous", "Cr&eacute;es", "Vis&eacute;e"};

%>
<script>
    function submitFormulaire(){
        document.getElementById("engagement").submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste de bon provisoire </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/bon-provisoire-liste.jsp" method="post" name="engagement" id="engagement">
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
        <%  String lienTableau[] = {pr.getLien() + "?but=facture/bon-provisoire-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Tiers", "Daty","Montant", "Remarque","Etat","Tierslib","Caisse","Projet"};
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