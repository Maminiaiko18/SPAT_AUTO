<%-- 
    Document   : mouvement-modif
    Created on : 5 nov. 2019, 15:19:41
    Author     : john
--%>

<%@page import="mg.spat.PrevisionLibComplet"%>
<%@page import="mg.spat.Prevision"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@page import="mg.spat.Mouvement"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Mouvement pj = new Mouvement();
    pj.setId(request.getParameter("id"));
    MouvementLibComplet mvtLibComp = pj.getMouvementLibCompletById(null);
    
    
    PageUpdate pi = new PageUpdate(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
     if(request.getParameter("idPrevision")!=null){
        Prevision prev = new Prevision();
        prev.setId(request.getParameter("idPrevision"));
        PrevisionLibComplet preveLibC = prev.getPrevisionLibCompletById(null);
        
        pi.getFormu().getChamp("escale").setDefaut(preveLibC.getId());
        pi.getFormu().getChamp("escale").setValeurLibelle(preveLibC.getEscale());
        pi.getFormu().getChamp("navire").setDefaut(preveLibC.getNavire());
        pi.getFormu().getChamp("navire").setValeurLibelle(preveLibC.getNomnavire());
        pi.getFormu().getChamp("consignataire").setDefaut(preveLibC.getConsignataire());
        pi.getFormu().getChamp("consignataire").setValeurLibelle(preveLibC.getValconsignataire());
        pi.getFormu().getChamp("provenance").setDefaut(preveLibC.getProvenance());
        pi.getFormu().getChamp("provenance").setValeurLibelle(preveLibC.getValtypequaisprovenance()+"-"+preveLibC.getValpaysprovenance());
        pi.getFormu().getChamp("cargaison").setDefaut(preveLibC.getCargaison());
        pi.getFormu().getChamp("cargaison").setValeurLibelle(preveLibC.getValcargaison());
        pi.getFormu().getChamp("destination").setDefaut(preveLibC.getDestination());
        pi.getFormu().getChamp("destination").setValeurLibelle(preveLibC.getValtypequaisdestination()+"-"+preveLibC.getValquaisdestination());
    }

    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("consignataire").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireInterneChoix.jsp");
    pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireInterneChoix.jsp");
    pi.getFormu().getChamp("cargaison").setPageAppel("choix/listeCargaisonChoixMultiple.jsp");
  
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("consignataire").setAutre("readonly");
    pi.getFormu().getChamp("destination").setAutre("readonly");
    pi.getFormu().getChamp("provenance").setAutre("readonly");
    pi.getFormu().getChamp("cargaison").setAutre("readonly");
    
    pi.getFormu().getChamp("typeMvt").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("daty").setVisible(false);
    
    if(mvtLibComp != null){
        pi.getFormu().getChamp("consignataire").setValeurLibelle(mvtLibComp.getValconsignataire());
        pi.getFormu().getChamp("navire").setValeurLibelle(mvtLibComp.getNomnavire());
        pi.getFormu().getChamp("escale").setDefaut(mvtLibComp.getIdprevision());
        pi.getFormu().getChamp("escale").setValeurLibelle(mvtLibComp.getEscale());
        pi.getFormu().getChamp("cargaison").setValeurLibelle(mvtLibComp.getValcargaison());
        pi.getFormu().getChamp("navire").setDefaut(mvtLibComp.getNavire());
        pi.getFormu().getChamp("PROVENANCE").setDefaut(mvtLibComp.getProvenance());
        pi.getFormu().getChamp("CONSIGNATAIRE").setDefaut(mvtLibComp.getConsignataire());
        pi.getFormu().getChamp("cargaison").setDefaut(mvtLibComp.getCargaison());
        if(request.getParameter("typemvt")!=null && request.getParameter("typemvt").equals(Constante.tpmvtdepart)){
            pi.getFormu().getChamp("provenance").setValeurLibelle(mvtLibComp.getValpaysdestination()+"-"+mvtLibComp.getValquaisdestination());
            pi.getFormu().getChamp("provenance").setDefaut(mvtLibComp.getDestination());
            pi.getFormu().getChamp("heure_depart").setDefaut(Utilitaire.heureCouranteHMS());
            pi.getFormu().getChamp("date_depart").setDefaut(Utilitaire.dateDuJour());
            pi.getFormu().getChamp("heure").setVisible(false);
            pi.getFormu().getChamp("datearrivee").setVisible(false);
        }
        else{
            
            pi.getFormu().getChamp("heure").setDefaut(Utilitaire.heureCouranteHMS());
            pi.getFormu().getChamp("dateArrivee").setDefaut(Utilitaire.dateDuJour());
            pi.getFormu().getChamp("provenance").setValeurLibelle(mvtLibComp.getValpaysprovenance()+"-"+mvtLibComp.getValquaisprovenance());
            pi.getFormu().getChamp("destination").setValeurLibelle(mvtLibComp.getValpaysdestination()+" - "+mvtLibComp.getValquaisdestination());
            pi.getFormu().getChamp("destination").setDefaut(mvtLibComp.getDestination());
            pi.getFormu().getChamp("heure_depart").setVisible(false);
            pi.getFormu().getChamp("date_depart").setVisible(false);

        }
//        pi.getFormu().getChamp("heure").setDefaut(mvtLibComp.getHeure());
    }
    
    pi.getFormu().getChamp("heure").setLibelle("Heure d'arrivee");
    pi.getFormu().getChamp("date_depart").setLibelle("Date depart");
    pi.getFormu().getChamp("heure_depart").setLibelle("Heure de depart");
    pi.getFormu().getChamp("dateArrivee").setLibelle("Date Arrivee");
    pi.getFormu().getChamp("escale").setPageAppel("choix/listePrevisionChoix.jsp");
    pi.getFormu().getChamp("escale").setAutre("readonly");
    pi.getFormu().getChamp("navire").setLibelle("Navire");
    pi.getFormu().getChamp("PROVENANCE").setLibelle("Provenance");
    pi.getFormu().getChamp("DESTINATION").setLibelle("Quai");
    pi.getFormu().getChamp("CONSIGNATAIRE").setLibelle("Consignataire");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
       
        <div class="col-md-offset-2 col-md-8">
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/mouvement-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Mouvement">
                      
                        <input name="nomtable" type="hidden" id="nomtable" value="mouvement">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    }catch(Exception e){
        e.printStackTrace();
    }
%>