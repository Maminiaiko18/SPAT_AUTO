<%@page import="mg.spat.MereCA"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    MereCA mereCA = new MereCA();
    mereCA.setNomTable("MERECALIB_CPL");
    String listeCrt[] = {"id", "val", "desce", "idgrandrubriquelib"};
    String libEntete[] = {"id", "val", "desce", "idgrandrubriquelib"};
    PageRecherche pr = new PageRecherche(mereCA, request, listeCrt, null, 3, libEntete, libEntete.length);
    pr.setTitre("Liste de MereCA");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ca/mereca-liste.jsp");
    pr.getFormu().getChamp("desce").setLibelle("Libell&eacute;");
    pr.getFormu().getChamp("val").setLibelle("Compte");
    pr.getFormu().getChamp("idgrandrubriquelib").setLibelle("Grand rubrique");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=ca/mereca-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles à afficher
    String libEnteteAffiche[] = {"Id", "Compte", "Libell&eacute;", "Grand rubrique"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



