<%@ page import="utilitaire.Utilitaire" %>
<%

    String[] choix = request.getParameterValues("choix");
    if(choix==null||choix.length==0)throw new Exception("Veuillez cocher au moins un élément");
    
    String champRet = (String) request.getParameter("champReturn");
    String[] champs = Utilitaire.split(champRet, ";");
    String numberStr = champs[0].substring(8); // Commence à l'index après "produit_"
    int startingLine = Integer.parseInt(numberStr);

    for (int i = 0; i < choix.length; i++) {
        String[] temp = choix[i].split(";");
        String id = temp[0];
        String libelle = temp[1]; 
        String idFieldName = "produit_" + startingLine;
        String libelleFieldName = "produitlibelle_" + startingLine;
        String designationFieldName = "designation_" + startingLine;

        startingLine = startingLine + 1;
        %>
        <script language="JavaScript">
            window.opener.document.all['<%=idFieldName%>'].value = "<%=id%>";
            window.opener.document.all['<%=libelleFieldName%>'].value = "<%=libelle%>";
            window.opener.document.all['<%=designationFieldName%>'].value = "<%=libelle%>";

        </script>
        <%
    }
%>
<html>
    <script language="JavaScript">
        window.close();
    </script>
</html>
