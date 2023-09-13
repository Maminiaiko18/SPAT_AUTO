

<%@page import="utilisateur.Prioritaire"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%
    try {
        UserEJB u;
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Prioritaire p = new Prioritaire();
        p.setNomTable("prioritaire");
        PageUpdate pi = new PageUpdate(p, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("refuser").setPageAppel("choix/listeUtilisateurChoix.jsp");
        pi.getFormu().getChamp("refuser").setAutre("readonly");
        pi.getFormu().getChamp("refuser").setAutre("readonly");
        pi.getFormu().getChamp("refuser").setLibelle("Numéro Utilisateur");
        pi.getFormu().getChamp("idrole").setPageAppel("choix/listeRoleChoix.jsp");
        pi.getFormu().getChamp("idrole").setAutre("readonly");
        pi.getFormu().getChamp("idrole").setLibelle("Role");
        pi.getFormu().getChamp("rang").setLibelle("readonly");
        pi.getFormu().getChamp("rang").setLibelle("Rang");
        pi.getFormu().getChamp("rang").setAutre("Rang");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("id").setVisible(false);

        p = (Prioritaire) pi.getBase();
            pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <!--<div class="box-fiche">-->
            <div class="box">
                <h1>Modification prioritaire</h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formabsence">
                    <%
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <div class="row">
                        <div class="col-md-11">
                            <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                        </div>
                        <br><br> 
                    </div>
                    <input name="acte" type="hidden" id="acte" value="updateSimple">
                    <input name="bute" type="hidden" id="bute" value="prioritaire/prioritaire-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="utilisateur.Prioritaire">
                </form>
            </div>
            <!--</div>-->
        </div>
    </div>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>