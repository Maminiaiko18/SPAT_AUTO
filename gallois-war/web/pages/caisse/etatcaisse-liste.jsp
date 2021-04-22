<%@page import="java.lang.reflect.Field"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.UtilDB"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="bean.AdminGen"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.amadia.stock.EtatdeStockDate"%>
<%@page import="affichage.*"%>

<%  
    try {
        EtatdeStockDate lv = new EtatdeStockDate();
        lv.setNomTable("AS_ETATSTOCKVIDE"); 
        String listeCrt[] = {"daty", "ingredients"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"ingredients","unite", "daty", "report", "entree", "sortie", "reste","reportSuiv"} ;

        UserEJB u = (user.UserEJB) session.getValue("u");

        //String colDefaut[] = {"ingredients", "unite","point"}; 
        String somDefaut[] = null;
        PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, libEntete.length  );
//        PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete);
        //PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colDefaut, somDefaut, null,7, 3);
        
        pr.setUtilisateur(u);
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("ingredients").setLibelleAffiche("Caisse");
        pr.getFormu().getChamp("daty1").setLibelleAffiche("Date debut");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setLibelleAffiche("Date fin");
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
        pr.setApres("fin/etatcaisse-liste.jsp");
        String daty1,daty2;
        daty1=request.getParameter("daty1");
        daty2=request.getParameter("daty2");
        if(daty1==null||daty1.compareToIgnoreCase("")==0)daty1=Utilitaire.dateDuJour();
        if(daty2==null||daty2.compareToIgnoreCase("")==0)daty2=Utilitaire.dateDuJour();
        String colonne=null,ordre=null;
        if(request.getParameter("colonne")!=null && request.getParameter("ordre")!=null){
            colonne=request.getParameter("colonne");
            ordre=request.getParameter("ordre");
        }
        EtatdeStockDate[] stock = EtatdeStockDate.calculEtatCaisse(daty2, request.getParameter("ingredients"),null, null,colonne,ordre,daty1);
        //pr.creerObjetPage();
        pr.creerObjetPage(libEntete, somDefaut);
        
        //pr.setBaseTableau(stock);
        String[] enteteAuto = {"ingredients","unite", "daty", "report", "entree", "sortie", "reste","reportSuiv"} ;
        //pr.getRs().setResultat(stock);
        //pr.getRs().
        pr.setTableau(new TableauRecherche(stock, enteteAuto));

%>
        <script>
            console.log(<%= pr.getTableau().getHtml() %>);
        </script>
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Etat de caisse</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getLien()%>?but=caisse/etatcaisse-liste.jsp" method="post" name="incident" id="incident">
                    <%
                        out.println(pr.getFormu().getHtmlEnsemble());
                    %>

                </form>
                <%  
                    String[] libEnteteAffiche = {"ingredients","unite", "daty", "report", "entree", "sortie", "reste","reportSuiv"} ;
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                    out.println(pr.getTableauRecap().getHtml());
                    out.println(pr.getTableau().getHtml());
                    out.println(pr.getBasPage());
                %>
            </section>
        </div>
<%  
    } catch(Exception ex) {
        ex.printStackTrace();
    }
%>
