<%-- 
    Document   : newjspengagement-fiche
    Created on : 22 févr. 2022, 12:15:37
    Author     : rijan
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.Engagement"%>
<%@page import="affichage.PageConsulte"%>
<%
    Engagement engagement = new Engagement();
    engagement.setNomTable("engagementlib");
    PageConsulte pc = new PageConsulte( engagement , request, (user.UserEJB) session.getValue("u"));
    pc.setTitre("Fiche Engagement");
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("designation").setLibelle("Designation");
    pc.getChampByName("codeEtablissement").setVisible(false);
    pc.getChampByName("projet").setVisible(false);
    pc.getChampByName("montant").setLibelle("Montant");
    pc.getChampByName("disponible").setLibelle("Disponible");
    pc.getChampByName("dispoAvant").setLibelle("DispoAvant");
    pc.getChampByName("dispoApres").setLibelle("DispoApres");
    pc.getChampByName("compte").setLibelle("Compte");
    pc.getChampByName("codeEtablissementlib").setLibelle("Code Etablissement");
    pc.getChampByName("codeEtablissementlib").setVisible(false);
    pc.getChampByName("projetlib").setLibelle("Projet");
    pc.getChampByName("projetlib").setVisible(false);
    pc.getChampByName("idLC").setVisible(false);
    pc.getChampByName("idLClib").setLibelle("Budget");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("idLClib").setLien((String) session.getValue("lien") + "?but=ligneCredit/fiche-ligneCreditDepense.jsp", "id=");
    
    engagement = (Engagement) pc.getBase();
    String bute="depense/engagement-fiche.jsp";
    Map<String, String> map = new HashMap();
        map.put("liste-bc", "");
        map.put("liste-liberation", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "liste-bc";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
%>


<div class="content-wrapper">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=depense/engagement-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche engagement</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="pull-right">
                            <p>
                                <a href="<%=(String) session.getValue("lien") + "/../../Paie?action=engagement&id=" + request.getParameter("id")%>"><button class="btn btn-primary">Imprimer</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-saisie-vaovao.jsp&idEngagement=" + request.getParameter("id")%>"><button class="btn btn-success">Saisie FF</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=stock/bc/bondecommande-multiple.jsp&idEngagement=" + request.getParameter("id")%>"><button class="btn btn-success">Saisie BC</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=depense/liberer-saisie.jsp&idEngagement=" + request.getParameter("id")%>"><button class="btn btn-warning">Libérer </button></a>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=mg.spat.Engagement&bute=depense/engagement-fiche.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Viser</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("liste-bc")%>"><a href="module.jsp?but=<%=bute%>&idengagement=<%=engagement.getId()%>&tab=liste-bc">Liste bon de commande</a></li>
                     <li class="<%= map.get("listeff")%>"><a href="module.jsp?but=<%=bute%>&idengagement=<%=engagement.getId()%>&tab=listeff">Liste Factute Fournisseur</a></li>
                       <li class="<%= map.get("liste-liberation")%>"><a href="module.jsp?but=<%=bute%>&idengagement=<%=engagement.getId()%>&tab=liste-liberation">Liste libération</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-content">       
                        <jsp:include page="<%=tab%>">
                            <jsp:param name='idengagement' value="<%=engagement.getId()%>"/> 


                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>        
    </div>
</div>
