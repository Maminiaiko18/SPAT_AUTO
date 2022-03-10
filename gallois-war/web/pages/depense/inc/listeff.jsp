<%-- 
    Document   : listeff.jsp
    Created on : 22 févr. 2022, 15:20:49
    Author     : andri
--%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="facture.FactureFournisseur"%>
<%
    FactureFournisseur j = new FactureFournisseur();
        j.setNomTable("FACTUREFOURNVALIDE_TOUS");
     String libEntete[] = {"id","daty","tierslib", "numeroop", "code", "projetlib", "code_etablissementlib", "naturelib","designation","exercice","date_echeance", "montantTTCvrai", "montantAvoir", "montantTTC", "montantpaye","montantreste","numOP", "etatlib"};
    String listeCrt[] = {"idengagement"};
    String listeInt[] = {};
    
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
       
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    
    pr.getTableau().setLibelleAffiche(new String[]{"id","Date","Fournisseur", "N° Facture","Numero compta", "Projet", "Code direction", "Nature","Note explicative","exercice", "date echeance", "montant TTC", "montant Avoir", "Net à payer", "Montant payé","Reste à payer","Numero OP", "Etat"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtmlWithCheckbox();    
    if(html != null){ %>
    <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" method="post" name="formff" id="formff">
         <input type="hidden" id="bute" name="bute" value="depense/engagement-fiche.jsp&id=<%=request.getParameter("idengagement")%>"/>
            <input type="hidden" name="classe" value="facture.FactureFournisseur"/>
            <input type="hidden" id="acte" name="acte" value="valider"/>
            <% out.println(html); %>
            <div style="display: flex; justify-content: flex-end; align-items: center;">
                <input type="button" class="btn btn-info" onclick="editerBED()" style="margin:10px" value="Editer BED"/>
            </div>
    </form>
    <script>
        function editerBED() {
            document.getElementById("acte").value =  "editerBED";
            document.getElementById("bute").value =  "ded/bordereauxFF-saisie.jsp";
            document.getElementById("formff").action = '<%=pr.getLien()%>?but=apresFacture.jsp';
            document.getElementById("formff").submit();
        }
    </script>        
    <% }else{
        %><center><h4>Pas de résultat</h4></center><%
    }
%>
        
  