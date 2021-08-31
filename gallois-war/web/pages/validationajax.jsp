<%@page import="facture.FactureClient"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="affichage.PageInsert"%>
<%@page import="bean.ClassMAPTable"%>
<%@page import="user.UserEJB"%>
<%
    UserEJB u = null;
    u = (UserEJB) session.getAttribute("u");
    String reponse = request.getParameter("reponse");
    String lien = request.getParameter("lien");
    String bute = request.getParameter("bute");
    String retour = "";
    String id=null;
    String acte = "";
    if(request.getParameter("acte")!=null){
        acte = request.getParameter("acte");
    }
    if (reponse.equalsIgnoreCase("true")) {
        System.out.println("miditra true ajax");
      
        Gson gson = new Gson();
        
        String objet = request.getParameter("objet");
        String classe = request.getParameter("classe");
        ClassMAPTable o = null;
        if(acte.compareToIgnoreCase("validefacture") == 0) {
            u.getValidation().setResponse(true);
             if(u.getValidation().getListe_object().size()>0) {
                FactureClient object =(FactureClient) u.getValidation().getListe_object().get(0);
                object.updateToTableWithHisto(u.getUser().getAdruser());
                id=object.getTuppleID();

            }
            retour = "module.jsp?but="+bute+"&id="+id;
        }
        u.setValidation(null);
            
    }else{
        if(acte.compareToIgnoreCase("validefacture") == 0) {

            if(u.getValidation().getListe_object().size()>0) {
                ClassMAPTable object = (ClassMAPTable) u.validerObject(u.getValidation().getListe_object().get(0));
                id=object.getTuppleID();
            }
            retour = "module.jsp?but="+bute+"&id="+id;
        }
        System.out.println("miditra false ajax");
        u.setValidation(null);
    }
    out.print(retour);

%>