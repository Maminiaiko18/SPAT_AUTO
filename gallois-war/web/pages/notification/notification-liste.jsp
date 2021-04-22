
<%@page import="utilitaire.Utilitaire"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.notification.NotificationLibelleS"%>
<%@page import="affichage.PageRecherche"%>

<% 
    UserEJB u = (UserEJB) session.getAttribute("u");
    MapUtilisateur mu = u.getUser();
    NotificationLibelleS notif = new NotificationLibelleS();
    
    String etat = request.getParameter("etat");
    if(etat != null && etat.compareToIgnoreCase("") != 0){
        notif.setNomTable(request.getParameter("etat"));
    }
    if(etat == null){
        etat = "NOTIFICATION_LIBELLE3_NONLU";
        notif.setNomTable(etat);
    }
   
    UserEJB ue = (UserEJB) session.getValue("u");
    int inboxNotif = ue.getNotificationNonLus();         
            
    String listeCrt[] = {"id", "objet", "expediteur", "daty", "heure", "destinataire", "service", "direction","sous_prestation_libelle"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "objet", "expediteur", "daty", "heure", "destinataire", "service", "direction","sous_prestation_libelle"};
    PageRecherche pr = new PageRecherche(notif, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("sous_prestation_libelle").setLibelle("Sous prestation");
     pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("sous_prestation_libelle").setLibelle("Sous prestation");
    pr.setApres("notification/notification-liste.jsp");
    String[] colSomme = null;
    String awere = "";
    if ((request.getParameter("daty1") == null && request.getParameter("daty2") == null)) {
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
        awere += " and daty='" + Utilitaire.dateDuJour() + "'";
    }
    pr.setAWhere(awere);
    pr.creerObjetPage(libEntete, colSomme);
%>

<% if(inboxNotif>0){%>
    <script>
        $( document ).ready(function() {
            //$.notify("Vous avez <%=inboxNotif%> notification(s) non lue(s)", "success");
        });
    </script>
<% } %>
<script>
    function changerDesignation() {
        document.notification_form.submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Notifications</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=notification/notification-liste.jsp" method="post" name="notification_form" id="notification_form">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row">    
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label>Etat : </label>
                        <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                            <% if (etat == null || etat.compareToIgnoreCase("") == 0) {%>
                            <option value="" selected>Tous </option>
                            <% } else { %>
                            <option value="">Tous</option>
                            <% } %>

                            <% if (etat != null && etat.compareToIgnoreCase("NOTIFICATION_LIBELLE3_LU") == 0) {%>
                            <option value="NOTIFICATION_LIBELLE3_LU" selected>Lu</option>
                            <% } else { %>
                            <option value="NOTIFICATION_LIBELLE3_LU">Lu</option>
                            <% } %>

                            <% if (etat != null && etat.compareToIgnoreCase("NOTIFICATION_LIBELLE3_NONLU") == 0) {%>
                            <option value="NOTIFICATION_LIBELLE3_NONLU" selected>Non lu</option>
                            <% } else { %>
                            <option value="NOTIFICATION_LIBELLE3_NONLU">Non lu</option>
                            <% } %>

                        </select>
                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
		   
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=notification/notification-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="notification" id="notification">
            <input name="bute" type="hidden" id="bute" value="notification/notification-liste.jsp">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.notification.NotificationMessage">
        <%
            String libEnteteAffiche[] = {"ID", "Objet", "Expediteur", "Date", "Heure", "Destinataire", "Service Dest", "Direction Dest","Sous prestation "};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setNameActe("marquerLu");
            pr.getTableau().setNameBoutton("Marquer comme lu");
            if(etat != null && !etat.endsWith("_LU"))
                out.println(pr.getTableau().getHtmlWithCheckbox());
            else
                out.println(pr.getTableau().getHtml());
        %>
        
        </form>
        <% out.println(pr.getBasPage()); %>
    </section>
</div>
