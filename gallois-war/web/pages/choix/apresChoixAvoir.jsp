<%@ page import="utilitaire.Utilitaire" %>
<%
    try{
    String[] choix = request.getParameterValues("choix");
    if(choix==null||choix.length==0)throw new Exception("Veillez cocher au moins un elements");
    String id = "";
    String libelle = "";
    String m = "";
    for (int i = 0; i < choix.length; i++) {
        String[] temp = choix[i].split(";");
        id += temp[0] + ";";
        libelle += temp[1] + ";";
        m += temp[2] + ";";
    }
    String champRet = (String) request.getParameter("champReturn");
    String[] champs = Utilitaire.split(champRet, ";");
    String[] tabMontant = Utilitaire.split(m, ";");
    double montantavoir = 0;
    for(int i = 0; i < tabMontant.length; i++){
        montantavoir += Utilitaire.stringToDouble(tabMontant[i]);
    }
%>
<html>
    <script language="JavaScript">

        window.opener.document.all.<%=champs[0]%>.value = "<%=id%>";
        window.opener.document.all.<%=champs[1]%>.value = "<%=libelle%>";
        window.opener.document.all.<%=champs[2]%>.value = "<%=montantavoir%>";
        window.close();
    </script>
</html>
<%}catch(Exception e){
    e.printStackTrace();
}%>