<%@page import="projet.Projet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    Projet a ;
    
%>
<%
   String autreparsley = "data-parsley-range='[8, 40]' required";
    a =  new Projet();
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("section_budget").setLibelle("section budget");
    pi.getFormu().getChamp("section_budget").setVisible(false);
    pi.getFormu().getChamp("montant_credit").setLibelle("montant credit");
    pi.getFormu().getChamp("compte").setVisible(false);
    pi.getFormu().getChamp("montant_credit").setVisible(false);
    pi.getFormu().getChamp("engage").setVisible(false);
    pi.getFormu().getChamp("liquide").setVisible(false);
    pi.getFormu().getChamp("paye").setVisible(false);
    pi.getFormu().getChamp("exercice").setVisible(false);
    pi.getFormu().getChamp("programme").setVisible(false);
    pi.getFormu().getChamp("activite").setVisible(false);
    pi.getFormu().getChamp("objectif").setVisible(false);
    pi.getFormu().getChamp("designation").setLibelle("Code");
            
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="">
                <div class="box">
                    <h1>Modification projet</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn btn-warning pull-right" name="Submit2" type="submit">Enregistrer les modifications</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="budget/projet-fiche.jsp?id=<%=request.getParameter("id") %>">
                        <input name="classe" type="hidden" id="classe" value="projet.Projet">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('label[for="id"]').remove();
</script>
