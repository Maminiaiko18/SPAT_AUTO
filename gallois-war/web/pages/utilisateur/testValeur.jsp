<%@page import="user.UserEJB"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%

TestValeur pj=new TestValeur();
PageInsert pi=new PageInsert(pj,request,(UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.preparerDataFormu();
%>

<h1>Test</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="test" id="test">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="utilisateur/testValeur.jsp">
 <input name="classe" type="hidden" id="classe" value="utilitaire.TestValeur">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
