<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>
<%@ page import="ordremission.OrdreMissionLib"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        OrdreMissionLib om = new OrdreMissionLib();
        PageUpdate pi = new PageUpdate(om, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));


        pi.getFormu().getChamp("estForfaitaire").setLibelle("Forfaitaire");
        pi.getFormu().getChamp("idmotifvoyage").setLibelle("Motif de voyage");
        pi.getFormu().getChamp("idtiers").setLibelle("Tiers");
        pi.getFormu().getChamp("idindemnitemission").setLibelle("Indemnité de Mission");
        pi.getFormu().getChamp("lieudeplacement").setLibelle("Lieu de Placement");
        pi.getFormu().getChamp("datedepart").setLibelle("Date depart");
        pi.getFormu().getChamp("numOM").setLibelle("Num OM");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idmotifvoyagelib").setVisible(false);
        pi.getFormu().getChamp("idindemnitemissionlib").setVisible(false);
        pi.getFormu().getChamp("fonction").setVisible(false);
        pi.getFormu().getChamp("nom").setVisible(false);
        pi.getFormu().getChamp("prenom").setVisible(false);
        pi.getFormu().getChamp("matricule").setVisible(false);
        pi.getFormu().getChamp("idindemnitemission").setPageAppel("choix/indemnite-mission-choix.jsp");
        pi.getFormu().getChamp("idindemnitemission").setAutre("readonly");
        pi.getFormu().getChamp("idindemnitemission").setValeurLibelle(((OrdreMissionLib)pi.getBase()).getIdindemnitemissionlib());
        pi.getFormu().getChamp("idmotifvoyage").setPageAppel("choix/motif-voyage-choix.jsp");
        pi.getFormu().getChamp("idmotifvoyage").setAutre("readonly");
        pi.getFormu().getChamp("idmotifvoyage").setValeurLibelle(((OrdreMissionLib)pi.getBase()).getIdmotifvoyagelib());
        pi.getFormu().getChamp("idtiers").setPageAppel("choix/info-personnel-global-choix.jsp","idtiers;idtiers;idtierslibelle");
        pi.getFormu().getChamp("idtiers").setAutre("readonly");
        pi.getFormu().getChamp("idtiers").setValeurLibelle(((OrdreMissionLib)pi.getBase()).getNom());
        String[]valeurChampestForfaitaire = {"1", "-1"};
        String[]afficheChampestForfaitaire = {"oui", "non"};

        affichage.Liste[] lst= new affichage.Liste[1];
        lst[0] = new Liste("estForfaitaire");
        lst[0].ajouterValeur(valeurChampestForfaitaire, afficheChampestForfaitaire);
        pi.getFormu().changerEnChamp(lst);
        pi.getFormu().getChamp("estForfaitaire").setLibelle("Est Forfaitaire");

        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-7">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
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
                        <input name="bute" type="hidden" id="bute" value="ordre-mission/ordre-mission-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="ordremission.OrdreMission">
                        <input name="nomtable" type="hidden" id="nomtable" value="ordre_mission">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>