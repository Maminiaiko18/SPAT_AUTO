<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="configuration.*" %>

<%
    String cible = null;
    try {
        cible = request.getParameter("ciblename");
        TypeObjet p = new TypeObjet();
        p.setNomTable(cible);
        PageConsulte pc = new PageConsulte(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        TypeObjet e = (TypeObjet) pc.getBase();
%>
<div class="content-wrapper">

    <h1>Consultation du fiche <%out.println(cible);%></h1>
    <%
        String libEnteteAffiche[] = {"Valeur", "Description", "Identifiant"};
        pc.setLibAffichage(libEnteteAffiche);
        out.println(pc.getHtml());
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> alert('<%=e.getMessage()%>');
       history.back();</script>
    <%
        }
    %>
    <a class="btn btn-warning" href="<%=(String) session.getValue("lien") + "?but=configuration/modif_idvaldesce.jsp&ciblename=" + cible + "&id=" + request.getParameter("id")%>">Modifier</a>
    <a class="btn btn-danger" href="<%=(String) session.getValue("lien") + "?but=configuration/apresIdvaldesce.jsp&ciblename=" + request.getParameter("ciblename") + "&nomtable=" + cible + "&id=" + request.getParameter("id")%>&acte=delete&bute=configuration/idvaldesce.jsp&classe=bean.TypeObjet" onclick="return(confirm('Etes-vous sûr de vouloir supprimer?'));">Supprimer</a>

</div>