<%@page import="bean.TypeObjet"%>
<%@page import="lc.Direction"%>
<%@page import="bean.CGenUtil"%>   
<%@page import="utilisateur.Role"%>
<% 
    Role[] role = (Role[]) CGenUtil.rechercher(new Role(), null, null, "");
    TypeObjet crt = new TypeObjet();
    crt.setNomTable("LOG_DIRECTION");
    TypeObjet[] dr = (TypeObjet[]) CGenUtil.rechercher(crt, null, null, "");
    //Direction[] dr = (Direction[]) CGenUtil.rechercher(new Direction(), null, null, "");
%>
<div class="content-wrapper">
    <h1> Saisie Utilisateur </h1>

    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-body">
                    <form action="/globalnegoce/NewUserbo" method="post" name="userbo" id="userbo">
                        <table class="table table-responsive">
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
                                    <td align="right">
                                        <label>Nom de l'utilisateur</label>
                                    </td>
                                    <td align="center">
                                        <input name="idjoueur" required="" type="text" class="form-control" id="idjoueur" value="" tabindex="1">
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


                                            <option value="<%=dr[i].getId()%>"> <%=dr[i].getDesce()%> </option>
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
                                    <td align="right"><label>Personnel:</label></td>
                                    <td align="center">
                                        <input name="teluserlibelle" type="text" class="form-control"  id="teluserlibelle" value="" tabindex="2" disabled>
                                        <input name="teluser" type="hidden"  id="teluser" value="" tabindex="2">
                                        
                                    </td>
                                    <td>
                                        <input  type="button" onclick="pagePopUp('choix/logPersonnelChoix.jsp?champReturn=teluser;teluserlibelle')" class="btn btn-default" name="choix" value="..." >
                                    </td>
                                </tr>
                                <!--<tr>
                                    <td align="right"><label>Code Direction regionale:</label></td>
                                    <td align="center">
                                        <input name="code_drlibelle" type="text" class="form-control" id="code_drlibelle" value="" tabindex="2"> 
                                        <input name="code_dr" type="hidden" id="code_dr" value="" tabindex="2"> 
                                        
                                    </td>
                                    <td>
                                        <input  type="button" onclick="pagePopUp('choix/drChoix.jsp?champReturn=code_dr;code_drlibelle')" name="choix" class="btn btn-default" value="..." >
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><label>User unit:</label></td>
                                    <td align="center">
                                        <input name="user_init" type="text" class="form-control" id="user_init" value="" tabindex="2">
                                    </td>
                                    <td>

                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><label>Agent MO:</label></td>
                                    <td align="center">
                                        <input name="agent_mo" type="text" class="form-control" id="agent_mo" value="" tabindex="2">
                                    </td>
                                    <td>

                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><label>Agent Disponible:</label></td>
                                    <td align="center">
                                        <input name="agent_disponible" type="text" class="form-control" id="agent_disponible" value="" tabindex="2">
                                    </td>
                                    <td>

                                    </td>
                                </tr>

                                <tr>
                                    <td align="right"><label>Code service:</label></td>
                                    <td align="center">
                                        <input name="code_service" type="text" class="form-control" id="code_service" value="" tabindex="2">
                                    </td>
                                    <td>

                                    </td>
                                </tr>-->

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
    </div>
</div>

