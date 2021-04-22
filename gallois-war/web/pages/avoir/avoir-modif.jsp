<%@page import="avoir.Avoir"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.Tva"%> 
<%
    UserEJB u;
    Avoir a;
    
%>
<%
   String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new Avoir();
//    a.setNomTable("AVOIR_LIB_VAL");
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    a=(Avoir)pi.getBase();
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idfacture").setLibelle("Facture");
    pi.getFormu().getChamp("etat").setVisible(false);
//    pi.getFormu().getChamp("idfacture").setValeurLibelle(a.getDesignation());
    
    if(request.getParameter("idfacture")!=null && request.getParameter("idfacture").compareTo("")!=0){
        pi.getFormu().getChamp("idfacture").setDefaut(request.getParameter("idfacture"));
    }
    
    pi.getFormu().getChamp("idfacture").setPageAppel("choix/factureClientChoix.jsp");
    pi.getFormu().getChamp("idfacture").setAutre("readonly");
    
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet typeAvoir = new TypeObjet();
    typeAvoir.setNomTable("typeavoir");
    liste[0] = new Liste("type", typeAvoir, "val", "id");
    Tva tva = new Tva();
    liste[1] = new Liste("tva", tva, "valeurtva", "valeurtva"); 
    pi.getFormu().changerEnChamp(liste);
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <div class="box">
                <div class="box">
                    <h1>Modification Avoir</h1>
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
                        <input name="bute" type="hidden" id="bute" value="avoir/avoir-fiche.jsp?id=<%=request.getParameter("id") %>">
                        <input name="classe" type="hidden" id="classe" value="avoir.Avoir">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

</script>