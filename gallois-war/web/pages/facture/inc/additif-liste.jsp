
<%@page import="bean.AdminGen"%>
<%@page import="avoir.AvoirLibComplet"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    AvoirLibComplet avoir = new AvoirLibComplet();
    avoir.setNomTable("ADDITIFLIB");
    String listeCrt[] = {"idfacture"};
    String listeInt[] = {};
    String libEntete[] = {"id", "designation","remarque", "typeavoir_desce","daty","montant","etat","tva"};
    PageRecherche pr = new PageRecherche(avoir, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facture/inc/additif-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
    <section class="content">
        <%
            String lienTableau[] = {pr.getLien() + "?but=additif"
                    + "/additif-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "facture","remarque", "type","daty","montant","etat","tva"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            AvoirLibComplet[] liste=(AvoirLibComplet[])pr.getTableau().getData();
            if(pr.getTableau().getHtml() != null){
                double total=0;
                total=AdminGen.calculSommeDouble(liste,"montant");
                out.println(pr.getTableau().getHtml());
                %>
        
        <table class="table table-striped table-bordered table-condensed table-responsive tree" >
            <tr>
                <td colspan="5"></td>
                <th width="16%" align="right">Montant total</th>
                <td width="16%" align="right"><%=total%></td>
            </tr>
        </table>
   <% }else{
        %><center><h4>Aucun additif</h4></center><%
    }
%>
    </section>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<a style="margin-right : 5px" class="btn btn-primary "  href="<%=(String) session.getValue("lien") + "?but=additif/additif-saisie.jsp&idfacture=" + request.getParameter("idfacture")%>">Additif</a>



