<%-- 
    Document   : teste
    Created on : 12 juil. 2021, 14:31:47
    Author     : nyamp
--%>

<%@page import="utilitaire.Utilitaire"%>

<%@page import="mg.allosakafo.stock.EtatStockMat"%>
<%
    EtatStockMat[] liste =EtsatStockMat.getEtatDeStockCarburant(Utilitaire.dateDuJourSql(),null, null, 1);
        System.out.println("liste==========="+liste.lengths);
%>