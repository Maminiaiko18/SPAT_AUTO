<%-- 
    Document   : mouvement-liste
    Created on : 4 nov. 2019, 15:02:33
    Author     : john
--%>

<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
      try{
    MouvementLibComplet mouvement = new MouvementLibComplet();
     
    String nomTable = "MOUVEMENTLIBCOMPLET";    
    if(request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0){
        nomTable = request.getParameter("table");
    }
    mouvement.setNomTable(nomTable);
    
    //String listeCrt[] = {"id","escale","nomnavire", "valconsignataire", "valcargaison", "valquaisdestination","datearrivee", "date_depart","quaisdestination"};
    String listeCrt[] = {"id", "nomnavire", "escale", "desceconsignataire","date_depart","datearrivee"};
    String listeInt[] = {"date_depart","datearrivee"};
    String libEntete[] = {"id","escale","nomnavire", "desceconsignataire","valpaysdestination", "valcargaison", "datearrivee", "heure","valquaisdestination", "date_depart","heure_depart","duree"};
    PageRecherche pr = new PageRecherche(mouvement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("date_depart1").setLibelle("date depart min");
    pr.getFormu().getChamp("date_depart2").setLibelle("date depart max");
    pr.getFormu().getChamp("datearrivee1").setLibelle("date arrivée min");
    pr.getFormu().getChamp("datearrivee2").setLibelle("date arrivée max");
    
    String rqt="";
    if(request.getParameter("idquaidestination")!=null){
        rqt+=" and  quaisdestination='"+request.getParameter("idquaidestination")+"'";
    }
//    rqt+=" and etatNavire!='"+ConstanteEtat.getEtatAnnuler()+"' order by datearrivee, heure desc";
    rqt+=" and etatNavire!='"+ConstanteEtat.getEtatAnnuler()+"'";
    pr.setApres("capitainerie/mouvement-liste.jsp");
    pr.setAWhere(rqt);
    pr.setOrdre(" order by  escale desc,id desc");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listemouvement.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Registre escale</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/mouvement-liste.jsp" method="post" name="listemouvement" id="listemouvement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("mouvementLibComplet") == 0) {%>    
                        <option value="mouvementLibComplet" selected>Tous</option>
                        <% } else { %>
                        <option value="mouvementLibComplet" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("MOUVEMENTLIBCOMPLETDEPART") == 0) {%>
                        <option value="MOUVEMENTLIBCOMPLETDEPART" selected> D&eacute;part </option>
                        <% } else { %>
                        <option value="MOUVEMENTLIBCOMPLETDEPART"> D&eacute;part </option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("MOUVEMENTLIBCOMPLETAQUAIS") == 0) {%>
                        <option value="MOUVEMENTLIBCOMPLETAQUAIS" selected> Arriv&eacute;e  </option>
                        <% } else { %>
                        <option value="MOUVEMENTLIBCOMPLETAQUAIS"> Arriv&eacute;e  </option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("mouvementLibComplet_cree") == 0) {%>
                        <option value="mouvementLibComplet_cree" selected> Cr&eacute;e  </option>
                        <% } else { %>
                        <option value="mouvementLibComplet_cree"> Cr&eacute;e  </option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("mouvementLibComplet_vise") == 0) {%>
                        <option value="mouvementLibComplet_vise" selected> Vis&eacute;  </option>
                        <% } else { %>
                        <option value="mouvementLibComplet_vise"> Vis&eacute;  </option>
                        <% } %>
                        
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capita"
                    + "inerie/mouvement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","escale","navire", "consignataire","Destination", "cargaison", "date arrivée", "Heure d'arrivée","localistation", "date départ","heure départ","durée"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
      <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
