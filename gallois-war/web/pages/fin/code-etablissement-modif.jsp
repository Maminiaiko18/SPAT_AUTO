<%@page import="lc.Direction"%>
<%@page import="mg.cnaps.formation.CodeEtablissement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    UserEJB u;
    CodeEtablissement a;
    String nomtable = "CodeEtablissement", 
           butee = "fin/code-etablissement-fiche.jsp&id="+request.getParameter("id") ,
           classee = "mg.cnaps.formation.CodeEtablissement" ,
           titree = "Modification du code etablissement "+request.getParameter("id") ;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new CodeEtablissement();
	//a.setNomTable("FORM_DEMANDE_LIBELLE");

    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[3];
    Direction entite = new Direction();
    entite.setNomTable("direction");
    liste[0] = new Liste("desce", entite,"libelledir","iddir");
    TypeObjet entite1 = new TypeObjet();
    entite1.setNomTable("departement");
    liste[1] = new Liste("departement", entite1,"VAL","id");
    TypeObjet entite2 = new TypeObjet();
    entite2.setNomTable("service");
    liste[2] = new Liste("service", entite2,"VAL","id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("val").setLibelle("Code");
    pi.getFormu().getChamp("desce").setLibelle("Direction");
    
   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1><%= titree %></h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formabsence">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-warning pull-right" name="Submit2" type="submit">Enregistrer les modifications</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%= butee %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classee %>">
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable %>">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>