<%@page import="java.util.Map"%>
<%@page import="java.util.concurrent.ConcurrentHashMap"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<% 
    try{
    String cible = request.getParameter("ciblename");
    Map<String, String> titre = new ConcurrentHashMap<String, String>();
    titre.put("typeFC", "Type facture client");
    titre.put("codeetablissement", "Code etablissement");
    titre.put("typeavoir", "Type avoir");
    titre.put("typeadditif", "Type additif");
    titre.put("typemesure", "Type mesure");
    titre.put("typemarchandise", "Type marchandise");
    titre.put("typemanipulation", "Type manipulation");
    titre.put("nomsociete", "Soci�t�");
    titre.put("typeactionconteneur", "Type Action Conteneur");
    titre.put("unitechantier", "Unite");
    titre.put("banque", "Banque");
    titre.put("entite", "Entit�");
    titre.put("consignataire", "Consignataire");
    titre.put("pays", "Pays");
    titre.put("typequais", "Type quais");
    titre.put("type_materiel", "Type mat&eacute;riel naval");
    titre.put("typetravaux ", "Type travaux");
    titre.put("poste", "Poste");    
    titre.put("typepatrimoine", "Type patrimoine");
    titre.put("etatpatrimoine", "Etat patrimoine");
    titre.put("Type_fact_cat_client", "Type facture categorie client");
    titre.put("typecheque", "Type ch&egrave;que");
    titre.put("commandant", "Commandant");
    titre.put("manoeuvrebord", "Manoeuvre de bord");
    titre.put("etatpatrimoine", "Etat de patrimoine");
    titre.put("cargaison", "Cargaison");
    titre.put("pilote", "Capitaine");
    titre.put("typenavire", "type navire");
    titre.put("categoriefacturation", "Cat�gorie");
    titre.put("redevance", "Redevance");
    titre.put("unite_activite", "Unit�");

    titre.put("Marque_Materiel", "Marque mat&eacute;riel");

    titre.put("Type_renseignement_interne", "Type renseignement interne");
    
    titre.put("CodeEtablissement", "code etablissement");
    
    titre.put("consignatairetab", "Consignataire Soci�t�");
    
    titre.put("consignatairetab", "Consignataire Soci�t�");
    
    titre.put("destination", "destination");
    
    titre.put("departement", "departement");
    
    titre.put("service", "service");
    
    titre.put("categorieFC", "categorie facture client");
    
    titre.put("motifAvoirFC","Motif avoir facture client");
    
    titre.put("categorieAvoirFC","Categorie avoir facture client");
    titre.put("nature", "Nature");

    titre.put("typeclient", "Type Client");
    
    TypeObjet act = new TypeObjet();
    act.setNomTable("armateur_tbd");
    PageInsert pi = new PageInsert(act, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    //String val = "Valeur";
    String val = titre.get(cible);
    String desce = "Description";
    
    if(request.getParameter("value") != null && request.getParameter("value").compareToIgnoreCase("") != 0)val = request.getParameter("value");
    if(request.getParameter("description") != null && request.getParameter("description").compareToIgnoreCase("") != 0)desce = request.getParameter("description");
    
    if(request.getParameter("valeur") != null && request.getParameter("valeur").compareToIgnoreCase("") != 0)pi.getFormu().getChamp("val").setDefaut(request.getParameter("valeur"));
    if(request.getParameter("descr") != null && request.getParameter("descr").compareToIgnoreCase("") != 0)pi.getFormu().getChamp("desce").setDefaut(request.getParameter("descr"));
    
    pi.getFormu().getChamp("val").setLibelle(val);
    pi.getFormu().getChamp("desce").setLibelle(desce);
    
    pi.getFormu().getChamp("desce").setType("textarea");
    
    
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <section class="content-header">
        <!--<h1><%//=titre.get(cible)%></h1>-->
        <h1><%=titre.get(cible)%></h1>
    </section>
    <section class="content">

        <form action="<%=pi.getLien()%>?but=configuration/apresIdvaldesce.jsp&ciblename=<%out.print(cible);%>&value=<%=val%>&description=<%=desce%>" method="post" name="configuration" id="idvaldesce">
            <%
                pi.getFormu().makeHtmlInsertTabIndex();
                out.println(pi.getFormu().getHtmlInsert());
            %>

            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="configuration/idvaldesce.jsp&ciblename=<%out.print(cible);%>&value=<%=val%>&description=<%=desce%>">
            <input name="classe" type="hidden" id="classe" value="bean.TypeObjet">
            <input name="nomtable" type="hidden" id="nomtable" value="<%out.print(cible);%>">
        </form>
        <%
            TypeObjet e = new TypeObjet();
            e = act;

            e.setNomTable("armateur_tbd");
            
            String[] champ = {"id", "val", "desce"};
            String[] libelle_comp = {"id", "Valeur", "Description"};
            
            String listeCrt[] = {"id", "val", "desce"};
            String listeInt[] = null;
            String libEntete[] = {"id", "val", "desce"};
            PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 3);
            pr.setUtilisateur((user.UserEJB) session.getValue("u"));
            pr.setLien((String) session.getValue("lien"));
            pr.setAWhere(" order by val asc");
            pr.setApres("configuration/idvaldesce.jsp&ciblename=" + cible);

            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
        %>
        <form action="<%=pr.getLien()%>?but=configuration/idvaldesce.jsp&ciblename=<%out.println(cible);%>&value=<%=val%>&description=<%=desce%>"
              method="post" name="configuration" id="idvaldesce">
            <%
                pr.getFormu().getChamp("id").setLibelle("Identifiant");
                pr.getFormu().getChamp("val").setLibelle(val);
                pr.getFormu().getChamp("desce").setLibelle(desce);
                out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=configuration/modif_idvaldesce.jsp&ciblename=" + cible + "&value=" + val + "&description"+desce};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <%
            //String libEnteteAffiche[] = {"Identifiant", val, desce};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    
<%
    }catch(Exception e) {
                    e.printStackTrace();
                    }
%>
    