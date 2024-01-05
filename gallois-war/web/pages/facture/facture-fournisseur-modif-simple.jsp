<%-- 
    Author     : Michel
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="bean.ClassMAPTable"%>
<%@page import="bean.CGenUtil"%>
<%@page import=" facture.FactureFournisseur"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="affichage.Liste"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    try {
        String acte = "modifierEntete",
                but = "apresFactureF.jsp",
                table = "FACTURE_FOURNISSEUR_MERE",
                classe = "facture.FactureFournisseur",
                bute = "facture/facture-fournisseur-fiche-vaovao.jsp",
                titre = "Modification entête facture fournisseur";
        FactureFournisseur o = new FactureFournisseur();
        o.setNomTable("FACTURE_FOURNISSEUR_MERE");
        PageUpdate pi = new PageUpdate(o, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

        o = (FactureFournisseur) pi.getBase();

        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("designation").setLibelle("Note explicative");
//        pi.getFormu().getChamp("modepaiement").
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp", "tiers;tierslibelle");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp");
        pi.getFormu().getChamp("idengagement").setLibelle("Engagement");
        pi.getFormu().getChamp("idengagement").setAutre("readonly");
        pi.getFormu().getChamp("anneebudgetaire").setLibelle("Ann&eacute;e budg&eacute;taire");

        pi.getFormu().getChamp("type").setVisible(false);
        pi.getFormu().getChamp("tva").setVisible(false);
        pi.getFormu().getChamp("remarque").setLibelle("ref compta");
        pi.getFormu().getChamp("idom").setVisible(false);
        pi.getFormu().getChamp("datedevise").setVisible(false);
        pi.getFormu().getChamp("num").setVisible(false);
        pi.getFormu().getChamp("id").setVisible(false);

        pi.getFormu().getChamp("date_echeance").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idprevision").setVisible(false);
        pi.getFormu().getChamp("idcategorie").setVisible(false);
        pi.getFormu().getChamp("idProvision").setVisible(false);
        pi.getFormu().getChamp("deviseMere").setVisible(false);
        pi.getFormu().getChamp("estDDPMICTSL").setVisible(false);
        pi.getFormu().getChamp("codePrestation").setVisible(false);
        pi.getFormu().getChamp("estmictsl").setVisible(false);
        pi.getFormu().getChamp("idbl").setVisible(false);
        pi.getFormu().getChamp("projet").setVisible(false);
        pi.getFormu().getChamp("code_etablissement").setVisible(false);
        pi.getFormu().getChamp("estAuto").setVisible(false);
        pi.getFormu().getChamp("typeEngagement").setVisible(false);

        Liste[] listes = new Liste[2];
        TypeObjet nature = new TypeObjet();
        nature.setNomTable("nature");
        listes[0] = new Liste("nature", nature, "val", "id");

        TypeObjet modepaiement = new TypeObjet();
        modepaiement.setNomTable("modepaiementbp");
        listes[1] = new Liste("modepaiement", modepaiement, "val", "id");

        pi.getFormu().changerEnChamp(listes);

        pi.getFormu().getChamp("numeroop").setLibelle("N° facture");
        pi.getFormu().getChamp("code").setLibelle("N° Compta");
        pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");

        pi.preparerDataFormu();
        
        ClassMAPTable[] vaovao = pi.getFormu().getChamp("modepaiement").getBase();
        
        List<ClassMAPTable>lMap=Arrays.asList(vaovao);
       List<ClassMAPTable>lMap2=new ArrayList<ClassMAPTable>(lMap);

        lMap2.add(0,new TypeObjet("","-","-"));
        ClassMAPTable[]vaova2=new ClassMAPTable[lMap2.size()];
        for (int idx = 0; idx < lMap2.size(); idx++) {
                ClassMAPTable elem = lMap2.get(idx);
                vaova2[idx]=elem;
            }
        pi.getFormu().getChamp("modepaiement").setBase(vaova2);
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1><%= titre%></h1>
                    <form action="<%=pi.getLien()%>?but=<%= but%>" method="post" name="starticle" id="starticle">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="nature" value="<%= acte%>">
                        <input name="bute" type="hidden" id="bute" value="<%= bute%>">
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= table%>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe%>">
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</div>
<script>
    var designation = document.getElementById("designation");
    var textarea = document.createElement("textarea");
    textarea.name = "designation";
    textarea.id = "designation";
    textarea.className = "form-control";
    textarea.style.height = "100px";
    textarea.value = designation.value;
    designation.parentNode.replaceChild(textarea, designation);

    document.getElementById("tiers").value = "<%= Utilitaire.champNull(o.getTiers())%>";
    document.getElementById("tierslibelle").value = "<%= Utilitaire.champNull(o.getTierslib())%>";

</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>