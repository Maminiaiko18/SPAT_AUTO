<%-- 
    Document   : navire-modif
    Created on : 5 nov. 2019, 15:41:21
    Author     : john
--%>

<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Armateur"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Navire navire = new Navire();
    navire.setNomTable("NAVIRE");
    PageUpdate pi = new PageUpdate(navire, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet liste1 = new TypeObjet();
    liste1.setNomTable("typenavire");
    liste[0] = new Liste("type", liste1, "val", "id");
    pi.getFormu().changerEnChamp(liste);
     pi.getFormu().getChamp("pavillon").setPageAppel("choix/listePaysChoix.jsp");
    pi.getFormu().getChamp("pavillon").setAutre("readonly");
     pi.getFormu().getChamp("armateur").setPageAppel("choix/listeArmateurTBDChoix.jsp","armateur;armateurlibelle");
    pi.getFormu().getChamp("armateur").setAutre("readonly");
    pi.getFormu().getChamp("reference").setLibelle("R&eacute;f&eacute;rence");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("volume").setVisible(false);
    pi.preparerDataFormu();
		Navire tempNav = (Navire) pi.getBase();
		TypeObjet armateur = new TypeObjet();
		armateur = (TypeObjet) armateur.getById(pi.getFormu().getChamp("armateur").getValeur(),"armateur_TBD",null);
		%>
<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification navire</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/navire-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Navire">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="navire">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
	$("#armateurlibelle").val("<%=Utilitaire.champNull(armateur.getVal())%>");
</script>
