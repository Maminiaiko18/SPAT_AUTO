<%@page import="ded.OrdonnerPayement"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="mg.spat.ChantierLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    OrdonnerPayement op = new OrdonnerPayement();
    op.setNomTable("ORDONNERPAYEMENT_LIBETAT");
    if(request.getParameter("etatvue")!=null){
        op.setNomTable(request.getParameter("etatvue"));
    }
    
//    String libEntete[] = {"id", "ded_Id","remarque","numcheque","daty","folio","numeroop","montant"};
    String libEntete[] = {"id","numeroop","daty","tiers","ded_Id","remarque","montant", "etatlib","modepaiementlib"};
    String listeCrt[] = {"id","ded_Id", "daty","numeroop","modepaiementlib"};
    String listeInt[] = {"daty"};
    PageRecherche pr = new PageRecherche(op, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ded/ordonnerpayement-liste.jsp");
    pr.getFormu().getChamp("ded_Id").setLibelle("facture");
    pr.getFormu().getChamp("daty1").setLibelle("date de début");
    pr.getFormu().getChamp("daty2").setLibelle("date fin");
    pr.getFormu().getChamp("numeroop").setLibelle("Numero Op");
    pr.getFormu().getChamp("modepaiementlib").setLibelle("Mode de paiement");
    String[] colSomme ={"montant"};
    pr.creerObjetPage(libEntete, colSomme);
    pr.getTableau().setNameBoutton("Editer bordereau");
%>
<script>
    function changerDesignation() {
        document.travaux.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste OP</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ded/ordonnerpayement-liste.jsp" method="post" name="travaux" id="travaux">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="ORDONNERPAYEMENT_LIBETAT" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("ORDONNERPAYEMENT_LIBETAT")==0) {
                                out.print(" selected");
                            }%>>Tous</option>
                        <option value="OrdonnerPayement_Cree" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("OrdonnerPayement_Cree") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;e(s)</option>
                        <option value="ordonnerpayement_n_paye" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("ordonnerpayement_n_paye") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;(s) en attente de paiement</option>
                        <option value="ordonnerpayement_paye_lib" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("ordonnerpayement_paye_lib") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;(s) et pay&eacute;(s)</option>
                        <option value="OrdonnerPayement_Annule" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("OrdonnerPayement_Annule") == 0) {
                                out.print("selected");
                            }%>>Annul&eacute;</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="form_op" id="form_op">
            <input type="hidden" name="bute" value="ded/bordereaux-saisie.jsp"/>
            <input type="hidden" name="classe" value="ded.OrdonnerPayement"/>
            <input type="hidden" name="acte" id="acte" value="ajouterOP"/>
            <%
                String lienTableau[] = {pr.getLien() + "?but=ded/ordonnerpayement-fiche.jsp"};
                String colonneLien[] = {"id"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setColonneLien(colonneLien);
                out.println(pr.getTableauRecap().getHtml());
            %>
            <br>
            <%
                String libEnteteAffiche[] = {"id","Numéro OP","Date","Tiers","facture","Motif de paiement","Montant", "Etat","Mode de paiement"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("ajouterOP");
                out.println(pr.getTableau().getHtmlWithCheckbox());
                out.println(pr.getBasPage());
            %>
        </form>
    </section>
</div>
        <% }catch(Exception e) {e.printStackTrace();}%>

