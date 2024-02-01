
<%@page import="ordremission.OrdreMissionLib"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%> 
<%@page import="mg.cnaps.formation.CodeEtablissement"%>
<%@ page import="java.util.*" %>

<% try{ 
    OrdreMissionLib t = new OrdreMissionLib();
    UserEJB u = (user.UserEJB) session.getValue("u");
    String where = "";
    String idUser = "" + u.getUser().getTuppleID();
    String userRole = u.getUser().getIdrole();
    //tsy Admin 
    if (!"dg".equalsIgnoreCase(userRole))
    {
        where = " and iduser ='"+idUser+"'" ;
        if (u.getUser().getCodeEtablissement() != null){
            CodeEtablissement code = u.getCodeEtablissement();
            String codeetb = code.getVal();
            Set<String> validCodeEtb = new HashSet<>(Arrays.asList("120", "121"));
            Set<String> validUserRoleIds = new HashSet<>(Arrays.asList("ROL000422", "ROL000421","ROL0000001321113437"));

            if (validCodeEtb.contains(codeetb)) {
                // mahita ny rehetra akotran nen Mdm Fanja
                where = " and iduser != '1637' " ;
            }
            if (validUserRoleIds.contains(userRole)){
                //mahita ny rehetra
                where = "";
            }
        }
        
    } 
    System.out.println("whereeeee OM"+where);
        
    t.setNomTable("ordre_mission_lib");
    String listeCrt[] = {"id", "nom", "prenom", "matricule", "numom", "datedepart", "duree", "lieudeplacement"};
    String listeInt[] = {"datedepart", "duree"};
    String libEntete[] = {"id", "numom", "nom", "prenom", "matricule", "fonction", "datedepart", "duree", "datearrivee", "lieudeplacement"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setNpp(10);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ordre-mission/ordre-mission-liste.jsp");
    pr.getFormu().getChamp("datedepart1").setLibelle("Date d&eacute;part min");
    pr.getFormu().getChamp("datedepart2").setLibelle("Date d&eacute;part max");
    pr.getFormu().getChamp("duree1").setLibelle("Dur&eacute;e min");
    pr.getFormu().getChamp("duree2").setLibelle("Dur&eacute;e max");
    pr.getFormu().getChamp("numom").setLibelle("Num&eacute;ro OM");
    pr.getFormu().getChamp("lieudeplacement").setLibelle("Lieu de Placement");
    pr.getFormu().getChamp("prenom").setLibelle("Pr&eacute;nom");
    pr.setAWhere(where);
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Ordre de Mission</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ordre-mission/ordre-mission-liste.jsp" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ordre-mission" + "/ordre-mission-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Num&eacute;ro OM", "Nom", "Pr&eacute;nom", "Matricule","Fonction", "Date d&eacute;part", "Dur&eacute;e", "Date arriv&eacute;e", "Lieu d&eacute;placement"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
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



