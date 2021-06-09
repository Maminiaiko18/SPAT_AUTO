<%-- 
    Document   : mouvement-saisie
    Created on : 6 nov. 2019, 11:20:59
    Author     : Notiavina
--%>

<%@page import="mg.spat.PrevisionLibComplet"%>
<%@page import="mg.spat.Prevision"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@page import="mg.spat.Mouvement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Mouvement pj = new Mouvement();
        pj.setId(request.getParameter("id"));
        MouvementLibComplet mvtLibComp = pj.getMouvementLibCompletById(null);

        String typemvt = request.getParameter("typemvt");

        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.setTitre("Saisie occupation");

        if (request.getParameter("idPrevision") != null) {
            Prevision prev = new Prevision();
            prev.setId(request.getParameter("idPrevision"));
            PrevisionLibComplet preveLibC = prev.getPrevisionLibCompletById(null);
            System.out.println("preveLibC-----------------------------------" + preveLibC);
            pi.getFormu().getChamp("escale").setDefaut(preveLibC.getId());
            pi.getFormu().getChamp("escale").setValeurLibelle(preveLibC.getEscale());
            pi.getFormu().getChamp("navire").setDefaut(preveLibC.getNavire());
            pi.getFormu().getChamp("navire").setValeurLibelle(preveLibC.getNomnavire());
            pi.getFormu().getChamp("consignataire").setDefaut(preveLibC.getConsignataire());
            pi.getFormu().getChamp("consignataire").setValeurLibelle(preveLibC.getValconsignataire());
            pi.getFormu().getChamp("provenance").setDefaut(preveLibC.getProvenance());
            pi.getFormu().getChamp("provenance").setValeurLibelle(preveLibC.getValtypequaisprovenance() + "-" + preveLibC.getValpaysprovenance());
            pi.getFormu().getChamp("cargaison").setDefaut(preveLibC.getCargaison());
            pi.getFormu().getChamp("cargaison").setValeurLibelle(preveLibC.getValcargaison());
            pi.getFormu().getChamp("destination").setDefaut(preveLibC.getDestination());
            pi.getFormu().getChamp("destination").setValeurLibelle(preveLibC.getValtypequaisdestination() + "-" + preveLibC.getValquaisdestination());
        }

        pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
        pi.getFormu().getChamp("consignataire").setPageAppel("choix/listeClientChoix.jsp");
        pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireTousChoix.jsp");
        pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireTousChoix.jsp");
        pi.getFormu().getChamp("cargaison").setPageAppel("choix/listeCargaisonChoix.jsp");

        pi.getFormu().getChamp("navire").setAutre("readonly");
        pi.getFormu().getChamp("consignataire").setAutre("readonly");
        pi.getFormu().getChamp("destination").setAutre("readonly");
        pi.getFormu().getChamp("provenance").setAutre("readonly");
        pi.getFormu().getChamp("cargaison").setAutre("readonly");

//    pi.getFormu().getChamp("typeMvt").setVisible(false);
        pi.getFormu().getChamp("duree").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("daty").setVisible(false);

        if (mvtLibComp != null) {
            pi.getFormu().getChamp("consignataire").setValeurLibelle(mvtLibComp.getValconsignataire());
            pi.getFormu().getChamp("navire").setValeurLibelle(mvtLibComp.getNomnavire());
            pi.getFormu().getChamp("escale").setDefaut(mvtLibComp.getIdprevision());
            pi.getFormu().getChamp("escale").setValeurLibelle(mvtLibComp.getEscale());
            pi.getFormu().getChamp("cargaison").setValeurLibelle(mvtLibComp.getValcargaison());
            pi.getFormu().getChamp("navire").setDefaut(mvtLibComp.getNavire());
            pi.getFormu().getChamp("PROVENANCE").setDefaut(mvtLibComp.getProvenance());
            pi.getFormu().getChamp("CONSIGNATAIRE").setDefaut(mvtLibComp.getConsignataire());
            pi.getFormu().getChamp("cargaison").setDefaut(mvtLibComp.getCargaison());
            if (request.getParameter("typemvt") != null && request.getParameter("typemvt").equals(Constante.tpmvtdepart)) {
                pi.getFormu().getChamp("provenance").setValeurLibelle(mvtLibComp.getValpaysdestination() + "-" + mvtLibComp.getValquaisdestination());
                pi.getFormu().getChamp("provenance").setDefaut(mvtLibComp.getDestination());
                pi.getFormu().getChamp("heure_depart").setDefaut(Utilitaire.heureCouranteHMS());
//            pi.getFormu().getChamp("date_depart").setDefaut(Utilitaire.dateDuJour());
            } else {
                pi.getFormu().getChamp("heure").setDefaut(Utilitaire.heureCouranteHMS());
                pi.getFormu().getChamp("dateArrivee").setDefaut(Utilitaire.dateDuJour());
                pi.getFormu().getChamp("provenance").setValeurLibelle(mvtLibComp.getValpaysprovenance() + "-" + mvtLibComp.getValquaisprovenance());
                pi.getFormu().getChamp("destination").setValeurLibelle(mvtLibComp.getValpaysdestination() + " - " + mvtLibComp.getValquaisdestination());
                pi.getFormu().getChamp("destination").setDefaut(mvtLibComp.getDestination());
            }
//        pi.getFormu().getChamp("heure").setDefaut(mvtLibComp.getHeure());
        }
        if (typemvt != null) {
            pi.getFormu().getChamp("typeMvt").setDefaut(typemvt);

            if (typemvt.equals(Constante.tpmvtdepart)) {
                pi.setTitre("Saisie départ");
                pi.getFormu().getChamp("heure").setVisible(false);
                pi.getFormu().getChamp("datearrivee").setVisible(false);
            } else {
                pi.setTitre("Saisie arrivée");
                pi.getFormu().getChamp("heure_depart").setVisible(false);
                pi.getFormu().getChamp("date_depart").setVisible(false);
            }
        }

        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet liste1 = new TypeObjet();
        liste1.setNomTable("TYPEMVT");
        liste[0] = new Liste("typeMvt", liste1, "val", "id");
        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("heure").setLibelle("Heure d'arrivee");
        pi.getFormu().getChamp("date_depart").setLibelle("Date depart");
        pi.getFormu().getChamp("heure_depart").setLibelle("Heure de depart");
        pi.getFormu().getChamp("dateArrivee").setLibelle("Date Arrivee");
        pi.getFormu().getChamp("escale").setPageAppel("choix/listePrevisionChoix.jsp");
        pi.getFormu().getChamp("escale").setAutre("readonly");
        pi.getFormu().getChamp("navire").setLibelle("Navire");
        pi.getFormu().getChamp("PROVENANCE").setLibelle("Provenance");
        pi.getFormu().getChamp("DESTINATION").setLibelle("Quai");
        pi.getFormu().getChamp("CONSIGNATAIRE").setLibelle("Consignataire");
        pi.getFormu().getChamp("typeMvt").setLibelle("Type mouvement");

        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1><%=pi.getTitre()%></h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <!--<input name="typeMvt" type="hidden" id="daty" value="<%=request.getParameter("typemvt")%>">-->
    <!--<input name="daty" type="hidden" id="daty" value="<%=Utilitaire.dateDuJour()%>">-->
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="capitainerie/mouvement-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.Mouvement">
    </form>
</div>
<script>
    <%
        if(typemvt == null || !typemvt.equals(Constante.tpmvtdepart)) {
    %>
        $('#date_depart').val("");
    <% } else { %>
        $('#datearrivee').val("");
    <% } %>
</script>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>