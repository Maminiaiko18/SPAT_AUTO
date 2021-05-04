


<%@page import="affichage.PageConsulte"%>
<%@page import="mg.spat.StatistiqueActivite"%>
<%

    StatistiqueActivite s = new StatistiqueActivite();
    s.setNomTable("previsionSTATACTIVITELIB");
    
    PageConsulte pc = new PageConsulte( s , request, (user.UserEJB) session.getValue("u"));
    pc.setTitre("Fiche Statistique");
    pc.getChampByName("idtypeActionConteneur").setLibelle("type action conteneur");
    pc.getChampByName("Plein20Pieds").setLibelle("20 pieds plein");
    pc.getChampByName("Vide20Pieds").setLibelle("20 pieds vide");
    pc.getChampByName("Plein40Pieds").setLibelle("40 pieds plein");
    pc.getChampByName("Vide40Pieds").setLibelle("40 pieds vide");
    pc.getChampByName("idnomsociete").setLibelle("Société");
    pc.getChampByName("idtypemanipulation").setLibelle("Type manipulation");
    pc.getChampByName("idtypemarchandise").setLibelle("type marchandise");
    pc.getChampByName("idtypemesure").setLibelle("Type mesure");
    pc.getChampByName("nombreunite").setLibelle("Nombre unite");
    pc.getChampByName("typeSaisie").setLibelle("Type saisie");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("idTypeSaisie").setVisible(false);
   

%>


<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=statistique/statistique-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche Prevision StatistiqueActivite</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="pull-right">
                            <p>
                                <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=statistique/prevision-statistique-fiche.jsp&classe=mg.spat.StatistiqueActivite&nomtable=prevision_stat_activite"><button class="btn btn-success">Viser</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=annulerVisa&bute=statistique/prevision-statistique-fiche.jsp&classe=mg.spat.StatistiqueActivite&nomtable=prevision_stat_activite"><button class="btn btn-danger">Annuler visa</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=statistique/prevision-statistique-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>