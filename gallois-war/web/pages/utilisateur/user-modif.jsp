<%-- 
    Document   : user-modif
    Created on : 16 d�c. 2015, 15:30:33
    Author     : Jetta
--%>

<%@page import="lc.Direction"%>
<%@page import="bean.CGenUtil"%>   
<%@page import="utilisateur.Role"%>
<% Role[] role = (Role[]) CGenUtil.rechercher(new Role(), null, null, "");
    Direction[] dr = (Direction[]) CGenUtil.rechercher(new Direction(), null, null, "");
%>
<div class="content-wrapper">
    <h1> utilisateur </h1>

    <div class="row">
        <div class="col-xs-12">
            <form action="/cnaps-war/NewUserbo" method="post" name="userbo" id="userbo" >
                <table class="table table-responsive" width="100%">
                    <tbody>
                        <tr>
                            <td align="right">
                                <label>Profil</label>
                            </td>
                            <td >

                                <select name="idrole" id="idrole" onchange="changerDesignation()" class="form-control" >
                                    <option value="">-</option>
                                    <% for (int i = 0; i < role.length; i++) {%>


                                    <option value="<%=role[i].getIdrole()%>"><%=role[i].getDescrole()%></option>
                                    <% } %>

                                </select>



                            </td>
                            <td>
                            </td>
                            <td>

                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right"><label>Login:</label></td>
                            <td align="center">
                                <input name="login" required="" type="text" class="form-control" id="login" value="" tabindex="2">
                            </td>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <td align="right"><label>Departement:</label></td>
                            <td align="center">

                                <select name="adr" id="adr" class="form-control" >
                                    <% for (int i = 0; i < dr.length; i++) {%>


                                    <option value="<%=dr[i].getIdDir()%>"> <%=dr[i].getLibelledir()%> </option>
                                    <% }%>

                                </select>
                            </td>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <td align="right"><label>Mot de passe:</label></td>
                            <td align="center">
                                <input name="pwduser" type="password" class="form-control" id="pwduser" value="" tabindex="2">
                            </td>
                            <td>

                            </td>
                        </tr>

                        
                        
                       
                        <tr>
                            <td align="right"> 

                            </td>
                            <td align="right">
                                <input type="submit" name="Submit" value="Valider" class="btn btn-primary">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="reset" name="reset" value="Annuler" class="btn btn-danger">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</div>

