<%@page import="mg.spat.Armateur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.cnaps.formation.FormAbsence"%>

<%
    try{
     String nomtable = "armateur";
    UserEJB u;
    Armateur a  = new Armateur();
    a.setNomTable(nomtable);
    String autreparsley = "data-parsley-range='[8, 40]' required";
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
     
    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("contact").setLibelle("Contact");
    pi.getFormu().getChamp("adresse").setLibelle("Adresse");
    pi.getFormu().getChamp("nif").setLibelle("Nif");
    pi.getFormu().getChamp("stat").setLibelle("Stat");
    pi.getFormu().getChamp("mail").setLibelle("E-mail");
   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'un Armateur</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formabsence">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="capitainerie/armateur/armateur-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Armateur">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
}catch(Exception ex){
ex.printStackTrace();
}%>          
               