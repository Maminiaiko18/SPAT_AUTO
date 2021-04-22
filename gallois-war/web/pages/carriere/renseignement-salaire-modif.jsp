
<%@page import="mg.spat.relationhumaine.InfoSalaire"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    InfoSalaire ident = new InfoSalaire();
    PageUpdate pi = new PageUpdate(ident, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
   
   pi.getFormu().getChamp("indemnite_fonction").setLibelle("Indemnité de fonction");
    pi.getFormu().getChamp("indemnite_conge_paye").setLibelle("Indemnité congé payé");
    pi.getFormu().getChamp("indemnite_deplacement").setLibelle("Indemnité de déplacement");
    pi.getFormu().getChamp("indemnite_risque").setLibelle("Indemnité de risque");
    pi.getFormu().getChamp("autre_avantage").setLibelle("Autre avantage");
    pi.getFormu().getChamp("mode_paiement").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("numero_virement").setLibelle("Numero de virement");
    pi.getFormu().getChamp("numero_cnaps").setLibelle("Numero cnaps");
    pi.getFormu().getChamp("salaire_base").setLibelle("Salaire de base");
    
    pi.getFormu().getChamp("idindemnite").setVisible(false);
    pi.getFormu().getChamp("idavantagenature").setVisible(false);
    
    pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
    
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
                        <input name="bute" type="hidden" id="bute" value="carriere/renseignement-salaire-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.InfoSalaire">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>