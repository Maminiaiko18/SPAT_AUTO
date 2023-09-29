
<%@page import="mg.spat.relationhumaine.InfoPersonnelGlobal"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%   
    try{
        /*   private int age, anciennete, indice;
    private double salaire_base, indemnite_fonction, indemnite_conge_paye, indemnite_deplacement, indemnite_risque;*/
    String autreparsley = "data-parsley-range='[8, 40]' required";
    InfoPersonnelGlobal pj = new InfoPersonnelGlobal();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("nom").setLibelle("Nom *");
    pi.getFormu().getChamp("prenom").setLibelle("Prenom *");
    pi.getFormu().getChamp("datenaissance").setLibelle("Date de naissance *");
    pi.getFormu().getChamp("genre").setLibelle("Genre *");
    pi.getFormu().getChamp("adresse").setLibelle("Adresse *");
    pi.getFormu().getChamp("indice").setLibelle("Indice *");
    pi.getFormu().getChamp("numero_cin").setLibelle("Numero cin *");
    pi.getFormu().getChamp("telephone").setLibelle("Telephone *");
    pi.getFormu().getChamp("numero_matricule").setLibelle("Numero matricule *");
    pi.getFormu().getChamp("date_embauche").setLibelle("Date embauche *");
    pi.getFormu().getChamp("anciennete_poste").setLibelle("Anciennet� poste");
    pi.getFormu().getChamp("nom_prenom_epoux").setLibelle("Nom et pr�nom de l'�poux");
    pi.getFormu().getChamp("nom_prenom_pere").setLibelle("Nom et pr�nom du p�re *");
    pi.getFormu().getChamp("nom_prenom_mere").setLibelle("Nom et pr�nom de la m�re *");
    pi.getFormu().getChamp("Indemnite_fonction").setLibelle("Indemnite de fonction *");
    pi.getFormu().getChamp("Indemnite_conge_paye").setLibelle("Indemnite de conge pay� *");
    pi.getFormu().getChamp("Indemnite_deplacement").setLibelle("Indemnite de d�placement *");
    pi.getFormu().getChamp("Indemnite_risque").setLibelle("Indemnite de risque *");
    pi.getFormu().getChamp("Numero_virement").setLibelle("numero virement");
    pi.getFormu().getChamp("Numero_cnaps").setLibelle("numero cnaps");
    pi.getFormu().getChamp("Salaire_base").setLibelle("salaire de base *");
    pi.getFormu().getChamp("age").setVisible(true);
    pi.getFormu().getChamp("idtiers").setVisible(false);
    pi.getFormu().getChamp("direction").setPageAppel("choix/listeDirectionChoix.jsp");
    pi.getFormu().getChamp("direction").setAutre("readonly");
    
  
    
    pi.getFormu().getChamp("date_embauche").setDefaut(Utilitaire.dateDuJour());
    
//    pi.getFormu().getChamp("mode_paiement").setLibelle("Mode de paiement");
//    pi.getFormu().getChamp("situation_matrimoniale").setLibelle("Situation matrimoniale");
    
    affichage.Champ[] liste = new affichage.Champ[5];
    Liste li = new Liste("genre");
    String [] val_li = {"M", "F"};
    String [] aff_li = {"Masculin", "F�minin"};
    li.ajouterValeur(val_li, aff_li);
    liste[0]=li;
    
    Liste situation = new Liste("situation_matrimoniale");
    String [] val_situation = {"C�libataire", "Mari�", "Divorc�", "Veuf"};
    String [] aff_situation = {"C�libataire", "Mari�", "Divorc�", "Veuf"};
    situation.ajouterValeur(val_situation, aff_situation);
    liste[1]=situation;
    
    Liste mode = new Liste("Mode_paiement");
    String [] val_mode = {"Espece", "Cheque", "Mobile money"};
    String [] aff_mode = {"Espece", "Cheque", "Mobile money"};
    mode.ajouterValeur(val_mode, aff_mode);
    liste[2] = mode;
    
    Liste contrat = new Liste("type_contrat");
    String [] val_contrat = {"TC00002", "TC00001"};
    String [] aff_contrat = {"CDD", "CDI"};
    contrat.ajouterValeur(val_contrat, aff_contrat);
    liste[3] = contrat;
    
    TypeObjet categ = new TypeObjet();
    categ.setNomTable("CATEGORIE_PROFESSIONNEL");
    liste[4] = new Liste("idcategorieprofessionel", categ, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("situation_matrimoniale").setLibelle("Situation matrimoniale *");
    pi.getFormu().getChamp("Mode_paiement").setLibelle("Mode de paiement *");
    pi.getFormu().getChamp("type_contrat").setLibelle("Type contrat *");
    pi.getFormu().getChamp("idcategorieprofessionel").setLibelle("Cat&eacute;gorie professionnel");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie informations personnelles</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="carriere/identification-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.InfoPersonnelGlobal">
    </form>
</div>
<script>
    var selectElement = document.getElementById("idcategorieprofessionel");

    var nullOption = document.createElement("option");
    nullOption.value = "";
    nullOption.text = "-";
    nullOption.selected = true;

    // Add the null option as the first option in the select
    selectElement.insertBefore(nullOption, selectElement.firstChild);
</script>
<%}catch(Exception e){
    e.printStackTrace();
}%>