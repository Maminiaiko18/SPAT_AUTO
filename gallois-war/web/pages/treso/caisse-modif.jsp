<%-- 
    Document   : caisse-modif
    Created on : 2 déc. 2019, 12:17:08
    Author     : Notiavina
--%>
<%@page import="mg.spat.Caisse"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Caisse b = new Caisse();
    PageUpdate pi = new PageUpdate(b, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("desce");
    String [] val = {"Banque", "Caisse"};
    String [] aff = {"Banque", "Caisse"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
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
                        <input name="bute" type="hidden" id="bute" value="treso/caisse-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Caisse">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="caisse">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

