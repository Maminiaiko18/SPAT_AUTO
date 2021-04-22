<%@page import="mg.spat.HistoriqueSyndicat"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    HistoriqueSyndicat syndicat = new HistoriqueSyndicat();
    PageUpdate pi = new PageUpdate(syndicat, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("idsyndicat").setLibelle("Syndicat");
    pi.getFormu().getChamp("idsyndicat").setPageAppel("choix/listeSyndicatChoix.jsp");
    pi.getFormu().getChamp("idsyndicat").setAutre("readonly");
    pi.getFormu().getChamp("idpersonnel").setLibelle("Personnel");
    pi.getFormu().getChamp("idpersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
    pi.getFormu().getChamp("idpersonnel").setAutre("readonly");
    pi.getFormu().getChamp("daty").setAutre("Date");
    pi.getFormu().getChamp("idposte").setLibelle("Poste");
    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("poste");
    liste[0] = new Liste("idposte", mvt, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("etat").setVisible(false);
    
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
                        <input name="bute" type="hidden" id="bute" value="syndicat/historique-syndicat-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.HistoriqueSyndicat">
                        <input name="nomtable" type="hidden" id="nomtable" value="historiquesyndicat">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>