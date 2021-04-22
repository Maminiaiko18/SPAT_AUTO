<%-- 
    Document   : tarifRubriqueFactureClient-modif
    Created on : 11 févr. 2021, 14:40:20
    Author     : andya
--%>

<%@page import="rubrique.TarifRubriqueFactureClient"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%
   String titre ="Modification tarif rubrique",
   bute ="facture/tarifRubriqueFactureClient-fiche.jsp&id="+request.getParameter("id"),
   classe="rubrique.TarifRubriqueFactureClient",
   nomtable = "tarifRubriqueFactureClient";
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u;
    TarifRubriqueFactureClient a = new TarifRubriqueFactureClient();
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] listeUnit = new affichage.Champ[2];
    TypeObjet branche=new TypeObjet();
    branche.setNomTable("devise");
    listeUnit[0]=new Liste("iddevise",branche,"val","id");
    
    TypeObjet branche1=new TypeObjet();
    branche1.setNomTable("natureoperation");
    listeUnit[1]=new Liste("idnature",branche1,"val","id");
    
    pi.getFormu().changerEnChamp(listeUnit);
    
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("idnature").setLibelle("Nature opération");
    pi.getFormu().getChamp("Borne_inf").setLibelle("Borne inférieur");
    pi.getFormu().getChamp("Borne_sup").setLibelle("Borne supérieur");
    pi.getFormu().getChamp("Prixunitaire").setLibelle("Prix unitaire");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1 class="text-center"><%= titre  %></h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="acte" value="update">
                    <input name="bute" type="hidden" id="bute" value="<%= bute  %>">
                    <input name="classe" type="hidden" id="classe" value="<%= classe  %>">
                    <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable  %>">
                </form>
            </div>
        </div>
    </div>
</div>

