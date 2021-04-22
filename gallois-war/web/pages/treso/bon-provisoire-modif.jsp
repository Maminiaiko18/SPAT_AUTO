<%-- 
    Document   : bon-provisoire-modif
    Created on : 30 nov. 2019, 13:38:48
    Author     : rajao
--%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%@ page import="mg.spat.BonProvisoire"%>
<%@ page import="mg.spat.Caisse"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BonProvisoire bonprovisoire=new BonProvisoire();
    PageUpdate pi = new PageUpdate(bonprovisoire, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
     affichage.Champ[] liste = new affichage.Champ[1];
     
    Caisse caisse=new Caisse();
    caisse.setNomTable("CAISSE_UNIQUEMENT"); //soloina
    liste[0]=new Liste("caisse",caisse,"VAL","id");
    pi.getFormu().changerEnChamp(liste);
     
    pi.getFormu().getChamp("numpiece").setLibelle("numero pièce");
    pi.getFormu().getChamp("datesaisie").setLibelle("Date du saisie");
    pi.getFormu().getChamp("dateeffet").setLibelle("Date Effet");
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.getFormu().getChamp("beneficiaire").setPageAppel("choix/listePersonnelChoix.jsp");
    pi.getFormu().getChamp("beneficiaire").setAutre("readonly");

    pi.getFormu().getChamp("debit").setLibelle("Montant");
    pi.getFormu().getChamp("credit").setVisible(false);    
    pi.getFormu().getChamp("folio").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="">
                <div class="box">
                    <h1>Modification bon provisoire</h1>
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
                        <input name="bute" type="hidden" id="bute" value="treso/bon-provisoire-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.BonProvisoire">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="bon_provisoire">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>