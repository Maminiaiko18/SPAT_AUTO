<%@page import="java.util.Map"%>
<%@page import="java.util.concurrent.ConcurrentHashMap"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<!--FICHIER TOJO And-->
<%!
    UserEJB u;
%>
<%
    try {
        String nomtable = request.getParameter("ciblename");
        Map<String, String> titres = new ConcurrentHashMap<String, String>();
        titres.put("banque", "Banque");
        titres.put("entite", "Entité");
        titres.put("consignataire", "Consignataire");
        titres.put("pays", "Pays");
        titres.put("typequais", "Type quais");
        titres.put("type_materiel", "Type mat&eacute;riel naval");
        titres.put("typemesure", "Type mesure");
        titres.put("typemarchandise", "Type marchandise");
        titres.put("typemanipulation", "Type manipulation");
        titres.put("nomsociete", "Société");
        titres.put("typeactionconteneur", "Type Action Conteneur");
        titres.put("typetravaux ", "Type travaux");
        titres.put("poste", "Poste");
        titres.put("typepatrimoine", "Type patrimoine");
        titres.put("etatpatrimoine", "Etat patrimoine");
        titres.put("Type_fact_cat_client", "Type facture categorie client");
        titres.put("typecheque", "Type ch&egrave;que");
        titres.put("Marque_Materiel", "Marque mat&eacute;riel");
        titres.put("Type_renseignement_interne", "Type renseignement interne");
        titres.put("commandant", "Commandant");
        titres.put("manoeuvrebord", "Manoeuvre de bord");
        titres.put("cargaison", "Cargaison");
        TypeObjet p = new TypeObjet();
        p.setNomTable(nomtable);
        u = (user.UserEJB) session.getValue("u");
        PageUpdate pc = new PageUpdate(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        //pc.getFormu().getChamp("Type_renseignement_interne").setLibelle("Type renseignement interne");
        String titre = (String) titres.get(nomtable);

        /*if (titre.compareToIgnoreCase("BUDGET_CATEGORIE_REJET_OP") == 0) {
            titre = "Categorie rejet OP";
        }*/
        String val = "Valeur";
        String desce = "Description";

        if (request.getParameter("value") != null && request.getParameter("value").compareToIgnoreCase("") != 0) {
            val = request.getParameter("value");
        }
        if (request.getParameter("description") != null && request.getParameter("description").compareToIgnoreCase("") != 0) {
            desce = request.getParameter("description");
        }

        pc.getFormu().getChamp("val").setLibelle(val);
        pc.getFormu().getChamp("desce").setLibelle(desce);

        pc.preparerDataFormu();


%>
<div class="content-wrapper">
    <section class="content-header">
        <h1><a href="<%=(String) session.getValue("lien")%>?but=configuration/idvaldesce.jsp&ciblename=<%out.print(nomtable);%>&value=<%=val%>&description=<%=desce%>"><i class="fa fa-arrow-circle-left"></i></a> Modification <%out.print(titre);%></h1>
    </section>
    <section class="content">
        <form action="<%=(String) session.getValue("lien")%>?but=configuration/apresIdvaldesce.jsp" method="post" name="configuration" id="idvaldesce">
            <%
                out.println(pc.getFormu().getHtmlInsert());
            %>
            <input class="btn btn-warning" type="submit" name="Submit2" value="Modifier" class="submit">

            <input class="btn btn-danger" type="submit" name="Submit2" value="Supprimer" class="submit" onclick="acte.value = 'delete'">
            <input name="acte" type="hidden" id="acte" value="update">
            <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
            <input name="bute" type="hidden" id="bute" value="configuration/idvaldesce.jsp&ciblename=<%=nomtable%>&value=<%=val%>&description=<%=desce%>">
            <input name="classe" type="hidden" id="classe" value="bean.TypeObjet">
        </form>
    </section>
</div>

<% } catch (Exception e) {
        e.printStackTrace();
    }%>