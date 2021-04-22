<%@page import="mg.cnaps.formation.FormAbsence"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
	UserEJB u = null;
	String acte = null;
	String lien = null;
	String bute;
	String nomtable = null;
	String typeBoutton;
    %>
    <%
	try {
	    nomtable = request.getParameter("nomtable");
	    typeBoutton = request.getParameter("type");
	    lien = (String) session.getValue("lien");
	    u = (UserEJB) session.getAttribute("u");
	    acte = request.getParameter("acte");
	    bute = request.getParameter("bute");
	    Object temp = null;
	    String[] rajoutLien = null;
	    String classe = request.getParameter("classe");
	    ClassMAPTable t = null;
	    String tempRajout = request.getParameter("rajoutLien");
	    String val = "";
	    String id = request.getParameter("id");

	    String rajoutLie = "";
	    if (tempRajout != null && tempRajout.compareToIgnoreCase("") != 0) {
		rajoutLien = utilitaire.Utilitaire.split(tempRajout, "-");
	    }
	    if (bute == null || bute.compareToIgnoreCase("") == 0) {
		bute = "pub/Pub.jsp";
	    }

	    if (classe == null || classe.compareToIgnoreCase("") == 0) {
		classe = "pub.Montant";
	    }

	    if (typeBoutton == null || typeBoutton.compareToIgnoreCase("") == 0) {
		typeBoutton = "3"; //par defaut modifier
	    }

	    if (rajoutLien != null) {

		for (int o = 0; o < rajoutLien.length; o++) {
		    String valeur = request.getParameter(rajoutLien[o]);
		    rajoutLie = rajoutLie + "&" + rajoutLien[o] + "=" + valeur;

		}

	    }

	    int type = Utilitaire.stringToInt(typeBoutton);
	    if (acte.compareToIgnoreCase("insert") == 0) {
		t = (ClassMAPTable) (Class.forName(classe).newInstance());
		PageInsert p = new PageInsert(t, request);
		ClassMAPTable f = p.getObjectAvecValeur();
		f.setNomTable(nomtable);
		ClassMAPTable o = (ClassMAPTable) u.createObject(f);
		temp = (Object) o;
		if (o != null) {
		    id = o.getTuppleID();
		}
	    }
//	    if (acte.compareToIgnoreCase("regulariser") == 0) {
//		t = (ClassMAPTable) (Class.forName(classe).newInstance());
//		PageInsert p = new PageInsert(t, request);
//		ClassMAPTable f = p.getObjectAvecValeur();
//		f.setNomTable(nomtable);
//		ClassMAPTable o = (ClassMAPTable) u.regulObject(f);
//		temp = (Object) o;
//		if (o != null) {
//		    id = o.getTuppleID();
//		}
//	    }
	    if (acte.compareToIgnoreCase("deleteFille") == 0) {

		t = (ClassMAPTable) (Class.forName(classe).newInstance());
		t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
		temp = (Object) t;
		u.deleteObjetFille(t);
	    }
	    /**
	     * ********************************************
	     */

	    /**
	     * ********************************************
	     */
	    if (acte.compareToIgnoreCase("debaucher") == 0) {
		t = (ClassMAPTable) (Class.forName(classe).newInstance());
		t.setValChamp(t.getAttributIDName(), request.getParameter("idpers"));
		t.setNomTable(nomtable);
		ClassMAPTable o = (ClassMAPTable) u.createObject(t);
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
    <%
	}
	if (acte.compareToIgnoreCase("delete") == 0) {
	    String error = ""; %>
    <%//if(request.getParameter("confirm") != null){
	try {
	    //System.out.println("suppression : " + request.getParameter("confirm") + " nom table : " + nomtable);
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
	    if (nomtable != null && !nomtable.isEmpty()) {
		t.setNomTable(nomtable);
	    }
	    String idFormation = request.getParameter("idformation");
	    String idPers = request.getParameter("idpers");
	    u.deleteObject(t);%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=idFormation%>&idpers=<%=idPers%>");</script>
    <% } catch (Exception e) {%>
    <script language="JavaScript">alert('<%=e.getMessage()%>');history.back();</script>
    <%
	}
//                }else{%>
    <!--<script language="JavaScript">
//                    if (confirm("Voulez-vous vraiment supprimer ?")) { // Clic sur OK
//                        var url = window.location.href;
//                        url = url+"&confirm=oui";
//                        window.location.replace(url);
//                        //alert("url : "+url);
//                    } else{
//                        var url = document.referrer;
//                        window.location.replace(url);
//                    }
    </script>-->
    <%//  }
	}
	if (acte.compareToIgnoreCase("update") == 0) {
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    Page p = new Page(t, request);
	    ClassMAPTable f = p.getObjectAvecValeur();
	    temp = f;
	    if (nomtable != null) {
		f.setNomTable(nomtable);
	    }

	    u.updateObject(f);
	}
	if (acte.compareToIgnoreCase("dupliquer") == 0) {
	    String classeFille = request.getParameter("nomClasseFille");
	    String nomColonneMere = request.getParameter("nomColonneMere");
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
	    Object o = u.dupliquerObject(t, classeFille, nomColonneMere);
	    val = o.toString();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=val%>");</script>
    <%
	}

	if (acte.compareToIgnoreCase("annuler") == 0) {
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
	    u.annulerObject(t);
	}

	if (acte.compareToIgnoreCase("annulerVisa") == 0) {
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
	    temp = t;
	    u.annulerVisa(t);
	}
	if (acte.compareToIgnoreCase("finaliser") == 0) {
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
	    temp = t;
	    u.finaliser(t);
	}

	if (acte.compareToIgnoreCase("valider") == 0) {     // VISER
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
	    ClassMAPTable o = (ClassMAPTable) u.validerObject(t);
	    temp = t;
	    val = o.getTuppleID();

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&id=<%=val%>");</script>
    <%
	}
	if (acte.compareToIgnoreCase("rejeter") == 0) {
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    PageInsert p = new PageInsert(t, request);
	    ClassMAPTable f = p.getObjectAvecValeur();
	    t.setNomTable(nomtable);
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            String classeMere = request.getParameter("classeMere");
            if(classeMere==null || classeMere.compareToIgnoreCase("")==0) classeMere = "pub.Montant";
            ClassMAPTable tm = (ClassMAPTable) (Class.forName(classeMere).newInstance());
	    u.rejeterObject(t, tm);
	}
	if (acte.compareToIgnoreCase("cloturer") == 0) {
	    t = (ClassMAPTable) (Class.forName(classe).newInstance());
	    t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
	    u.cloturerObject(t);
	}
//	if (acte.compareToIgnoreCase("corriger") == 0) {
//
//	    String[] listeVirement = request.getParameterValues("id");
//	    u.corrigerVirement(listeVirement);
//	}


    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&valeur=<%=val%>&id=<%=Utilitaire.champNull(id)%>");</script>
    <%

    } catch (Exception e) {
	e.printStackTrace();
    %>

    <script language="JavaScript"> alert('<%=e.getMessage()%>');
	history.back();</script>
        <%
		return;
	    }
        %>
</html>



