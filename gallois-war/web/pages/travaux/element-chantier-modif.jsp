
<%@page import="elementchantier.ElementChantier"%>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.PageUpdate" %>
<%@ page import="affichage.Liste" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ElementChantier a = new ElementChantier();
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    affichage.Champ[] liste = new affichage.Champ[1];    
    TypeObjet unite = new TypeObjet();
    unite.setNomTable("unite");
    liste[0] = new Liste("unite", unite, "val", "id");
    pi.getFormu().changerEnChamp(liste);

 
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1>Modification element chantier</h1>
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
                    <input name="bute" type="hidden" id="bute" value="travaux/element-chantier-fiche.jsp?id=<%=request.getParameter("id") %>">
                    <input name="classe" type="hidden" id="classe" value="elementchantier.ElementChantier">
                </form>
            </div>
        </div>
    </div>
</div>
