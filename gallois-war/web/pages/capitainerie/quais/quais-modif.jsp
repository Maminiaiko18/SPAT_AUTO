
<%@page import="mg.spat.Quais"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Prevision"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Quais quai = new Quais();
    PageUpdate pi = new PageUpdate(quai, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("typequais");
    liste[0] = new Liste("typequais", mvt, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("val").setLibelle("Nom");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("typeQuais").setLibelle("type Quais");
     pi.getFormu().getChamp("pays").setPageAppel("choix/listePaysChoix.jsp");
    pi.getFormu().getChamp("pays").setAutre("readonly");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification Quais</h1>
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/quais/quais-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Quais">
                        <input name="nomtable" type="hidden" id="nomtable" value="quais">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
          