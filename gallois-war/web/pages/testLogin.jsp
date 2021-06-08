
<%@page import="bean.TypeObjet"%>
<%@page import="mg.cnaps.configuration.Configuration"%>
<%@page import="user.*"%>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="lc.Direction" %>
<%@ page import="java.net.InetAddress" %>
<%
    UserEJB u = null;
    String username = null;
    String pwd = null;
    String interim = null;
    String service = null;
    historique.MapUtilisateur ut = null;
    String lien;
    String queryString;
    String ip = null;
    String host = null;
    String mot_vide = "";
    String mot_avec_espace = "mot espace";
    String mot = "mot";
    String mot_null = null;
    Configuration[] configo = null;

%>

<%    try {
    
        //InetAddress inetAddress;
        //inetAddress = InetAddress.getLocalHost();
        //String serverAddress = request.getRemoteAddr()+"-"+request.getRemoteHost();
        username = request.getParameter("identifiant");
        pwd = request.getParameter("passe");
        interim = request.getParameter("interim");
        service = request.getParameter("service");

        u = UserEJBClient.lookupUserEJBBeanLocal();
        //u.setAddrIp(serverAddress);
        u.testLogin(username, pwd, interim, service);
//        System.out.println("METY APRES TEST LOGIN!!!!!!!!!!!!!!!!!");
        configo = u.findConfiguration();
        session.setMaxInactiveInterval(216000);
        session.setAttribute("u", u);
        session.setAttribute("config", configo);

/*        
        ComptaCompte comptaCompte = new ComptaCompte();
        ComptaCompte[] comptaComptes = (ComptaCompte[]) CGenUtil.rechercher(comptaCompte, null, null, "");
        
        String jsons = "[";
        for(int i=0;i<comptaComptes.length;i++) {
            jsons += "\""+comptaComptes[i].getCompte()+ " : "+comptaComptes[i].getLibelle()+"\"";
            if(i<comptaComptes.length-1) jsons += ", ";
        }
        jsons += "]";
        session.setAttribute("comptaComptes", jsons);
 */

        
        //session.setAttribute("ipadr", serverAddress);
        //System.out.println("serverAddressgfgf = " + serverAddress);
        ut = u.getUser();
        
        TypeObjet crd = new TypeObjet();
        crd.setNomTable("LOG_DIRECTION");
        crd.setId(ut.getAdruser());
        TypeObjet[] ret = (TypeObjet[]) CGenUtil.rechercher(crd, null, null, "");
        
        /*Direction crd = new Direction();
        crd.setIdDir(ut.getAdruser());
        Direction[] ret = (Direction[]) (CGenUtil.rechercher(crd, null, null, ""));*/
        session.setAttribute("entmenu", "_all-skins");
        session.setAttribute("langue", "fr");
        lien = "globalnegoce.jsp";
        if(session.getAttribute("pageName") != null){
            String pageName = session.getValue("pageName").toString();
            if(!pageName.equals("")){
               lien = pageName; 
            }
        }
//        System.out.println(" ===================================== " + u.getCnapsUser().getCode_service() + " ==================== ");
        queryString = "but="+u.findHomePageServices(u.getUser().getIdrole());
        String queryURL = request.getQueryString();
        if(queryURL != null && !queryURL.equals("")){
            queryString = queryURL;
        }
        if (ret.length > 0) {
            session.setAttribute("dirlib", ret[0].getVal());
            u.setIdDirection(ret[0].getVal());
        }
        if (ut.isSuperUser() == true) {
            session.setAttribute("dir", "%");
            session.setAttribute("dirlib", "");
            //lien = "module.jsp";
            session.setAttribute("lien", lien);
            String menu = "admin.jsp";
            session.setAttribute("menu", menu);
            out.println("<script language='JavaScript'> document.location.replace('" + lien + "?" + queryString + "');</script>");
        } //lien="modele"+ut.getIdrole()+ut.getAdruser()+".jsp";
        //session.setAttribute("lien", lien);
        else if (ut.getIdrole().compareTo("dg") == 0) {
            //lien = "module.jsp";
            session.setAttribute("lien", lien);
            String menu = "admin.jsp";
            session.setAttribute("menu", menu);
            session.setAttribute("dir", ut.getAdruser());
            out.println("<script language='JavaScript'> document.location.replace('" + lien + "?" + queryString + "');</script>");
        } /**
         * *
         */
        else if (ut.getIdrole().compareTo("OS") == 0) {
            lien = "module.jsp";
            session.setAttribute("lien", lien);
            String menu = "admin.jsp";
            session.setAttribute("menu", menu);
            session.setAttribute("dir", ut.getAdruser());
            //out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=laptop/Acceuil.jsp'); </script>");
            out.println("<script language='JavaScript'> document.location.replace('" + lien + "?but=travailleur/travailleur-liste.jsp');</script>");
        } else if (ut.getIdrole().compareTo("pointage") == 0) {
            //lien = "module.jsp";
            session.setAttribute("lien", lien);
            String menu = "admin.jsp";
            session.setAttribute("menu", menu);
            session.setAttribute("dir", ut.getAdruser());
//    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=Pointage/Acceuil.jsp'); </script>");
            out.println("<script language='JavaScript'> document.location.replace('" + lien + "?" + queryString + "');</script>");
        } else if (ut.getIdrole().compareTo("Chef") == 0) {
            //lien = "module.jsp";
            session.setAttribute("lien", lien);
            String menu = "admin.jsp";
            session.setAttribute("menu", menu);
            out.println("<script language='JavaScript'> document.location.replace('" + lien + "?" + queryString + "');</script>");
        }else if(ut.getIdrole().compareTo("ROL001300") == 0){
            queryString = "but=capitainerie/page-commandant.jsp";
            session.setAttribute("dir", "%");
            session.setAttribute("dirlib", "");
            //lien = "module.jsp";
            session.setAttribute("lien", lien);
            String menu = "admin.jsp";
            session.setAttribute("menu", menu);
            out.println("<script language='JavaScript'> document.location.replace('" + lien + "?" + queryString + "');</script>");
            return;
        }else {
            session.setAttribute("dir", "%");
            session.setAttribute("dirlib", "");
            //lien = "module.jsp";
            session.setAttribute("lien", lien);
            String menu = "admin.jsp";
            session.setAttribute("menu", menu);
            out.println("<script language='JavaScript'> document.location.replace('" + lien + "?" + queryString + "');</script>");

        }
        
        
    } catch (Exception e) {

        e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage() %>');
    history.back();
</script>
<%
        return;
    }
%>



<script language='JavaScript'> document.location.replace('<%=lien%>?"<%=queryString%>');</script>
