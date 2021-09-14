<%-- 
    Document   : journalcaisse-modif
    Created on : 6 nov. 2019, 12:07:39
    Author     : Tin
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    JournalCaisse jc = new JournalCaisse();
    jc.setNomTable("journalcaisse");
    PageUpdate pi = new PageUpdate(jc, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");

    pi.getFormu().getChamp("numcheque").setLibelle("Numero chèque");
    pi.getFormu().getChamp("idordre").setLibelle("Ordre");
    pi.getFormu().getChamp("idordre").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("typemvt").setVisible(false);
    affichage.Champ[] liste = new affichage.Champ[5];
    TypeObjet typeObjet = new TypeObjet();
    TypeObjet esc = new TypeObjet();
        esc.setNomTable("CAISSE_LIB");
        liste[0] = new Liste("caisse", esc, "VAL", "id");
        TypeObjet cheque = new TypeObjet();
        cheque.setNomTable("TYPECHEQUE");
        liste[1] = new Liste("idTypeCheque", cheque, "VAL", "id");
        
        TypeObjet op = new TypeObjet();
        op.setNomTable("DEVISE");
        liste[2] = new Liste("iddevise", op, "desce", "id");   
        
        TypeObjet mode = new TypeObjet();
        mode.setNomTable("MODEPAIEMENT");
        liste[3] = new Liste("idmode", mode, "desce", "id");   
        
        TypeObjet banque = new TypeObjet();
        banque.setNomTable("banque");
        liste[4] = new Liste("idbanque", banque, "desce", "id");   
        
        pi.getFormu().changerEnChamp(liste);
        
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("idbanque").setLibelle("Banque");
    pi.getFormu().getChamp("idmode").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("dateSaisie").setVisible(false);
    pi.getFormu().getChamp("dateEffet").setLibelle("Date");
    pi.getFormu().getChamp("numPiece").setLibelle("Num&eacute;ro pi&egrave;ce");
    pi.getFormu().getChamp("idTypeCheque").setLibelle("Type ch&egrave;que");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idplacement").setAutre("readonly");
    pi.getFormu().getChamp("idplacement").setLibelle("Source");
    
    pi.getFormu().getChamp("debit").setLibelle("Crédit");
    pi.getFormu().getChamp("credit").setLibelle("Débit");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification journal de caisse</h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
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
                    <input name="bute" type="hidden" id="bute" value="treso/recette-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="mg.spat.JournalCaisse">
                    <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                    <input name="nomtable" type="hidden" id="nomtable" value="journalcaisse">
                </form>
            </div>
        </div>
    </div>
</div>
<%
    }catch(Exception ex){
        ex.printStackTrace();
    }
%>