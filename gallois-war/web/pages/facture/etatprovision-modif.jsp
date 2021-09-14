
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="facture.EtatProvision"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%
   String titre ="Modification état provision",
   bute ="facture/etatprovision-fiche.jsp&id="+request.getParameter("id"),
   classe="facture.EtatProvision",
   nomtable = "etat_provision";
%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u;
    EtatProvision a = new EtatProvision();
    a.setNomTable("etat_provisionlib");
    
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    a = (EtatProvision) pi.getBase();
    
    pi.getFormu().getChamp("idnavire").setPageAppel("choix/listeNavireChoix.jsp", "idnavire;idnavirelibelle");
    pi.getFormu().getChamp("idnavire").setAutre("readonly");
    
    pi.getFormu().getChamp("idFacture").setPageAppel("choix/listeFactureClientChoix.jsp", "idFacture;idFacturelibelle");
    pi.getFormu().getChamp("idFacture").setAutre("readonly");
    
    affichage.Champ[] listeUnit = new affichage.Champ[2];
    
    TypeObjet t1=new TypeObjet();
    t1.setNomTable("modepaiement");
    listeUnit[0]=new Liste("idmode",t1,"val","id");
    
    TypeObjet t2=new TypeObjet();
    t2.setNomTable("banque");
    listeUnit[1]=new Liste("idbanque",t2,"val","id");
    
    pi.getFormu().changerEnChamp(listeUnit);
    
    pi.getFormu().getChamp("idmodelib").setVisible(false);
    pi.getFormu().getChamp("idbanquelib").setVisible(false);
    pi.getFormu().getChamp("idnavirelib").setVisible(false);
    pi.getFormu().getChamp("idFacturelib").setVisible(false);
    pi.getFormu().getChamp("tierslib").setVisible(false);
    
    pi.getFormu().getChamp("idmode").setLibelle("Mode");
    pi.getFormu().getChamp("idbanque").setLibelle("Banque");
    pi.getFormu().getChamp("idnavire").setLibelle("Navire");
    pi.getFormu().getChamp("idFacture").setLibelle("Facture");
    pi.getFormu().getChamp("numpiece").setLibelle("Num pièce");
    pi.getFormu().getChamp("numProvision").setLibelle("Num provision");
    
    pi.preparerDataFormu();
    String idFacture = request.getParameter("idFacture");
    if(idFacture != null && !idFacture.equals("")){
        pi.getFormu().getChamp("idFacture").setDefaut(request.getParameter("idFacture"));
    }
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <h1 class="text-center"><%= titre  %></h1>
                <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="acte" value="update">
                    <input name="bute" type="hidden" id="bute" value="<%= bute  %>">
                    <input name="classe" type="hidden" id="classe" value="<%= classe  %>">
                    <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable  %>">
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("idnavire").value = "<%= Utilitaire.champNull(a.getIdnavire()) %>";
    document.getElementById("idnavirelibelle").value = "<%= Utilitaire.champNull(a.getIdnavirelib()) %>";
    
    <% if(idFacture == null || idFacture.equals("")){ %>
        document.getElementById("idFacture").value = "<%= Utilitaire.champNull(a.getIdFacture()) %>";
        document.getElementById("idFacturelibelle").value = "<%= Utilitaire.champNull(a.getIdFacturelib()) %>";
    <% } %>
</script>
<%
    }catch(Exception e){
        e.printStackTrace();
    }
%>