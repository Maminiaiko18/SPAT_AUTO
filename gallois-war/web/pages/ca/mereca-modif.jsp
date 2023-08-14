<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>
<%@page import="mg.spat.MereCA"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    MereCA mereCA =new MereCA();
    mereCA.setNomTable("MERECALIB_CPL");
    PageUpdate pi = new PageUpdate(mereCA, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    
    pi.getFormu().getChamp("id").setAutre("readonly");
    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("val").setLibelle("Compte");
    pi.getFormu().getChamp("desce").setLibelle("Libellé");
    
    pi.getFormu().getChamp("idgrandrubrique").setPageAppel("choix/grandRubriqueChoix.jsp");
    pi.getFormu().getChamp("idgrandrubrique").setAutre("readonly");
    pi.getFormu().getChamp("idgrandrubrique").setLibelle("Grande rubrique");
    pi.getFormu().getChamp("idgrandrubriquelib").setVisible(false);
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification de MereCA</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Modifier</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="ca/mereca-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.MereCA">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="MERECA">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>