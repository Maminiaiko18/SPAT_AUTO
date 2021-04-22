
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.MaterielNaval"%>
<%@page import="mg.spat.PrevisionMaterielNavalLibComplet"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PrevisionMaterielNavalLibComplet prev = new PrevisionMaterielNavalLibComplet();
    PageUpdate pi = new PageUpdate(prev, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
   
    affichage.Champ[] liste = new affichage.Champ[2];
    
    TypeObjet cons = new TypeObjet();
    cons.setNomTable("commandant");
    liste[0] = new Liste("idcommandant", cons, "VAL", "id");
    
    TypeObjet carg = new TypeObjet();
    carg.setNomTable("natureoperation");
    liste[1] = new Liste("idnatureoperation", carg, "VAL", "id");   
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("idmateriel_naval").setPageAppel("choix/listeMaterielNavalChoix.jsp");
    pi.getFormu().getChamp("idmateriel_naval").setAutre("readonly");
    pi.getFormu().getChamp("idarrivee").setPageAppel("choix/listeMouvementArriveeChoix.jsp");
    pi.getFormu().getChamp("idarrivee").setAutre("readonly");
    pi.getFormu().getChamp("duree").setAutre("readonly");
    
    PrevisionMaterielNavalLibComplet pmnlc = (PrevisionMaterielNavalLibComplet) pi.getBase();
    
    pi.getFormu().getChamp("idmateriel_naval").setValeurLibelle(pmnlc.getDenomination());
    pi.getFormu().getChamp("idarrivee").setValeurLibelle(pmnlc.getIdarriveelib());
    
    pi.getFormu().getChamp("idclient").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idnavire").setVisible(false);
    pi.getFormu().getChamp("denomination").setVisible(false);
    pi.getFormu().getChamp("valcommandant").setVisible(false);
    pi.getFormu().getChamp("valnatureoperation").setVisible(false);
    pi.getFormu().getChamp("idarriveelib").setVisible(false);
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idarrivee").setLibelle("Arrivee");
    pi.getFormu().getChamp("date_arrivee").setLibelle("Date Début");
    pi.getFormu().getChamp("heure_arrivee").setLibelle("Heure Début");
    pi.getFormu().getChamp("date_depart").setLibelle("Date Fin");
    pi.getFormu().getChamp("heure_depart").setLibelle("Heure Fin");
    pi.getFormu().getChamp("idmateriel_naval").setLibelle("Flotte");
    pi.getFormu().getChamp("idcommandant").setLibelle("commandant");
    pi.getFormu().getChamp("idnatureoperation").setLibelle("nature operation");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="previsionnaval" id="previsionnaval">
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/previsionMaterielNaval-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.PrevisionMaterielNaval">
                        <input name="nomtable" type="hidden" id="nomtable" value="previsionMaterielNaval">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
