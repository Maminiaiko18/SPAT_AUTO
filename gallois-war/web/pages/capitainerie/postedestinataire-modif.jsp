<%-- 
    Document   : postedestinataire-modif
    Created on : 5 nov. 2019, 16:19:24
    Author     : john
--%>


<%@page import="mg.spat.Postedestinataire"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Postedestinataire posteDestinataire = new Postedestinataire();
    posteDestinataire.setNomTable("POSTEDESTINATAIRELIB");
    PageUpdate pi = new PageUpdate(posteDestinataire, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("quai").setPageAppel("choix/listeQuaisChoix.jsp");
    pi.getFormu().getChamp("quai").setAutre("readonly");
    pi.getFormu().getChamp("pays").setVisible(false);
    pi.getFormu().getChamp("tirant").setVisible(false);
    pi.getFormu().getChamp("longueur").setVisible(false);
    pi.getFormu().getChamp("profondeur").setVisible(false);
    pi.getFormu().getChamp("valquais").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("interne");
    String [] val = {"1", "0"};//here
    String [] aff = {"Interne", "Externe"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("interne").setLibelle("Localisation");
    
    Postedestinataire base = (Postedestinataire) pi.getBase();
    
    pi.getFormu().getChamp("quai").setValeurLibelle(base.getValquais());
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/postedestinataire-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Postedestinataire">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="postedestinataire">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
