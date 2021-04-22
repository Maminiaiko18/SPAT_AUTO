<%-- 
    Document   : pourcentage-realisation-modif
    Created on : 29 janv. 2020, 11:43:27
    Author     : john
--%>

<%@page import="mg.spat.travaux.PourcentageProjetComplet"%>
<%@page import="mg.spat.travaux.PourcentageProjet"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
//    PourcentageProjet c = new PourcentageProjet();
//    c.setNomTable("pourcentageProjetLib");
    PourcentageProjetComplet c = new PourcentageProjetComplet();
    PageUpdate pi = new PageUpdate(c, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("idChantier").setPageAppel("choix/listeChantier.jsp");
    pi.getFormu().getChamp("idChantier").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idUtilisateur").setVisible(false);
    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("nom").setVisible(false);
    pi.getFormu().getChamp("idUtilisateur").setAutre("readonly");
    pi.preparerDataFormu();

    c = (PourcentageProjetComplet) pi.getBase();
    pi.getFormu().getChamp("idChantier").setValeurLibelle(c.getNom());
    pi.getFormu().getChamp("idChantier").setLibelle("Chantier");
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
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
                    <input name="bute" type="hidden" id="bute" value="travaux/pourcentage-realisation-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="mg.spat.travaux.PourcentageProjet">
                    <input name="nomtable" type="hidden" id="nomtable" value="pourcentageprojet">
                </form>
            </div>
        </div>
    </div>
</div>