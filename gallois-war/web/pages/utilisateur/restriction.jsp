<%-- 
    Document   : restriction
    Created on : 5 oct. 2015, 15:12:30
    Author     : Jetta
--%>
<%@page import="historique.MapRoles"%>
<%@page import="utilisateur.RestrictionLibelle"%>
<%@page import="lc.Direction"%>
<%@page import="modules.GestionRole"%>
<%@page import="config.Table"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilisateur.Vuerestriction"%>
<%@page import="bean.CGenUtil"%>
<%
    UserEJB u=(UserEJB)session.getAttribute("u");
    String direction = request.getParameter("direction");
    String direc = null;
    if (direction == null) {
        direction =u.getUser().getAdruser();
    }
    MapRoles[] role = (MapRoles[]) CGenUtil.rechercher(new MapRoles(), null, null, "");
    UserEJB us = (UserEJB) session.getAttribute("u");
    RestrictionLibelle r = new RestrictionLibelle();
    Direction[] dr = (Direction[]) CGenUtil.rechercher(new Direction(), null, null, "");
    String rl = request.getParameter("colonne");
    String rolefinale = request.getParameter("rolefinale");
    if (rolefinale == null) {
        rolefinale = "dg";
    }
    if (rl != null) {
        r.setIdrole(rl);
    } else {
        r.setIdrole("dg");
    }

    //    System.out.print("colonne= "+request.getParameter("colonne"));
    String aw = " and idrole='" + r.getIdrole() + "'";
    if (direction != null) {
        aw += "  and iddirection='" + direction + "'";
    }
    RestrictionLibelle[] rest = (RestrictionLibelle[]) CGenUtil.rechercher(r, null, null, aw);
    Table t = new Table();
    //    Table [] listetable=t.getListeTable(r.getIdrole());
    Table[] listetable = new GestionRole().getListeTable(r.getIdrole(), direction);
    // System.out.print("LENGTH= " + listetable.length);
%>
<script>
    function changerDesignation() {
        document.role.submit();
    }
    function annulerRestriction(idrole, idaction, iddirec, nomtable) {

        var role = idrole;
        var nt = nomtable;
        var idact = idaction;
        var direc = iddirec;
        // alert(v+act+idac);
        $.get('/cnaps-war/RestrictionServlet', {idro: role, idacti: idact, drc: direc, nomt: nt}, function(responseText) {

            //       alert(responseText);
            changerDesignation();
        });

    }

</script>


<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Restriction</h1>
    </section>
    <section class="content">
        <form id="role" name="role" method="POST" action="/cnaps-war/Restriction2" autocomplete="off">
            <input type="hidden" value="<%=rolefinale%>" name="rolefinale" id="rolefinale">
            <div class="col-xs-6">
                <div class="form-group">

                    <label>Rôle</label>
                    <select name="colonne" id="colonne" onchange="changerDesignation()" class="form-control" >
                        <% for (int i = 0; i < role.length; i++) {
                                if (r.getIdrole().compareToIgnoreCase(role[i].getIdrole()) == 0) {
                        %>
                        <option value="<%=role[i].getIdrole()%>" selected ><%=role[i].getDescrole()%></option>
                        <%} else {
                        %>
                        <option value="<%=role[i].getIdrole()%>"><%=role[i].getDescrole()%></option>
                        <% }
                            }%>
                    </select>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">

                    <label>Direction</label>
                    <select name="direction" id="direction" onchange="changerDesignation()" class="form-control" >
                        <% for (int i = 0; i < dr.length; i++) {
                                if (dr[i].getIdDir().compareToIgnoreCase(direction) == 0) {
                        %>
                        <option value="<%=dr[i].getIdDir()%>" selected ><%=dr[i].getLibelledir()%></option>
                        <%} else {
                        %>

                        <option value="<%=dr[i].getIdDir()%>"><%=dr[i].getLibelledir()%></option>
                        <% }
                            }%>
                    </select>
                </div>
            </div>



            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Liste Restriction</h3>
                        </div>
                        <div class="box-body">
                            <div class="table-bordered">
                                <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover">

                                    <tbody>
                                        <tr class="active" head="">

                                            <th align="center"   style="text-align:center">Table</th>
                                            <th align="center" valign="top" style="text-align:center">Ajout</th>
                                            <th align="center" valign="top" style="text-align:center">Modification</th>
                                            <th align="center" valign="top" style="text-align:center">Suppression</th>

                                        </tr>

                                        <% for (int i = 0; i < rest.length; i++) {%>
                                        <tr>
                                            <td ><%=rest[i].getTablename()%> </td>
                                    <input type="hidden" name="nomdetable" value="<%=rest[i].getTablename()%>" >

                                    <% if (rest[i].getAjout().compareToIgnoreCase("1") == 0) {%>
                                    <td align="center" onclick="annulerRestriction('<%=rest[i].getIdrole()%>', 'ACT000001', '<%=rest[i].getIddirection()%>', '<%=rest[i].getTablename()%>')"   title="Annuler"><a href="#"  class="btn btn-xs" title="Annuler"><span   class="glyphicon glyphicon-remove" style="size:  5px" value="annuler" ></span></a></td>
                                            <% } else {%>
                                    <td align="center"><input type="checkbox" value="<%=rest[i].getTablename()%>" name="ajout" id="ajout"></td>
                                        <% } %>

                                    <% if (rest[i].getModif().compareToIgnoreCase("1") == 0) {%>
                                    <td align="center" onclick="annulerRestriction('<%=rest[i].getIdrole()%>', 'ACT000002', '<%=rest[i].getIddirection()%>', '<%=rest[i].getTablename()%>')"><a href="#"  class="btn btn-xs" title="Annuler"><span   class="glyphicon glyphicon-remove" style="size:  5px" value="annuler" ></span></a></td>
                                            <% } else {%>
                                    <td align="center"><input type="checkbox" value="<%=rest[i].getTablename()%>" name="modif" id="modif"></td>
                                        <% } %>

                                    <% if (rest[i].getSuppr().compareToIgnoreCase("1") == 0) {%>
                                    <td align="center" onclick="annulerRestriction('<%=rest[i].getIdrole()%>', 'ACT000003', '<%=rest[i].getIddirection()%>', '<%=rest[i].getTablename()%>')"><a href="#"  class="btn btn-xs" title="Annuler"><span   class="glyphicon glyphicon-remove" style="size:  5px" value="annuler" ></span></a></td>
                                            <% } else {%>
                                    <td align="center"><input type="checkbox" value="<%=rest[i].getTablename()%>" name="suppr" id="suppr"></td>
                                        <% } %>


                                    <% }%>


                                    <% for (int i = 0; i < listetable.length; i++) {%>
                                    <tr>
                                        <td ><%=listetable[i].getTable_name()%> </td>
                                        <td align="center"><input type="checkbox" value="<%=listetable[i].getTable_name()%>" name="ajout" id="ajout"></td>
                                        <td align="center"><input type="checkbox" value="<%=listetable[i].getTable_name()%>" name="modif" id="modif"></td>
                                        <td align="center"><input type="checkbox" value="<%=listetable[i].getTable_name()%>" name="suppr" id="suppr"></td>

                                    </tr>
                                    <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-5"></div>
                <div class="col-xs-7"><input type="submit" name="Submit" value="Ajouter" class="btn btn-success" >
                </div>
            </div>
        </form>
    </section>
</div>
