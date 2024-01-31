
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.spat.DemandeAchatMere"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.*"%>
<%@page import="utilisateur.*"%>

<%
    try {

        DemandeAchatMere demandeMere = new DemandeAchatMere();
        UserEJB u = (user.UserEJB) session.getValue("u");
        Prioritaire prioritaire = new Prioritaire();
        String aWhere = prioritaire.makeListConfidentiality(u,"codeetablissementlib");

        demandeMere.setNomTable("dem_achat_merelib");
        String nomTableEtat = request.getParameter("nomTableEtat");
        if(nomTableEtat!=null && !nomTableEtat.isEmpty()){
            demandeMere.setNomTable(nomTableEtat);
        }

        String listeCrt[] = {"id","num", "designation","codeetablissementlib","projetlib","patrimoinelib","daty","idcategorieachat"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id","num","designation","idcategorieachatlib","codeetablissementlib","projetlib","patrimoinelib","montantengager","daty","etatlib"};

        PageRecherche pr = new PageRecherche(demandeMere, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        affichage.Champ[] liste = new affichage.Champ[1];

        TypeObjet catAchat = new TypeObjet();
        catAchat.setNomTable("categorieachat");
        liste[0] = new Liste("idcategorieachat", catAchat, "VAL", "id");
        
        pr.getFormu().changerEnChamp(liste);

        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("codeetablissementlib").setLibelle("Code etablissemment");
        pr.getFormu().getChamp("patrimoinelib").setLibelle("Patrimoine");

        pr.getFormu().getChamp("designation").setLibelle("Designation");
        pr.getFormu().getChamp("num").setLibelle("No.");
        pr.getFormu().getChamp("idcategorieachat").setLibelle("Cat&eacute;gorie achat");

        pr.setApres("depense/demande-achat-liste.jsp");
        pr.setAWhere(aWhere);

        
        String[] colSomme =null;
        pr.creerObjetPage(libEntete, colSomme);
        String[] etatVal = {"dem_achat_merelib", "dem_achat_merelib_cree", "DEM_ACHAT_MERELIB_vise"};
        String[] etatAff = {"Toutes", "Cr&eacute;&eacute;e", "Vis&eacute;e"};
%>
<script>
    function submitFormulaire(){
        document.getElementById("engagement").submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des DASE</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=depense/demande-achat-liste.jsp" method="post" name="achat" id="engagement">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row">
                <div class="col-md-12">
                    <br>
                    <select name="nomTableEtat" id="nomTableEtat" onchange="submitFormulaire()" class="form-control"style="max-width: 200px; margin: 0 auto;">
                            <%for(int i=0; i<etatVal.length; i++){
                                String selected = demandeMere.getNomTable().equalsIgnoreCase(etatVal[i]) ? "selected" : "";
                            %>
                            <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                            <%}%>
                        </select>
                    <br>
                </div>
            </div>
        </form>
        <form action="<%=pr.getLien()%>?but=stock/bc/bondecommande-multiple.jsp" method="post" name="form_arif" id="form_arif">
            <%  String lienTableau[] = {pr.getLien() + "?but=depense/demande-achat-fiche.jsp"};
                String colonneLien[] = {"id"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setColonneLien(colonneLien);
                out.println(pr.getTableauRecap().getHtml());%>
            <br>
            <%
                String libEnteteAffiche[] ={"Id", "No.", "D&eacute;signation", "Cat&eacute;gorie achat", "Code &eacute;tablissement","Projet","Patrimoine","montant engag&eacute;","Date","Etat"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("genererBC");
                pr.getTableau().setNameBoutton("G&eacute;n&eacute;rer BC");
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
        </form>
        <%
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>