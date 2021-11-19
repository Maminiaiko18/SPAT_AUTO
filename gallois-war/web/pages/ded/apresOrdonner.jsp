<%@page import="ded.OrdonnerPayement"%>
<%@page import="java.util.Vector"%>
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
                        if (rajoutLien != null) {

                for (int o = 0; o < rajoutLien.length; o++) {
                    String valeur = request.getParameter(rajoutLien[o]);
                    rajoutLie = rajoutLie + "&" + rajoutLien[o] + "=" + valeur;
                 
                }
    
            }
                        
            if(acte.compareToIgnoreCase("decaisser") == 0){
                String[] ids = request.getParameterValues("id");
                String[] idOps = OrdonnerPayement.getFacturesOPs(null,ids);
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=treso/journalcaisse-saisie.jsp&idFacturesF=<%=Utilitaire.tabToString(idOps,"",";")%>");</script>
            <% } %>

            int type = Utilitaire.stringToInt(typeBoutton);
            
            if (acte.compareToIgnoreCase("insertByFacture") == 0) {
                    String idFact = request.getParameter("ded_Id");
                    if (idFact != null && idFact.compareTo("")!=0){
                            t = (ClassMAPTable) (Class.forName(classe).newInstance());
                            PageInsert p = new PageInsert(t, request);
                            ClassMAPTable f = p.getObjectAvecValeur();
                            f.setNomTable(nomtable);
                            ClassMAPTable o = (ClassMAPTable) u.createObject(f);
                            temp = (Object) o;
                            if (o != null) {
                                    id = o.getTuppleID();
                            }
                            bute=bute+"&tiers="+request.getParameter("idtiers");
                    }
                    else{
                            String daty = request.getParameter("daty");
                            String montant = request.getParameter("montant");
                            String remarque = request.getParameter("remarque");

                            %>
                            <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerpayement-direct.jsp&daty=<%=daty%>&montant=<%=montant%>&remarque=<%=remarque%>");</script>
                    <%
                    }
            }
             if (acte.compareToIgnoreCase("payerOPbyFacture") == 0) {
                    String idFact = request.getParameter("ded_Id");
                    if (idFact != null && idFact.compareTo("")!=0){
                            t = (ClassMAPTable) (Class.forName(classe).newInstance());
                            PageInsert p = new PageInsert(t, request);
                            ClassMAPTable f = p.getObjectAvecValeur();
                            f.setNomTable(nomtable);
                            ClassMAPTable o = (ClassMAPTable) u.createObject(f);
                          /*  ClassMAPTable visa = (ClassMAPTable) (Class.forName(classe).newInstance());
                            visa.setValChamp(visa.getAttributIDName(), o.getTuppleID());
                            visa.setNomTable(nomtable);
                            u.validerOPClientFournisseur(visa,request.getParameter("nomfacture"),null);*/
                            temp = (Object) o;
                           /* if (o != null) {
                                    id = o.getTuppleID();
                            }*/
                            val=o.getTuppleID();
                            id=o.getTuppleID();
//                            bute+="&tiers="+request.getParameter("tiers");
//                            bute+="&montant="+request.getParameter("montant");
//                            bute+="&tiers="+request.getParameter("tiers");
                            //bute=bute+"&id="+id;
                    }
                    else{
                            String daty = request.getParameter("daty");
                            String montant = request.getParameter("montant");
                            String remarque = request.getParameter("remarque");

                            %>
                            <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerpayement-direct.jsp&daty=<%=daty%>&montant=<%=montant%>&remarque=<%=remarque%>");</script>
                    <%
                    }
            }
            if (acte.compareToIgnoreCase("insertDirect") == 0) {
                //getAll component 
		//id=u.createOpDirect(request.getParameter("daty"),request.getParameter("montantTTC"),request.getParameter("idTVA"),request.getParameter("idFournisseur"),request.getParameter("idDevise"),request.getParameter("remarque"), request.getParameter("designation"),request.getParameter("datyecheance"));
            }
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
                   u.deleteObject(t);
               } catch (Exception e) {%>
    <script language="JavaScript">alert('<%=e.getMessage()%>');history.back();</script>
    <%
        }
		}
    
        }
        if (acte.compareToIgnoreCase("update") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            Page p = new Page(t, request);
            ClassMAPTable f = p.getObjectAvecValeur();
            temp = f;
			if(nomtable!=null){
				f.setNomTable(nomtable);
			}
			
            u.updateObject(f);
        }
        

        if (acte.compareToIgnoreCase("annulerVisa") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            temp = t;
            u.annulerVisa(t);
        }
        if (acte.compareToIgnoreCase("valider") == 0) {     // VISER
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            t.setNomTable(nomtable);
            ClassMAPTable o = (ClassMAPTable) u.validerObject(t);
            temp = t;
            val = o.getTuppleID();
        }
        if (acte.compareToIgnoreCase("validerOP") == 0) {     // VISER
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            t.setNomTable(nomtable);
//            u.validerOP(t);
        }
		if (acte.compareToIgnoreCase("validerOR") == 0) {     // VISER
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            t.setNomTable(nomtable);
//            u.validerOR(t);
        }
		
		//insertReportAuto
		if (acte.compareToIgnoreCase("insertReportAuto") == 0) {     // REPORTER AUTO
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            PageInsert p = new PageInsert(t, request);
            ClassMAPTable f = p.getObjectAvecValeur();
            f.setNomTable(nomtable);
//            ClassMAPTable o = (ClassMAPTable) u.insertReportAuto(f);
           // temp = (Object) o;
/*            if (o != null) {
                id = o.getTuppleID();
            }*/
        }
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



