<%-- 
    Document   : navire-modif
    Created on : 5 nov. 2019, 15:41:21
    Author     : john
--%>

<%@page import="mg.spat.StatistiqueActivite"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try{
    StatistiqueActivite stat = new StatistiqueActivite();
    stat.setNomTable("statistiqueActivite");
    PageUpdate pi = new PageUpdate(stat, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    stat = (StatistiqueActivite)pi.getBase();
    String mode = stat.getTypeSaisie();
    
    pi.getFormu().getChamp("titre").setLibelle("Titre");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("typesaisie").setVisible(false);
    
    if(mode.compareToIgnoreCase("TS0001")==0){
        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet cons = new TypeObjet();
        cons.setNomTable("typeActionConteneur");
        liste[0] = new Liste("idtypeActionConteneur", cons, "VAL", "id");
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("idtypeActionConteneur").setLibelle("Type Action Conteneur");  
        pi.getFormu().getChamp("Plein20Pieds").setLibelle("20 pieds plein");
        pi.getFormu().getChamp("Vide20Pieds").setLibelle("20 pieds vide");
        pi.getFormu().getChamp("Plein40Pieds").setLibelle("40 pieds plein");
        pi.getFormu().getChamp("Vide40Pieds").setLibelle("40 pieds vide");    
        pi.getFormu().getChamp("idnomsociete").setVisible(false);
        pi.getFormu().getChamp("idtypemanipulation").setVisible(false);
        pi.getFormu().getChamp("idtypemarchandise").setVisible(false);
        pi.getFormu().getChamp("idtypemesure").setVisible(false);
        pi.getFormu().getChamp("nombreunite").setVisible(false);
        pi.getFormu().getChamp("poids").setVisible(false);
    }else if(mode.compareToIgnoreCase("TS0002")==0){
        affichage.Champ[] liste = new affichage.Champ[4];
        TypeObjet cons = new TypeObjet();
        cons.setNomTable("nomsociete");
        liste[0] = new Liste("idnomsociete", cons, "VAL", "id");
        TypeObjet cons1 = new TypeObjet();
        cons1.setNomTable("typemanipulation");
        liste[1] = new Liste("idtypemanipulation", cons1, "VAL", "id");
        TypeObjet cons2 = new TypeObjet();
        cons2.setNomTable("typemarchandise");
        liste[2] = new Liste("idtypemarchandise", cons2, "VAL", "id");
        TypeObjet cons3 = new TypeObjet();
        cons3.setNomTable("typemesure");
        liste[3] = new Liste("idtypemesure", cons3, "VAL", "id");
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("idnomsociete").setLibelle("Nom société");  
        pi.getFormu().getChamp("idtypemanipulation").setLibelle("Type de manipulation");  
        pi.getFormu().getChamp("idtypemarchandise").setLibelle("Type de marchandise");  
        pi.getFormu().getChamp("idtypemesure").setLibelle("Type de mesure");  
        pi.getFormu().getChamp("nombreunite").setLibelle("Nombre d'unite");  
        pi.getFormu().getChamp("poids").setLibelle("Poids");
        pi.getFormu().getChamp("idtypeActionConteneur").setVisible(false);
        pi.getFormu().getChamp("Plein20Pieds").setVisible(false);
        pi.getFormu().getChamp("Vide20Pieds").setVisible(false);
        pi.getFormu().getChamp("Plein40Pieds").setVisible(false);
        pi.getFormu().getChamp("Vide40Pieds").setVisible(false);
    }
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification statistiques</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="stat" id="stat">
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
                        <input name="bute" type="hidden" id="bute" value="statistique/statistique-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.StatistiqueActivite">
                        <input name="nomtable" type="hidden" id="nomtable" value="statistiqueActivite">
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
