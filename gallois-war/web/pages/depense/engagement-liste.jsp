<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.Engagement"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilisateur.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
        Engagement eng = new Engagement();
        eng.setNomTable("engagementlib");
        String nomTableEtat = request.getParameter("nomTableEtat");
        if(nomTableEtat!=null && !nomTableEtat.isEmpty()){
        eng.setNomTable(nomTableEtat);
        }

        UserEJB u = (user.UserEJB) session.getValue("u");
        Prioritaire prioritaire = new Prioritaire();
        String aWhere = prioritaire.makeListConfidentiality(u,"codeetablissementlib");
        System.out.println("aWhere "+aWhere);

        String listeCrt[] = {"id", "designation", "codeetablissementlib", "projetlib", "daty", "tierslib", "num", "idtype"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "designation","idtypelib","compte", "montant", "montantOP", "montantreste", "dispoavant", "dispoapres", "codeetablissementlib", "projetlib", "tierslib", "daty", "num","montantliberer"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);

        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);

        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);

        }
        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("codeetablissementlib").setLibelle("Code &eacute;tablissemment");
        pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("id").setLibelle("Id");
        pr.getFormu().getChamp("num").setLibelle("No.");
        
        Liste[] listes = new Liste[1];
        TypeObjet catAchat = new TypeObjet();
        catAchat.setNomTable("typeengagement");
        listes[0] = new Liste("idtype", catAchat, "val", "id");
        pr.getFormu().changerEnChamp(listes);
        pr.getFormu().getChamp("idtype").setLibelle("Type");
        pr.setApres("depense/engagement-liste.jsp");
        pr.setAWhere(aWhere);


        String[] colSomme ={"montant","montantreste","montantliberer"};
        pr.creerObjetPage(libEntete, colSomme);
        String[] etatVal = {"engagementlib", "engagementlibC", "engagementlibV","engagementlibA"};
        String[] etatAff = {"Tous", "Cr&eacute;&eacute;", "Vis&eacute;","Annul&eacute;"};

%>
<script>
    function submitFormulaire(){
        document.getElementById("engagement").submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Engagements </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=depense/engagement-liste.jsp" method="post" name="engagement" id="engagement">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row">
                <div class="col-md-12">
                    <br>
                    <select name="nomTableEtat" id="nomTableEtat" onchange="submitFormulaire()" class="form-control"style="max-width: 200px; margin: 0 auto;">
                            <%for(int i=0; i<etatVal.length; i++){
                                String selected = eng.getNomTable().equalsIgnoreCase(etatVal[i]) ? "selected" : "";
                            %>
                            <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                            <%}%>
                        </select>
                    <br>
                </div>
            </div>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=depense/engagement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] ={"Id", "D&eacute;signation","Type","compte", "Montant", "Montant d'ordre payement", "Disponibilit&eacute;", "Disponibilit&eacute; avant", "Disponibilit&eacute; apr&egrave;s", "Code &eacute;tablissement", "Projet", "Tiers", "Date", "No.","montant liberé"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>