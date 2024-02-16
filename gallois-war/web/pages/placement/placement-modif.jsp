
<%@page import="mg.spat.placement.Placement"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Placement placement = new Placement();
    //placement.setNomTable("placementordre");
    PageUpdate pi = new PageUpdate(placement, request, (user.UserEJB) session.getValue("u"));
     affichage.Champ[] liste = new affichage.Champ[5];
     
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("entite");
    liste[0] = new Liste("entite", mvt, "VAL", "id");
    
    TypeObjet b = new TypeObjet();
    b.setNomTable("BANQUE");
    liste[1] = new Liste("banque", b, "VAL", "id");
    
    TypeObjet op = new TypeObjet();
    op.setNomTable("DEVISE");
    liste[2] = new Liste("iddevise", op, "desce", "id");

    String[] aff = {"360 jours","365 jours"};
    String[] val = {"360", "365"};
    liste[3] = new Liste("annee", aff, val);

    TypeObjet type = new TypeObjet();
    type.setNomTable("TYPEINTERET");
    liste[4] = new Liste("typeinteret", type, "desce", "id");


    pi.getFormu().getChamp("date_placement").setLibelle("Date placement");
    pi.getFormu().getChamp("date_echeance").setLibelle("Date &eacute;ch&eacute;ance");

    pi.getFormu().getChamp("banque").setLibelle("Banque");
    pi.getFormu().getChamp("numero").setLibelle("R&eacute;f&eacute;rence");
    
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("dateechu").setVisible(false);
    pi.getFormu().getChamp("annee").setLibelle("Ann&eacute;e");
    pi.getFormu().getChamp("Typeinteret").setLibelle("Type inter&ecirc;t");
    pi.getFormu().getChamp("iddevise").setAutre("onblur=\"dependanteChampUneValeur(this.value, 'montantdevise', 'coursdevise', 'fin.Coursdevise', 'iddevise', 'iddevise', 'montant','daty','desc');\"");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("montantdevise").setVisible(false);
    pi.getFormu().getChamp("disponible").setVisible(false);
    pi.getFormu().getChamp("ancienPlacement").setLibelle("Placement");
    pi.getFormu().getChamp("ancienPlacement").setAutre("readonly");
    pi.getFormu().getChamp("ancienPlacement").setPageAppel("choix/listePlacementChoix.jsp");
    
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    pi.preparerDataFormu();
%> 

<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
        <div class="col-md-6 col-md-offset-3">
            <div class="">
                <div class="box">
                    <h1>Modification placement</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
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
                        <input name="bute" type="hidden" id="bute" value="placement/placement-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.placement.Placement">
                        <input name="nomtable" type="hidden" id="nomtable" value="placement">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
