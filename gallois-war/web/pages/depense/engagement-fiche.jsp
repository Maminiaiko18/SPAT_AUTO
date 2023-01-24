<%-- 
    Document   : newjspengagement-fiche
    Created on : 22 fï¿½vr. 2022, 12:15:37
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
//    pc.getChampByName("disponible").setVisible(false);
    pc.getChampByName("compte").setVisible(false);
    pc.getChampByName("montant").setLibelle("Montant");
    pc.getChampByName("disponible").setLibelle("Disponible à facturer");
    pc.getChampByName("dispoAvant").setLibelle("DispoAvant");
    pc.getChampByName("dispoApres").setLibelle("DispoApres");
    pc.getChampByName("compte").setLibelle("Compte");
    pc.getChampByName("codeEtablissementlib").setLibelle("Code Etablissement");
 //   pc.getChampByName("codeEtablissementlib").setVisible(false);
    pc.getChampByName("projetlib").setLibelle("Projet");
//    pc.getChampByName("projetlib").setVisible(false);
    pc.getChampByName("idLC").setVisible(false);
    pc.getChampByName("avecFacture").setVisible(false);
    pc.getChampByName("avecFacturelib").setLibelle("Avec Facture");
    pc.getChampByName("idLClib").setLibelle("Budget");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("observation").setLibelle("Observation");

    engagement = (Engagement) pc.getBase();
    pc.getChampByName("idLClib").setLien((String) session.getValue("lien") + "?but=ligneCredit/fiche-ligneCreditDepense.jsp","id="+engagement.getIdLC()+"&id=");
    pc.getChampByName("tierslib").setLien((String) session.getValue("lien") + "?but=travaux/tiers-fiche.jsp","id="+engagement.getTiers()+"&id=");
    String bute="depense/engagement-fiche.jsp";
    Map<String, String> map = new HashMap();
    map.put("details-engagement","");
    map.put("liste-bc", "");
    map.put("liste-liberation", "");
    map.put("liste-op", "");
    
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "details-engagement";
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
                         <div class="box-footer">
                            <p>
                                      <a  href="<%=(String) session.getValue("lien") + "?but=depense/engagement-modif.jsp&id=" + engagement.getId()%>"><button class="btn btn-warning"  >Modifier </button></a>
                                      <a class="btn btn-warning"   href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=mg.spat.Engagement&bute=depense/engagement-fiche.jsp&id=" + engagement.getId()%>" style="margin-right: 5px">Viser</a>
                                             <a href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-saisie-vaovao.jsp&idEngagement=" + engagement.getId()%>"><button class="btn btn-success pull-right" >Saisie FF</button></a>
                                <a class="btn btn-success pull-right" style="margin-right: 10px" href="<%=(String) session.getValue("lien") + "?but=stock/bc/bondecommande-multiple.jsp&idEngagement=" + engagement.getId()%>">Saisie BC</a></p>
                                <a class="btn btn-primary pull-right" style="margin-right: 10px" href="<%=(String) session.getValue("lien") + "?but=depense/demande-achat-saisie.jsp&idEngagement=" + engagement.getId()%>">Saisir DA</a></p>
                              
                                  <p>       
                         

                                <a href="<%=(String) session.getValue("lien") + "?but=depense/liberer-saisie.jsp&idEngagement=" + engagement.getId()%>"><button class="btn btn-info" style="margin-right: 5px" >Libï¿½rer </button></a>

                                
                                <a class="btn btn-info " href="<%=(String) session.getValue("lien") + "?but=depense/engagement-fille-liste.jsp&idmere=" + engagement.getId() %>" style="margin-right: 5px">Payer</a>
                                 <a href="<%=(String) session.getValue("lien") + "/../../Paie?action=engagement&id=" + engagement.getId()%>"><button class="btn btn-primary pull-right">Imprimer</button></a>
                                <a href="<%=(String) session.getValue("lien") + "/../../Paie?action=dse&id=" + engagement.getId()%>"><button class="btn btn-primary pull-right">Imprimer DSE</button></a>
                                <a href="<%=(String) session.getValue("lien")%>?but=depense/engagement-modif-simple.jsp"><button class="btn btn-primary pull-right">Modifier Obs</button></a>
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
                    <li class="<%= map.get("details-engagement")%>"><a href="module.jsp?but=<%=bute%>&id=<%=engagement.getId()%>&tab=details-engagement">Détails Engagement</a></li>
                    <li class="<%= map.get("liste-bc")%>"><a href="module.jsp?but=<%=bute%>&id=<%=engagement.getId()%>&tab=liste-bc">Liste bon de commande</a></li>
                    <li class="<%= map.get("listeff")%>"><a href="module.jsp?but=<%=bute%>&id=<%=engagement.getId()%>&tab=listeff">Liste Facture Fournisseur</a></li>
                    <li class="<%= map.get("liste-liberation")%>"><a href="module.jsp?but=<%=bute%>&id=<%=engagement.getId()%>&tab=liste-liberation">Liste libération</a></li>
                    <li class="<%= map.get("liste-op")%>"><a href="module.jsp?but=<%=bute%>&id=<%=engagement.getId()%>&tab=liste-op">Liste OP</a></li>
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
