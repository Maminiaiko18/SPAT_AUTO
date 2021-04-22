<%-- 
    Document   : journalcaisse-modif
    Created on : 6 nov. 2019, 12:07:39
    Author     : Tin
--%>

<%@page import="mg.spat.Billetage"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Billetage b = new Billetage();
    b.setNomTable("billetagelib");
    PageUpdate pi = new PageUpdate(b, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("etat").setVisible(false);
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet typeObjet = new TypeObjet();
    typeObjet.setNomTable("caisse");
    liste[0] = new Liste("caisse", typeObjet, "val", "id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row"> 
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
                        <input name="bute" type="hidden" id="bute" value="treso/billetage-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Billetage">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="billetage">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

