
<%@page import="mg.spat.PrevisionLibComplet"%>
<%@ page import="user.UserEJB"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PrevisionLibComplet prevision=new PrevisionLibComplet();
    prevision.setNomTable("PREVISIONLIBCOMPLET_ORDRE");
    PageUpdate pi = new PageUpdate(prevision, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    PrevisionLibComplet copie = (PrevisionLibComplet) pi.getBase();
      
    pi.getFormu().getChamp("date_arrivee").setLibelle("Date d'arrivée");
    pi.getFormu().getChamp("heure_arrivee").setLibelle("Heure d'arrivée");
    pi.getFormu().getChamp("date_depart").setLibelle("Date de départ");
    //pi.getFormu().getChamp("date_depart").setVisible(false);
    pi.getFormu().getChamp("heure_depart").setLibelle("Heure de départ");
    pi.getFormu().getChamp("date_rade").setLibelle("Date rade");
    pi.getFormu().getChamp("pilote").setLibelle("Commandant");
    pi.getFormu().getChamp("noVoyage").setLibelle("No voyage");
    pi.getFormu().getChamp("date_arrivee").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("heure_arrivee").setDefaut(Utilitaire.getHeureActuel());
    pi.getFormu().getChamp("date_rade").setVisible(false);
    pi.getFormu().getChamp("destination").setAutre("readonly");
    
    pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireExterneChoix.jsp");
    pi.getFormu().getChamp("provenance").setValeurLibelle(copie.getValpaysprovenance()+" - "+copie.getValquaisprovenance());
    pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireInterneChoix.jsp");    
    pi.getFormu().getChamp("pilote").setPageAppel("choix/piloteChoix.jsp");
    pi.getFormu().getChamp("pilote").setAutre("readonly");     
    pi.getFormu().getChamp("consignataire").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("consignataire").setAutre("readonly");
    
    pi.getFormu().getChamp("armateur").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("armateur").setAutre("readonly");
    
    pi.getFormu().getChamp("pilote").setValeurLibelle(copie.getValpilote());
    pi.getFormu().getChamp("cargaison").setValeurLibelle(copie.getValcargaison());
    pi.getFormu().getChamp("consignataire").setValeurLibelle(copie.getValconsignataire());
    pi.getFormu().getChamp("navire").setValeurLibelle(copie.getNomnavire());
    pi.getFormu().getChamp("destination").setValeurLibelle(copie.getValpaysdestination()+" - "+copie.getValquaisdestination());
    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("destination").setLibelle("Quai");
    
    pi.getFormu().getChamp("cargaison").setPageAppel("choix/listeCargaisonChoix.jsp");
    pi.getFormu().getChamp("cargaison").setAutre("readonly");
    pi.getFormu().getChamp("provenance").setAutre("readonly");
    
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("Armateurlib").setVisible(false);
    pi.getFormu().getChamp("quaiprovenance").setVisible(false);
    pi.getFormu().getChamp("internepovenance").setVisible(false);
    pi.getFormu().getChamp("paysprovenance").setVisible(false);
   
    pi.getFormu().getChamp("Nomnavire").setVisible(false);
    pi.getFormu().getChamp("referencenavire").setVisible(false);
    pi.getFormu().getChamp("etatnavire").setVisible(false);
    pi.getFormu().getChamp("profondeurdestination").setVisible(false);
    pi.getFormu().getChamp("tirantdestination").setVisible(false);
    pi.getFormu().getChamp("longueurdestination").setVisible(false);
    pi.getFormu().getChamp("volumenavire").setVisible(false);
    pi.getFormu().getChamp("tenavire").setVisible(false);
    pi.getFormu().getChamp("lmnavire").setVisible(false);
    pi.getFormu().getChamp("lhtnavire").setVisible(false);
    pi.getFormu().getChamp("pltnavire").setVisible(false);
    pi.getFormu().getChamp("jbtnavire").setVisible(false);
    pi.getFormu().getChamp("jntnavire").setVisible(false);
    pi.getFormu().getChamp("profondeurprovenance").setVisible(false);
    pi.getFormu().getChamp("tirantprovenance").setVisible(false);
    pi.getFormu().getChamp("longueurprovenance").setVisible(false);
    pi.getFormu().getChamp("typequaisdestination").setVisible(false);
    pi.getFormu().getChamp("typequaisprovenance").setVisible(false);
    pi.getFormu().getChamp("descequaisdestination").setVisible(false);
    pi.getFormu().getChamp("valquaisdestination").setVisible(false);
    pi.getFormu().getChamp("descequaisprovenance").setVisible(false);
    pi.getFormu().getChamp("valquaisprovenance").setVisible(false);
    pi.getFormu().getChamp("descetypequaisdestination").setVisible(false);
    pi.getFormu().getChamp("valtypequaisdestination").setVisible(false);
    pi.getFormu().getChamp("descetypequaisprovenance").setVisible(false);
    pi.getFormu().getChamp("descetypequaisprovenance").setVisible(false);
    pi.getFormu().getChamp("valtypequaisprovenance").setVisible(false);
    pi.getFormu().getChamp("valpaysdestination").setVisible(false);
    pi.getFormu().getChamp("valpaysprovenance").setVisible(false);
    pi.getFormu().getChamp("paysdestination").setVisible(false);
    pi.getFormu().getChamp("internedestination").setVisible(false);
    pi.getFormu().getChamp("quaidestination").setVisible(false);
    pi.getFormu().getChamp("descepilote").setVisible(false);
    pi.getFormu().getChamp("valpilote").setVisible(false);
    pi.getFormu().getChamp("descecargaison").setVisible(false);
    pi.getFormu().getChamp("pavillonnavire").setVisible(false);
    pi.getFormu().getChamp("remarquenavire").setVisible(false);
    pi.getFormu().getChamp("valconsignataire").setVisible(false);
    pi.getFormu().getChamp("desceconsignataire").setVisible(false);
    pi.getFormu().getChamp("valcargaison").setVisible(false);
    pi.getFormu().getChamp("tonnage").setLibelle("Tonnage deb. prev.");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/quais/quais-prevision-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Prevision">
                        <input name="nomtable" type="hidden" id="nomtable" value="prevision">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
          
<%}catch(Exception e){
    e.printStackTrace();
}%>