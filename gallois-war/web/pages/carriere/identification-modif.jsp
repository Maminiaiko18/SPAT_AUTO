
<%@page import="mg.spat.relationhumaine.InfoPersonnelGlobal"%>
<%@page import="mg.spat.relationhumaine.InfoPersonnel"%>
<%@page import="mg.spat.Mouvement"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    InfoPersonnelGlobal ident = new InfoPersonnelGlobal();
 
    PageUpdate pi = new PageUpdate(ident, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
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
    pi.getFormu().getChamp("anciennete_poste").setLibelle("Ancienneté poste");
    pi.getFormu().getChamp("nom_prenom_epoux").setLibelle("Nom et prénom de l'époux");
    pi.getFormu().getChamp("nom_prenom_pere").setLibelle("Nom et prénom du père");
    pi.getFormu().getChamp("nom_prenom_mere").setLibelle("Nom et prénom de la mère");
    pi.getFormu().getChamp("Indemnite_fonction").setLibelle("Indemnite de fonction");
    pi.getFormu().getChamp("Indemnite_conge_paye").setLibelle("Indemnite de conge payé");
    pi.getFormu().getChamp("Indemnite_deplacement").setLibelle("Indemnite de déplacement");
    pi.getFormu().getChamp("Indemnite_risque").setLibelle("Indemnite de risque");
    pi.getFormu().getChamp("Numero_virement").setLibelle("numero virement");
    pi.getFormu().getChamp("Numero_cnaps").setLibelle("numero cnaps");
    pi.getFormu().getChamp("Salaire_base").setLibelle("salaire de base *");
   
    affichage.Champ[] liste = new affichage.Champ[4];
    
    Liste li = new Liste("genre");
    String [] val = {"M", "F"};
    String [] aff = {"Masculin", "Féminin"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    
    Liste situation = new Liste("situation_matrimoniale");
    String [] val_situation = {"Célibataire", "Marié", "Divorcé", "Veuf"};
    String [] aff_situation = {"Célibataire", "Marié", "Divorcé", "Veuf"};
    situation.ajouterValeur(val_situation, aff_situation);
    liste[1]=situation;
    
    Liste mode = new Liste("Mode_paiement");
    String [] val_mode = {"Espece", "Cheque", "Mobile money"};
    String [] aff_mode = {"Espece", "Cheque", "Mobile money"};
    mode.ajouterValeur(val_mode, aff_mode);
    liste[2] = mode;
    
    Liste contrat = new Liste("type_contrat");
    String [] val_contrat = {"CDD", "CDI"};
    String [] aff_contrat = {"CDD", "CDI"};
    contrat.ajouterValeur(val_contrat, aff_contrat);
    liste[3] = contrat;
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("situation_matrimoniale").setLibelle("Situation matrimoniale *");
    pi.getFormu().getChamp("Mode_paiement").setLibelle("Mode de paiement *");
    pi.getFormu().getChamp("type_contrat").setLibelle("Type contrat *");
    
    pi.preparerDataFormu();
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="carriere/identification-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.InfoPersonnelGlobal">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="infopersonnelglobal">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
                        