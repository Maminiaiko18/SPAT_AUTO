<%-- 
    Document   : coursdevise-modif
    Created on : 2 févr. 2021, 17:19:53
    Author     : andya
--%>
<%@page import="fin.Coursdevise"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    Coursdevise a;
    
%>
<%
    try{
   String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new Coursdevise();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("daty").setLibelle("Date");
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet typeAvoir = new TypeObjet();
    typeAvoir.setNomTable("devise");
    liste[0] = new Liste("iddevise", typeAvoir, "val", "id");
    String[]ajoutValeur={"0","1"};
    String ajoutAffiche[]={"Non","Oui"};
    liste[1]=new Liste("estMICTSL"); 
    ((Liste)liste[1]).ajouterValeur(ajoutValeur,ajoutAffiche);
    
    pi.getFormu().changerEnChamp(liste);
    
    String[] ordre = {"id","daty","iddevise", "montant", "estMICTSL"};
    pi.getFormu().setOrdre(ordre);
    
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("estMICTSL").setLibelle("Est MICTSL");   

    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <div class="box">
                <div class="box">
                    <h1>Modification cours devise</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
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
                        <input name="bute" type="hidden" id="bute" value="fin/coursdevise-fiche.jsp?id=<%=request.getParameter("id") %>">
                        <input name="classe" type="hidden" id="classe" value="fin.Coursdevise">
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