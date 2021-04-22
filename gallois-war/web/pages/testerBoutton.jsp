<%-- 
    Document   : testerBoutton
    Created on : 2 sept. 2016, 15:01:32
--%>

<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="mg.cnaps.pension.ConstantePension"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%!
        UserEJB u = null;
        String lien = null;
        String bute;
        String nomBoutton;
        int etat;
        String id;
%>
<%
    try{
        etat = Utilitaire.stringToInt(request.getParameter("etat"));
        lien = (String) session.getValue("lien");
        u = (UserEJB) session.getAttribute("u");
        nomBoutton = request.getParameter("nameButton");
        id = request.getParameter("id");
        if(nomBoutton.compareToIgnoreCase("droitMere")==0){
            if(etat==ConstantePension.etatDroitMereAnnuler){
%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=tresorerie/OP/op-saisie.jsp&idDM=<%=id%>");</script>
<%                
            }
            else{
%>
<script language="JavaScript">
        alert('Impossible d editer OP. Droit non annulé');
        history.back();
</script>
<%
            }
        }
        if(nomBoutton.compareToIgnoreCase("editerOP")==0){
                    if(etat==ConstanteEtat.getEtatValider()){
        %>
            <script language="JavaScript"> document.location.replace("<%=lien%>?but=tresorerie/OP/op-saisie.jsp&idObjet=<%=id%>");</script>
        <%                
                    }
                    else{
        %>
        <script language="JavaScript">
                alert('Impossible d editer OP. Objet non viser');
                history.back();
        </script>
        <%
                    }
        }

        if(nomBoutton.compareToIgnoreCase("genererRecuDR")==0){
                    if(etat==ConstanteEtat.getEtatValider()){
        %>
            <script language="JavaScript"> document.location.replace("../Recette?action=declarationderecette&id=<%=request.getParameter("id")%>")</script>
        <%                
                    }
                    else{
        %>
                        <script language="JavaScript">
                                alert('Impossible de generer un recu. Declaration non viser');
                                history.back();
                        </script>
        <%
                    }
        }
        if(nomBoutton.compareToIgnoreCase("visaopov")==0){
            String idbenef = request.getParameter("idbenef");
            if(idbenef!=null && idbenef.startsWith("TCS")){
%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=tresorerie/OP/apresOp.jsp&acte=visaopov&id=<%=id%>");</script>
<%                
            }
            else{
%>
<script language="JavaScript">
        alert('Impossible de viser et cr&eacute;er un OV en meme temps car la banque de tresorerie est introuvable. Veuillez le faire manuellement');
        history.back();
</script>
<%
            }
        }
    }
    catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert('<%=e.getMessage()%>');
        history.back();</script>
        <%
                return;
            }
        %>
%>
