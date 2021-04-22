<%@page import="mg.cnaps.formation.FormEtablissement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    FormEtablissement a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new FormEtablissement();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    
    affichage.Champ[] liste=new affichage.Champ[1];
    
    TypeObjet fn = new TypeObjet();
    fn.setNomTable("pays");
    liste[0] = new Liste("pays", fn, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("nom").setLibelle("Nom"); 
    pi.getFormu().getChamp("specialisation").setLibelle("Sp&eacute;cialisation");
    pi.getFormu().getChamp("date_anciennete").setLibelle("Date de création");
    pi.getFormu().getChamp("adresse").setLibelle("Adresse"); 
    pi.getFormu().getChamp("pays").setLibelle("Pays"); 
    pi.getFormu().getChamp("valeur").setLibelle("Valeur"); 
    pi.getFormu().getChamp("contact").setLibelle("Contact"); 
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'un &Eacute;tablissement</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formetablissement">
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
                        <input name="bute" type="hidden" id="bute" value="configuration/etablissement-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormEtablissement">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="form_etablissement">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
