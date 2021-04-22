<%@page import="mg.spat.Patrimoine"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    //idObjet,idTypePatrimoine,
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Patrimoine patrimoine = new Patrimoine();
    PageUpdate pi = new PageUpdate(patrimoine, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idTypePatrimoine").setLibelle("Type Patrimoine");
    pi.getFormu().getChamp("idObjet").setLibelle("Objet");
     pi.getFormu().getChamp("debut_contrat").setLibelle("debut du contrat");
      pi.getFormu().getChamp("fin_contrat").setLibelle("fin du contrat");
    pi.getFormu().getChamp("idObjet").setPageAppel("choix/listeMaterielNaval.jsp");
    pi.getFormu().getChamp("idObjet").setAutre("readonly");
    pi.getFormu().getChamp("occupant").setPageAppel("choix/listeIdentificationChoixSimple.jsp");
     pi.getFormu().getChamp("occupant").setAutre("readonly");
     affichage.Champ[] liste = new affichage.Champ[2];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("typepatrimoine");
    liste[0] = new Liste("idTypePatrimoine", mvt, "VAL", "id");
   
    pi.getFormu().getChamp("idTypePatrimoine").setAutre("readonly");
    TypeObjet etat = new TypeObjet();
    etat.setNomTable("etatpatrimoine");
    liste[1] = new Liste("etat", etat, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("etat").setLibelle("etat du patrimoine");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
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
                        <input name="bute" type="hidden" id="bute" value="patrimoine/patrimoine-fiche-RH.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Patrimoine">
                        <input name="nomtable" type="hidden" id="nomtable" value="patrimoine">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>