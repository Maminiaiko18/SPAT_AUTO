<%@page import="affichage.PageRecherche"%>
<%@page import="bean.TypeObjet"%>
<%@page import="service.SpatService"%>
<%
    try{ 
    TypeObjet info = new TypeObjet();
    info.setNomTable("CLIENT_CONCESSIONNAIRE");
    String listeCrt[] = {"id","val","desce"};
    String listeInt[] = {};
    String libEntete[] = {"id","val","desce"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("redirectClient.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    TypeObjet[] liste=(TypeObjet[])pr.getTableau().getData();
%>
            
<div class="content-wrapper">
    <h1>Choix client</h1>
    <form action="<%=pr.getLien()%>?but=redirectClient.jsp" method="post" name="cli" id="cli" data-parsley-validate>
        <div class="col-md-3">
            
        </div>
        <div class="col-md-6">
            <div class="box-insert">
                <div class="box">
                    <div class="box-body">
                        <table class="table table-bordered">
                            <tbody>
                                <tr>
                                    <th>
                                        <label for="Date" tabindex="1">Client</label>
                                    </th>
                                    <td>
                                        <select name="cli">
                                            <% if(liste.length>0){
                                                for(int i=0;i<liste.length;i++){ %>
                                                <option value="<%=liste[i].getId()%>"><%=liste[i].getVal()%></option>
                                            <% } 
                                            }%>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="box-footer">
                        <div class="col-xs-12">
                            <input type="submit" value="Valider" class="btn btn-success">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </form>
</div>
            
            
<%} catch(Exception e){
    e.printStackTrace();
}%>