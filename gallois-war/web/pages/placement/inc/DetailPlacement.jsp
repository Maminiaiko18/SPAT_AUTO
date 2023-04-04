<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.placement.Placement"%>
<%@page import="service.SpatService"%>
<%@page import="mg.spat.placement.DetailsPlacements"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="java.util.HashMap"%>

<% try {
        SpatService serv = new SpatService();
        PlacementLibComplet b = new PlacementLibComplet();
        b.setNomTable("placementlib");
        PageConsulte pc = new PageConsulte(b, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        String id= request.getParameter("id");
        PlacementLibComplet bi = (PlacementLibComplet) pc.getBase();
        AttacherFichier[] fichiers = UploadService.getUploadFile(id);
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "placement";
%>
    <div class="row">    
        <section class="content">
            <div class="row col-md-12">
                <div class="box box-solid">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">Liste details placements</h3>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead><tr class="head">
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Id</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Mois</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Montant terme</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Interet recevoir</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Interet net</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Modifier</a>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%

                                        DetailsPlacements[] temp = serv.getDetailsPlacements(null, bi.getId());
                                        System.out.println(temp + " DETAILSPLACEMENTTABLES");
                                        for (int i = 0; i < temp.length; i++) {
                                    %>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                        <td width="10%" align="left"><%= temp[i].getId()%> </td>
                                        <td width="10%" align="left"><%=temp[i].getMois()%> </td>
                                        <td width="10%" align="left"><%= Utilitaire.formaterAr(temp[i].getMontant_terme())%> </td>
                                        <td width="10%" align="left"><%=Utilitaire.formaterAr(temp[i].getInteret_recevoir())%> </td>
                                        <td width="10%" align="left"><%=Utilitaire.formaterAr(temp[i].getInteret_net())%> </td>
                                        <td width="10%" align="left"> <a href="<%=(String) session.getValue("lien") + "?but=placement/detailsPlacement-modif.jsp&id=" + temp[i].getId()%>">Modifier</a> </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div> 
<%} catch (Exception e) {
    e.printStackTrace();
    }%>




