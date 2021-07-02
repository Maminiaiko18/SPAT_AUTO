<%-- 
    Document   : listePrevisionChoix
    Created on : 25 févr. 2021, 10:04:02
    Author     : Audace
--%>
<%@page import="mg.spat.PrevisionLibComplet"%>
<%@ page import="user.*" %>
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try{
       
        PrevisionLibComplet prevision=new PrevisionLibComplet();         
        prevision.setNomTable("previsionLibComplet");
    
      String champReturn = request.getParameter("champReturn");
      String listeCtrl[]={"id","escale","paysprovenance","quaiprovenance","nomnavire","valconsignataire","valcargaison","date_arrivee","date_depart","paysdestination"};
      String listeInt[]={"date_arrivee","date_depart"};
      String libEntete[]={"id","escale","valpaysprovenance", "valquaisprovenance", "nomnavire","valconsignataire","valcargaison","date_arrivee","heure_arrivee","date_depart","heure_depart","valpaysdestination","valquaisdestination","valpilote"};
      PageRechercheChoix pr = new PageRechercheChoix(prevision, request, listeCtrl, listeInt, 3, libEntete,libEntete.length);
      
      pr.setUtilisateur((user.UserEJB) session.getValue("u"));
      pr.setLien((String) session.getValue("lien"));
      //pr.setAWhere(" and etat != "+ConstanteEtat.getEtatValider()+" and etatnavire!="+ConstanteEtat.getEtatAnnuler());
      pr.setAWhere(" order by date_arrivee asc");
      pr.getFormu().getChamp("Date_arrivee1").setLibelle("Date d'arrivée Min");
      pr.getFormu().getChamp("Date_arrivee2").setLibelle("Date d'arrivée Max");
      pr.getFormu().getChamp("Date_depart1").setLibelle("date de départ Min");
      pr.getFormu().getChamp("Date_depart2").setLibelle("date de départ Max");
      pr.getFormu().getChamp("paysprovenance").setLibelle("Provenance");
      pr.getFormu().getChamp("nomnavire").setLibelle("Navire");
      pr.getFormu().getChamp("quaiprovenance").setLibelle("Quais");
      
      pr.getFormu().getChamp("paysdestination").setLibelle("Destination");
      pr.getFormu().getChamp("valcargaison").setLibelle("Cargaison");
      pr.getFormu().getChamp("valconsignataire").setLibelle("Consignataire");
      pr.setApres("listePrevisionChoix.jsp");
      
      pr.setChampReturn(champReturn);
      
      String[] colSomme = null;
      pr.creerObjetPage(libEntete, colSomme); 
      
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SPAT</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body>
        
        <div class="wrapper">
            <section class="content-header">
                <h1>Liste de prévisions des quais</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                            out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <%
                        String libEnteteAffiche[] = {"id","Escale","Pays Provenance","Quai de provenance"," Nom Navire","Consignataire","Cargaison","date d'arrivée","heure d' arrivée","date de depart","heure du depart","destination","Quai de destination","Pilote"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); 
                    %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
             <%
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
         <jsp:include page='../elements/js.jsp'/>
   </body>
</html>