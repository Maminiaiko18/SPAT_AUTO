<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="historique.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="utilisateur/apresModifUser.jsp";
        String lien=null;
        UserEJB u=null;
        MapRoles[] rl = null;
        MapUtilisateur us = null;
        String idUser = null;
%>
<%
  try
{
  idUser=request.getParameter("idUser");
  u=(UserEJB)session.getValue("u");
  us=u.getUser();
  lien=(String)session.getValue("lien");
  rl=u.findRole("%");
//(String ref, String user, String nom, String role)
  idUser = String.valueOf(us.getRefuser());
  us=u.findUtilisateurs(idUser,"%","%","%","%","%","%")[0];

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifie(login.value)&&verifie(newPass.value)&&verifie(nom.value))">
<h1>Modification utilisateur </h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
	<tr>
	<td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr> 
            <td class="left">Login : <span class="remarque">*</span></td>
            <td> <input name="login" type="text" class="champ" id="login" value="<%=us.getLoginuser()%>"> 
            </td>
          </tr>
          <!--<tr> 
            <td  class="left">Ancien mot de passe :</td>
            <td> <input name="oldPass" type="password" class="champ" id="oldPass" value="<%=us.getPwduser()%>"> 
            </td>
          </tr>-->
          <tr> 
            <td  class="left">Nouveau mot de passe : <span class="remarque">*</span></td>
            <td> <input name="newPass" type="password" class="champ" id="newPass" value="<%=us.getPwduser()%>"> 
            </td>
          </tr>
          <tr> 
            <td  class="left">Nom : <span class="remarque">*</span></td>
            <td> <input name="nom" type="text" class="champ" id="nom" value="<%=us.getNomuser()%>"> 
            </td>
          </tr>
          <tr> 
            <td  class="left">Adresse : </td>
            <td> <input name="adresse" type="text" class="champ" id="adresse" value="<%=us.getAdruser()%>"> 
              <input name="acte" type="hidden" class="champ" id="adresse" value="UPDATE"> 
              <input name="idRole" type="hidden" class="champ" value="<%=us.getIdrole()%>"> 
              <input name="idUser" type="hidden" class="champ" id="idUser" value=<%=idUser%>
            </td>
          </tr>
          <tr> 
            <td  class="left">Telephone : </td>
            <td> <input name="telephone" type="text" class="champ" id="telephone" value="<%=us.getTeluser()%>"> 
            </td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
            <td align="center">
<input type="submit" name="Submit" value="Modifier" class="submit">
            </td>
            <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
  </tr>
</table>
      </td>
	</tr>
</table>

</form>
<span class="remarque">(*) Champs obligatoires</span>