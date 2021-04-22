<%-- 
    Document   : idvaldesce-groupe
    Created on : 13 nov. 2018, 09:00:02
    Author     : pro
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.concurrent.ConcurrentHashMap"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String cible = request.getParameter("ciblename");
    Map<String, String> titre = new ConcurrentHashMap<String, String>();
    titre.put("ST_GROUPE_ARTICLE", "Groupe");
    
    TypeObjet act = new TypeObjet();
    act.setNomTable(cible);
    //act.setNomProcedureSequence("seq"+cible);
    PageInsert pi = new PageInsert(act, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    String val = "Valeur";
    String desce = "Description";
    
    
    if(request.getParameter("value") != null && request.getParameter("value").compareToIgnoreCase("") != 0)val = request.getParameter("value");
    if(request.getParameter("description") != null && request.getParameter("description").compareToIgnoreCase("") != 0)desce = request.getParameter("description");
    
    pi.getFormu().getChamp("val").setLibelle(val);
    pi.getFormu().getChamp("desce").setLibelle(desce);
    
    pi.getFormu().getChamp("desce").setType("textarea");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%=titre.get(cible)%></h1>
    </section>
    <section class="content">

        <form action="<%=pi.getLien()%>?but=configuration/apresIdvaldesce.jsp&ciblename=<%out.print(cible);%>&value=<%=URLEncoder.encode(val, "UTF-8")%>&description=<%=URLEncoder.encode(desce, "UTF-8")%>" method="post" name="configuration" id="idvaldesce">
            <%
                pi.getFormu().makeHtmlInsertTabIndex();
                out.println(pi.getFormu().getHtmlInsert());
            %>

            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="configuration/idvaldesce-groupe.jsp&ciblename=<%out.print(cible);%>&value=<%=URLEncoder.encode(val, "UTF-8")%>&description=<%=URLEncoder.encode(desce, "UTF-8")%>">
            <input name="classe" type="hidden" id="classe" value="bean.TypeObjet">
            <input name="nomtable" type="hidden" id="nomtable" value="<%out.print(cible);%>">
        </form>
        <%
            TypeObjet e = new TypeObjet();
            e = act;

            e.setNomTable(cible);
            String listeCrt[] = {"id", "val", "desce"};
            String listeInt[] = null;
            String libEntete[] = {"id", "val", "desce"};

            PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 3);
            pr.setUtilisateur((user.UserEJB) session.getValue("u"));
            pr.setLien((String) session.getValue("lien"));
            pr.setApres("configuration/idvaldesce-groupe.jsp&ciblename=" + cible + "&value="+URLEncoder.encode(val, "UTF-8")+"&description="+URLEncoder.encode(desce, "UTF-8"));

            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
        %>
        <form action="<%=pr.getLien()%>?but=configuration/idvaldesce-groupe.jsp&ciblename=<%out.println(cible);%>&value=<%=URLEncoder.encode(val, "UTF-8")%>&description=<%=URLEncoder.encode(desce, "UTF-8")%>"
              method="post" name="configuration" id="idvaldesce">
            <%
                pr.getFormu().getChamp("id").setLibelle("Identifiant");
                pr.getFormu().getChamp("val").setLibelle(val);
                pr.getFormu().getChamp("desce").setLibelle(desce);

                out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=configuration/modif_idvaldesce.jsp&ciblename=" + cible + "&value="+val+"&description="+desce};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <%
            String libEnteteAffiche[] = {"Identifiant", val, desce};

            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>