

<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@page import="mg.spat.RemboursementPlacement"%>
<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    RemboursementPlacement liaisonP = new RemboursementPlacement();
    PageUpdate pi = new PageUpdate(liaisonP, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idplacement").setPageAppel("choix/listePlacementChoix.jsp");
    pi.getFormu().getChamp("idplacement").setAutre("readonly");
    
   
    if(request.getParameter("idplacement") != null){
        PlacementLibComplet[] data = (PlacementLibComplet[]) CGenUtil.rechercher(new PlacementLibComplet(), null, null, " and id='"+request.getParameter("idplacement")+"'");
        pi.getFormu().getChamp("idplacement").setDefaut(request.getParameter("idplacement"));
        pi.getFormu().getChamp("montantplace").setDefaut(Utilitaire.formaterAr(data[0].getMontant()));
        pi.getFormu().getChamp("interet").setDefaut(Utilitaire.formaterAr(data[0].getInteret_net()));
    }
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idplacement").setLibelle("Placement");
    pi.getFormu().getChamp("montantplace").setLibelle("Montant plac&eacute;");
    pi.getFormu().getChamp("interet").setLibelle("Int&eacute;r&egrave;t");
    pi.getFormu().getChamp("etat").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("caisse");
    liste[0] = new Liste("caisse", mvt, "VAL", "id");
   
    pi.getFormu().changerEnChamp(liste);
    
    
    
    pi.setLien((String) session.getValue("lien"));
    
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    
    pi.preparerDataFormu();
    

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
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
                        <input name="bute" type="hidden" id="bute" value="placement/remboursement-placement-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.RemboursementPlacement">
                        <input name="nomtable" type="hidden" id="nomtable" value="remboursementPlacement">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
                        
                        
                