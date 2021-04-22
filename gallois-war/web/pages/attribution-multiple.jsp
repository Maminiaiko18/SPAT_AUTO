<%-- 
    Document   : attribution-multiple
    Created on : 15 févr. 2016, 17:30:00
    Author     : ITU
--%>

<%@page import="mg.cnaps.immo.ImmoLivraison"%>
<%@page import="bean.ClassMAPTable"%>
<%@page import="mg.cnaps.compta.ComptaEcriture"%>
<%@page import="user.UserEJB"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<%
    String[] id_immo = request.getParameterValues("id");   
    UserEJB u = (user.UserEJB) session.getValue("u");
    String lien = (String) session.getValue("lien");
    String bute = request.getParameter("bute");
    String classe = request.getParameter("classe");
    String acte = request.getParameter("acte");
    ClassEtat t = null;

    try {
        if (acte.compareToIgnoreCase("attribuer") == 0) {
            t = (ClassEtat) (Class.forName(classe).newInstance());
            String  demandeL= request.getParameter("id_livraison");
            //System.out.println("TAFIDITRA="+demandeL);
            int size=id_immo.length;
            if(size>0 && demandeL!=null){
                for(int i=0; i<size; i++){
                    ImmoLivraison iml=new ImmoLivraison(demandeL, 1,id_immo[i],Utilitaire.dateDuJourSql());
                    u.createObject(iml);
                }
            }
        } 
    } catch (Exception e) {
        e.printStackTrace();
%>
<script>
    alert(<%=e.getMessage()%>);
</script>
<%}%>
<!--<script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
