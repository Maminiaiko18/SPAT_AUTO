<%-- 
    Document   : sortiecaisse-saisie
    Created on : 27 nov. 2020, 11:36:38
    Author     : Tsiory
--%>

<%@page import="mg.spat.Caisse"%>
<%@page import="mg.allosakafo.fin.*"%>

<%@page import="user.*"%> 
<%@ page import="bean.TypeObjet" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="bean.*"%>
<%@page import="ded.*"%>
<%@page import="java.sql.Connection"%>


<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    MvtCaisse a = new MvtCaisse();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("idordre").setLibelle("Reference");

    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("datyvaleur").setLibelle("Date valeur");

    pi.getFormu().getChamp("typemvt").setVisible(false);
    pi.getFormu().getChamp("debit").setLibelle("Montant");
    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("numpiece").setLibelle("N piece");
    pi.getFormu().getChamp("numcheque").setLibelle("N cheque");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("remarque").setType("textarea");

    /* ??? */
    pi.getFormu().getChamp("tiers").setLibelle("Tiers");

    affichage.Champ[] liste = new affichage.Champ[3];

    TypeObjet ou = new TypeObjet();
    ou.setNomTable("DEVISEDEMAT");
    liste[0] = new Liste("iddevise", ou, "VAL", "id");

    TypeObjet ou1 = new TypeObjet();
    ou1.setNomTable("modepaiement");
    liste[1] = new Liste("idmode", ou1, "VAL", "id");

    Caisse ou2 = new Caisse();
    ou2.setNomTable("caisse");
    liste[2] = new Liste("idcaisse", ou2, "numero", "id");

    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("idmode").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("idcaisse").setLibelle("Caisse");
    pi.getFormu().getChamp("credit").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);

    pi.getFormu().getChamp("idMode").setDefaut("pay1");
    pi.getFormu().getChamp("typemvt").setDefaut("1");
    pi.getFormu().getChamp("typemvt").setLibelle("Type mouvement");
    pi.getFormu().getChamp("typemvt").setDefaut("1");
    pi.getFormu().getChamp("typemvt").setLibelle("Type mouvement");

    if (request.getParameter("id") != null) {
        OrdonnerPayement[] ord = (OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, null, " and id = '" + request.getParameter("id") + "'");
        if (ord.length > 0) {
            pi.getFormu().getChamp("designation").setDefaut(ord[0].getRemarque());
            pi.getFormu().getChamp("debit").setDefaut(String.valueOf(ord[0].getMontant()));
            pi.getFormu().getChamp("idordre").setDefaut(ord[0].getId());
            pi.getFormu().getChamp("idordre").setAutre("readonly");
            //  pi.getFormu().getChamp("tiers").setDefaut(ord[0].getDed_Id());
            //pi.getFormu().getChamp("tiers").setAutre("readonly");

        }
    }
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Enregistrer Sortie Caisse</h1>
    <form class='container' action="<%=pi.getLien()%>?but=fin/apresMvt.jsp" method="post" name="ded_op" id="ded_op">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="fin/mvtcaisse-fiche.jsp">

        <input name="classe" type="hidden" id="classe" value="mg.allosakafo.fin.MvtCaisse">
    </form>
</div>