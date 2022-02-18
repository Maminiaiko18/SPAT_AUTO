<%-- 
    Document   : transfert-caisse-modif
    Created on : 16 janv. 2021, 01:09:34
    Author     : andya
--%>
<%@page import="mg.spat.Caisse"%>
<%@page import="mg.spat.MvttIntraCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    MvttIntraCaisse a;
    
%>
<%
   String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new MvttIntraCaisse();
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[3];
    Caisse liste1 = new Caisse();
    liste1.setNomTable("caisse");
    liste[0] = new Liste("caissedepart", liste1, "val", "id");
    liste[1] = new Liste("caissearrivee", liste1, "val", "id");
    TypeObjet liste2 = new TypeObjet();
    liste2.setNomTable("MODEPAIEMENT");
    liste[2] = new Liste("modepaiement", liste2, "val", "id");     
    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("caissedepart").setLibelle("D&eacute;part");
    pi.getFormu().getChamp("caissearrivee").setLibelle("Arriv&eacute;e");
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <!--<div class="box-fiche">-->
                <div class="box">
                    <h1>Modification mouvement caisse</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
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
                        <input name="bute" type="hidden" id="bute" value="treso/transfert-caisse-fiche.jsp?id=<%=request.getParameter("id") %>">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.MvttIntraCaisse">
                        <input name="nomtable" type="hidden" id="nomtable" value="mvtintracaisse">
                    </form>
                </div>
            <!--</div>-->
        </div>
    </div>
</div>


