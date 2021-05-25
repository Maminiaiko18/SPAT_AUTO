<%@page import="mg.spat.Tiers"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Tiers tiers = new Tiers();
    PageUpdate pi = new PageUpdate(tiers, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("type");
    String [] val = {"partenaire", "prestataire"};
    String [] aff = {"Partenaire", "Prestataire"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("etat").setVisible(false); 
    
    pi.getFormu().getChamp("compteAuxFournisseur").setLibelle("Compte Fournisseur"); 
    pi.getFormu().getChamp("compteAuxClient").setLibelle("Compte Client");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
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
                    <input name="bute" type="hidden" id="bute" value="travaux/tiers-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="mg.spat.Tiers">
                    <input name="nomtable" type="hidden" id="nomtable" value="tiers">
                </form>
            </div>
        </div>
    </div>
</div>