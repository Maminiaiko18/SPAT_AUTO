
<%@page import="mg.spat.Caisse"%>
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    JournalCaisseLibComplet a;
    
%>
<%
   String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new JournalCaisseLibComplet();
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
//    pi.getFormu().getChamp("datesaisie").setDefaut(Utilitaire.dateDuJour());
//    pi.getFormu().getChamp("idordre").setDefaut(Utilitaire.champNull(request.getParameter("idordre")));
    pi.getFormu().getChamp("idordre").setAutre("readonly");
    pi.getFormu().getChamp("idordre").setLibelle("Ordre");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("idmode").setLibelle("Mode");
    pi.getFormu().getChamp("numcheque").setLibelle("Numero chèque");
    pi.getFormu().getChamp("typemvt").setLibelle("Type mouvement");
    pi.getFormu().getChamp("datesaisie").setVisible(false);
    pi.getFormu().getChamp("tierslib").setVisible(false);
//    pi.getFormu().getChamp("dateeffet").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("numpiece").setLibelle("Numero pièce");
    pi.getFormu().getChamp("credit").setVisible(false);
    pi.getFormu().getChamp("debit").setLibelle("Montant");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("dateeffet").setLibelle("Date effet");
    pi.getFormu().getChamp("idplacement").setAutre("readonly");
    pi.getFormu().getChamp("idplacement").setLibelle("Source");
    
    affichage.Champ[] liste = new affichage.Champ[3];
    Caisse esc = new Caisse();
    esc.setNomTable("caisse_banque");
    liste[0] = new Liste("caisse", esc, "VAL", "id");
    TypeObjet op = new TypeObjet();
    op.setNomTable("DEVISEDEMAT");
    liste[1] = new Liste("iddevise", op, "desce", "id");
    TypeObjet mode = new TypeObjet();
    mode.setNomTable("MODEPAIEMENTCV");
    liste[2] = new Liste("idmode", mode, "desce", "id");    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("caisse").setLibelle("Banque");
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("idcaisse").setVisible(false);
    pi.getFormu().getChamp("valcaisse").setVisible(false);
    pi.getFormu().getChamp("descecaisse").setVisible(false);
    pi.getFormu().getChamp("valtypecheque").setVisible(false);
    pi.getFormu().getChamp("descetypecheque").setVisible(false);
    pi.getFormu().getChamp("Typemvt").setVisible(false);
    pi.getFormu().getChamp("numPiece").setVisible(false);
    pi.getFormu().getChamp("idtypecheque").setVisible(false);
    pi.getFormu().getChamp("Idordre").setPageAppel("choix/listeOrdonnerPayementChoix.jsp");
    pi.getFormu().getChamp("Idordre").setAutre("readonly");
    pi.getFormu().getChamp("Tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("Tiers").setAutre("readonly");
    pi.getFormu().getChamp("Idordre").setLibelle("Ordre");
    pi.getFormu().getChamp("Iddevise").setLibelle("devise");
    pi.getFormu().getChamp("idmode").setLibelle("Mode de paiement");
    
    pi.preparerDataFormu(); 
    a=(JournalCaisseLibComplet)pi.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <!--<div class="box-fiche">-->
                <div class="box">
                    <h1>Modification depense</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-warning pull-right" name="Submit2" type="submit">Enregistrer les modifications</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="treso/recette-fiche.jsp?id=<%=request.getParameter("id") %>">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.JournalCaisse">
                    </form>
                </div>
            <!--</div>-->
        </div>
    </div>
</div>

<script>
    <%if(a.getIdordre() != null ){%>
        document.getElementById("idordrelibelle").value='<%=a.getIdordre() %>';
    <%}
    if(a.getTierslib() != null ){%>
        document.getElementById("tierslibelle").value='<%=a.getTierslib() %>';
    <%}%>
</script>