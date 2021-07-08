<%@page import="mg.spat.MaterielNaval"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    MaterielNaval materielNaval = new MaterielNaval();
    //materielNaval.setNomTable("materielnavallib");
    
    PageUpdate pi = new PageUpdate(materielNaval, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    affichage.Liste[] listeD = new Liste[3];
        TypeObjet marque=new TypeObjet();
        marque.setNomTable("Marque_Materiel");
        listeD[0] = new Liste("IdMarque", marque, "val", "id");
        
        TypeObjet typeM = new TypeObjet();
        typeM.setNomTable("Type_materiel");
        listeD[1] = new Liste("IdType_materiel", typeM, "val", "id");
        
        TypeObjet cat = new TypeObjet();
        cat.setNomTable("categorie_materiel");
        listeD[2] = new Liste("idcategorie", cat, "val", "id");
    pi.getFormu().changerEnChamp(listeD);
    //pi.getFormu().getChamp("pavillon").setPageAppel("choix/listePaysChoix.jsp");
   
    /*pi.getFormu().getChamp("IdMarque").setPageAppel("choix/listeMarqueChoix.jsp");
    pi.getFormu().getChamp("IdMarque").setAutre("readonly");
    
    pi.getFormu().getChamp("IdType_materiel").setPageAppel("choix/listeTypeMaterielChoix.jsp");
    pi.getFormu().getChamp("IdType_materiel").setAutre("readonly");*/
    
    pi.getFormu().getChamp("Date_aquisition").setLibelle("Date d'aquisition");
    pi.getFormu().getChamp("IdType_materiel").setLibelle("Type de Matériel");
    pi.getFormu().getChamp("IdMarque").setLibelle("Marque");
    pi.getFormu().getChamp("IdType_materiel").setLibelle("Type de Matériel");
    pi.getFormu().getChamp("idcategorie").setLibelle("Catégorie");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/materiel/materiel-naval-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.MaterielNaval">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="Materiel_naval">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
