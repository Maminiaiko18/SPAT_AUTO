<%-- 
    Document   : transfert-caisse-liste
    Created on : 16 janv. 2021, 02:37:15
    Author     : Lenovo
--%>

<%@page import="mg.spat.MvttIntraCaisse"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        MvttIntraCaisse journalCaisse = new MvttIntraCaisse();
        journalCaisse.setNomTable("mvtintracaisse_lib");
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            journalCaisse.setNomTable(request.getParameter("etat"));
        }
        String listeCrt[] = {"id","daty","caissedepart","caissearrivee","modepaiement"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id","daty","caissedepart","caissearrivee","modepaiement","montant"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/transfert-caisse-liste.jsp");

        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
                pr.getFormu().getChamp("caissedepart").setLibelle("caisse depart");
        pr.getFormu().getChamp("caissearrivee").setLibelle("caisse arrivee");
        pr.getFormu().getChamp("modepaiement").setLibelle("mode de paiement");
        pr.setOrdre(" order by daty desc");

        pr.creerObjetPage(libEntete);
        
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste de journal caisses</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/transfert-caisse-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("mvtintracaisse_lib") == 0) {%>    
                        <option value="mvtintracaisse_lib" selected>Tous</option>
                        <% } else { %>
                        <option value="mvtintracaisse_lib" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("mvtintracaisse_lib_cree") == 0) {%>
                        <option value="mvtintracaisse_lib_cree" selected>Cr�e</option>
                        <% } else { %>
                        <option value="mvtintracaisse_lib_cree">Cr�e</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("mvtintracaisse_lib_visee") == 0) {%>
                        <option value="mvtintracaisse_lib_visee" selected>Vis�</option>
                        <% } else { %>
                        <option value="mvtintracaisse_lib_visee">Vis�</option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=treso/transfert-caisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
         
        <%
            String libEnteteAffiche[] ={"id","date","caisse depart","caisse arrivee","mode de paiement","montant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>

        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>