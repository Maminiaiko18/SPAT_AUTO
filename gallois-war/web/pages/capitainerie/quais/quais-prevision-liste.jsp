<%-- 
    Document   : quais-prevision-liste.jsp
    Created on : 18 nov. 2019, 09:15:06
    Author     : rajao
--%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="mg.spat.PrevisionLibComplet"%>
<%@page import="mg.spat.Prevision"%>
<%@page import="affichage.PageRecherche"%>
<%
    try{
        String[] vuesEtat = new String[]{"previsionLibComplet","previsionlibcompletc", "previsionlibcompletv", "previsionlibcompleta"};
        String[] libsEtat = new String[]{"TOUS","CREE", "VALIDE", "ANNULE"};
        String selectedEtat = request.getParameter("etat");
        PrevisionLibComplet prevision=new PrevisionLibComplet();
        if(selectedEtat!= null && !selectedEtat.equals("")){
            prevision.setNomTable(selectedEtat);
        }else{
            prevision.setNomTable("PREVISIONLIBCOMPLET");
        }
      
      
      String listeCtrl[]={"id","paysprovenance","quaiprovenance","escale","nomnavire","valconsignataire","valcargaison","valpilote","date_arrivee","heure_arrivee","date_depart","heure_depart","paysdestination","noVoyage"};
      String listeInt[]={"date_arrivee","date_depart"};
      String libEntete[]={"id","valpaysprovenance", "valquaisprovenance","escale","nomnavire","valconsignataire","valcargaison","date_arrivee","heure_arrivee","date_depart","heure_depart","valpaysdestination","valquaisdestination","valpilote","noVoyage"};
      PageRecherche pr=new PageRecherche(prevision,request,listeCtrl,listeInt,3,libEntete,libEntete.length);
      pr.setUtilisateur((user.UserEJB) session.getValue("u"));
      pr.setLien((String) session.getValue("lien"));
      //pr.setAWhere(" and etat != "+ConstanteEtat.getEtatValider()+" and etatnavire!="+ConstanteEtat.getEtatAnnuler());
      pr.setAWhere(" order by date_arrivee asc");
      pr.getFormu().getChamp("Date_arrivee1").setLibelle("Date d'arrivée Min");
      pr.getFormu().getChamp("Date_arrivee2").setLibelle("Date d'arrivée Max");
      pr.getFormu().getChamp("Date_depart1").setLibelle("date de départ Min");
      pr.getFormu().getChamp("Date_depart2").setLibelle("date de départ Max");
      pr.getFormu().getChamp("heure_arrivee").setLibelle("Heure d'arrivée");
      pr.getFormu().getChamp("heure_depart").setLibelle("Heure du depart");
      pr.getFormu().getChamp("paysprovenance").setLibelle("Provenance");
      pr.getFormu().getChamp("nomnavire").setLibelle("Navire");
      pr.getFormu().getChamp("valpilote").setLibelle("Commandant");
      pr.getFormu().getChamp("quaiprovenance").setLibelle("Quais");
      
      pr.getFormu().getChamp("paysdestination").setLibelle("Destination");
      pr.getFormu().getChamp("valcargaison").setLibelle("Cargaison");
      pr.getFormu().getChamp("valconsignataire").setLibelle("Consignataire");
      pr.getFormu().getChamp("noVoyage").setLibelle("Numero voyage");
    pr.setApres("capitainerie/quais/quais-prevision-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme); 
      
%>
<script>
    function getRepFiltre(){
        document.getElementById("listeprevisionquais").submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste de prévisions des quais</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/quais/quais-prevision-liste.jsp" method="post" name="listeprevisionquais" id="listeprevisionquais">
            <% out.println(pr.getFormu().getHtmlEnsemble()); %>
            
            <center>
                Etat : 
                    <select name="etat" class="champ form-control" onchange="getRepFiltre()" id="etat" style="display: inline-block; width: 250px;">
                        <%for(int i=0; i<vuesEtat.length; i++){%>
                            <option value="<%=vuesEtat[i]%>" <%= prevision.getNomTable().equals(vuesEtat[i]) ? "selected" : "" %>><%=libsEtat[i]%></option>
                        <%}%>
                    </select>
            </center>
            <br/>
        </form>
        <% String lienTableau[] = {pr.getLien() + "?but=capita"
                    + "inerie/quais/quais-prevision-fiche.jsp&tab=liste-mouvement"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br />
        
        <%
            String libEnteteAffiche[] = {"id","Pays Provenance","Quai de provenance","Escale" ," Nom Navire","Consignataire","Cargaison","date d'arrivée","heure d' arrivée","date de depart","heure du depart","destination","Quai de destination","Commandant","Numero voyage"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage()); 
        %>
    </section>
</div>
     <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
            