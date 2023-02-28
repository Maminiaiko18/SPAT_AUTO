<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.MvtIntraCaisseTraite"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="bean.*"%>
<%@page import="utilitaire.*"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        MvtIntraCaisseTraite eng = new MvtIntraCaisseTraite();
        eng.setNomTable("MVTINTRACAISSETRAITEV");

        String listeCrt[] = {"id", "designation","idTraite","daty", "caissedepart", "caissearrivee","modepaiement","montant","dateecheance"};
        String listeInt[] = {"daty","montant","dateecheance"};
        String libEntete[] = {"id", "designation","idTraite","daty", "caissedepartlib", "caissearriveelib","modepaiementlib","montant","remarque","etatlib"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        pr.getFormu().getChamp("montant1").setLibelle("Montant Min");
        pr.getFormu().getChamp("montant2").setLibelle("Montant Max");
        pr.getFormu().getChamp("dateecheance1").setLibelle("Date &Eacute;ch&eacute;ance Min");
        pr.getFormu().getChamp("dateecheance2").setLibelle("Date &Eacute;ch&eacute;ance Max");
        pr.getFormu().getChamp("caissedepart").setLibelle("Caisse Depart");
        pr.getFormu().getChamp("caissearrivee").setLibelle("Caisse Arrivee");
        pr.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
       
        pr.setAWhere(" AND idTraite is not null AND etatversement = "+ConstanteEtat.getEtatValider());
        pr.setApres("facture/traite-encaissement-versee-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        
        Caisse caisse=new Caisse();
        caisse.setDesce("Banque");
        Caisse[] listeCaisse=(Caisse[])CGenUtil.rechercher(caisse,null,null,"");
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des traites versees</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/traite-encaissement-versee-liste.jsp" method="post" name="engagement" id="engagement">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>

        </form>
        <%  
            String lienTableau[] = {pr.getLien() + "?but=facture/traite-encaissement-versee-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <form action="<%=pr.getLien()%>?but=apresVerserTraite.jsp" method="post">
         
        <div>
            <label for="idcaisse">Caisse:</label>
            <select name="idcaisse">
                <%for(int i=0;i<listeCaisse.length;i++){%>
                <option value="<%=listeCaisse[i].getId()%>"><%=listeCaisse[i].getVal()%></option>
                <%}%>
            </select>
            
        </div>
        <div>
            <label for="date">Date:</label>
            <input type="text" class="form-control datepicker" onkeydown="return searchKeyPress(event)" name="date" id="date" value="<%=Utilitaire.dateDuJour()%>">
        </div>
        
        <%
            String libEnteteAffiche[] = {"id", "designation","Traite","Date", "Caisse Depart", "Caisse Arrivee","Mode Paiement","Montant","Remarque","Etat"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setNameBoutton("Encaisser");
            pr.getTableau().setNameActe("encaissementTraite");
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        <input type="hidden" name="acte" id="acte" value="encaissementTraite">
        <input type="hidden" name="bute" id="bute" value="facture/traite-encaissement-versee-liste.jsp">
        </form>
        <% out.println(pr.getBasPage()); %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>