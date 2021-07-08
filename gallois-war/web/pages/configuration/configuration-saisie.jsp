

<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Prevision"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.configuration.*" %>

<%
    try{
    //String autreparsley = "data-parsley-range='[8, 40]' required";
    Configuration conf = new Configuration();
    PageInsert pi = new PageInsert(conf, request, (user.UserEJB) session.getValue("u"));
    /*
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet liste1 = new TypeObjet();
    liste1.setNomTable("COMMANDANT");
    liste[0] = new Liste("pilote", liste1, "val", "id");
    */
    //pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("valmin").setLibelle("Min");
    pi.getFormu().getChamp("valmax").setLibelle("Max");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("typeconfig").setVisible(false);
    pi.getFormu().getChamp("compte_credit").setVisible(false);
    
   
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie Configuration</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="configuration/configuration-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.cnaps.configuration.Configuration">
    </form>
</div>
<script>
    $('table > tbody > tr:first').before("<tr>"
            +"<th><label for='id'>ID</label></th>"+
                "<td>"+
                    "<input name='id' type='textbox' class='form-control' id='id' value=''>"+
                "</td>"+
            "</tr>"
    );
</script>
<%}catch(Exception e){
    e.printStackTrace();
}%>