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
    jc.setNomTable("JOURNALCAISSE");
    PageUpdate pi = new PageUpdate(jc, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    jc =(JournalCaisse)pi.getBase();
    UserEJB u = (UserEJB) session.getAttribute("u");
    String idUser = String.valueOf(u.getUserEJBBeanInstance().getUser().getRefuser());
    if(idUser.compareToIgnoreCase("1060")!=0 ) {
        if(idUser.compareToIgnoreCase("1602")!=0){
            pi.getFormu().getChamp("dateEffet").setVisible(false);
        }
    }
    pi.getFormu().getChamp("numcheque").setLibelle("Numero ch�que");
    pi.getFormu().getChamp("idordre").setLibelle("Ordre");
    pi.getFormu().getChamp("idordre").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("typemvt").setVisible(false);
    pi.getFormu().getChamp("Etatversement").setVisible(false);

    affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet banque = new TypeObjet();
        banque.setNomTable("banque");
        liste[0] = new Liste("idbanque", banque, "desce", "id");   
        pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("idbanque").setLibelle("Banque");
    pi.getFormu().getChamp("idmode").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("libelle").setType("textarea");
    pi.getFormu().getChamp("dateSaisie").setVisible(false);
    pi.getFormu().getChamp("dateEffet").setLibelle("Date");
    pi.getFormu().getChamp("numPiece").setLibelle("Num&eacute;ro pi&egrave;ce");
    pi.getFormu().getChamp("idTypeCheque").setLibelle("Type ch&egrave;que");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idplacement").setAutre("readonly");
    pi.getFormu().getChamp("idplacement").setLibelle("Source");
    
    pi.getFormu().getChamp("credit").setLibelle("Entr�e");
    pi.getFormu().getChamp("debit").setLibelle("Sorti");

    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("folio").setVisible(false);
    pi.getFormu().getChamp("caisse").setVisible(false);
    pi.getFormu().getChamp("numpiece").setVisible(false);
    pi.getFormu().getChamp("credit").setVisible(false);
    pi.getFormu().getChamp("debit").setVisible(false);
    pi.getFormu().getChamp("remarque").setVisible(false);
    pi.getFormu().getChamp("idTypeCheque").setVisible(false);
    pi.getFormu().getChamp("designation").setVisible(false);
    pi.getFormu().getChamp("idplacement").setVisible(false);
    pi.getFormu().getChamp("idordre").setVisible(false);
    pi.getFormu().getChamp("iddevise").setVisible(false);
    pi.getFormu().getChamp("idMode").setVisible(false);
    pi.getFormu().getChamp("Idplacementvrai").setVisible(false);
    pi.getFormu().getChamp("idtraite").setVisible(false);
    pi.getFormu().getChamp("Idfinaledestination").setVisible(false);
    pi.getFormu().getChamp("banque").setVisible(false);
    pi.preparerDataFormu();
    
%>
<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification Entete</h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
                    <%
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <div class="row">
                        <div class="col-md-11">
                            <button class="btn btn-success pull-right" name="Submit2" type="submit">Enregistrer les modifications</button>
                        </div>
                        <br><br> 
                    </div>
                    <input name="acte" type="hidden" id="acte" value="enteteJournal">
                    <input name="bute" type="hidden" id="bute" value="treso/journalcaisse-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="mg.spat.JournalCaisse">
                    <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                    <input name="nomtable" type="hidden" id="nomtable" value="journalcaisse">
                </form>
            </div>
        </div>
    </div>
</div>
<%
    System.out.println("tiers"+jc.getTiers());
%>
<script>
    document.getElementById("tiers").value = "<%= Utilitaire.champNull(jc.getTiers()) %>";
    document.getElementById("tierslibelle").value = "<%= Utilitaire.champNull(jc.getTiersLib()) %>";
</script>
<%
    }catch(Exception ex){
        ex.printStackTrace();
    }
%>