<%@page import="mg.cnaps.formation.FormOffreFormation"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    FormOffreFormation a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new FormOffreFormation();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[3];
    TypeObjet cat = new TypeObjet();
    cat.setNomTable("FORM_CATEGORIE");
    liste[0] = new Liste("form_categorie", cat, "val", "id");
    
    TypeObjet t = new TypeObjet();
    t.setNomTable("form_type");
    liste[1] = new Liste("id_type", t, "val", "id");    
    
    TypeObjet tc = new TypeObjet();
    tc.setNomTable("form_type_cout");
    liste[2] = new Liste("id_type_cout", tc, "val", "id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("id_type").setLibelle("Type");
    pi.getFormu().getChamp("id_formateur").setLibelle("Formateur");    
    pi.getFormu().getChamp("form_categorie").setLibelle("Catégorie");
    pi.getFormu().getChamp("log_service").setLibelle("Service");
    pi.getFormu().getChamp("date_debut").setLibelle("Date début");
    pi.getFormu().getChamp("date_fin").setLibelle("Date fin");
    pi.getFormu().getChamp("lieu").setLibelle("Lieu");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
    pi.getFormu().getChamp("cout_offre").setLibelle("Co&ucirc;t de l'offre");
    pi.getFormu().getChamp("etablissement").setLibelle("Etablissement");
    pi.getFormu().getChamp("id_formateur").setPageAppel("choix/formFormateurChoix.jsp");
    pi.getFormu().getChamp("log_service").setPageAppel("choix/logserviceChoix.jsp");
    pi.getFormu().getChamp("etablissement").setPageAppel("choix/formetablissementChoix.jsp");   
    pi.getFormu().getChamp("id_type_cout").setLibelle("Type Cout");
    pi.getFormu().getChamp("iduser").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    
   
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'une offre</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formoffreformation">
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
                        <input name="bute" type="hidden" id="bute" value="formation/offre-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormOffreFormation">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%= request.getParameter("id") %>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="form_offre_formation">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>