<%-- 
    Document   : journalcaisse-liste
    Created on : 6 nov. 2019, 15:02:52
    Author     : pro
--%>

<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="mg.spat.JournalCaisseMivadika"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="mg.amadia.stock.EtatdeStockDate"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String typecheque = request.getParameter("idtypecheque");
        JournalCaisseLibComplet journalCaisse = new JournalCaisseLibComplet();
        journalCaisse.setNomTable("JOURNALCAISSELIBCOMPLET");
        EtatdeStockDate etatcaisse[] = null;
        String date1 = utilitaire.Utilitaire.dateDuJour();
        String date2 = utilitaire.Utilitaire.dateDuJour();
        if(request.getParameter("dateEffet1")!=null) date1 = request.getParameter("dateEffet1");
        if(request.getParameter("dateEffet2")!=null) date2 = request.getParameter("dateEffet2");
        if(request.getParameter("caisse")!=null){
            String caisse = request.getParameter("caisse");
            etatcaisse = journalCaisse.etatdecaisse(date1,date2,caisse,null);
        }

        if (request.getParameter("etatvue") != null) {
            journalCaisse.setNomTable(request.getParameter("etatvue"));
        }

        String listeCrt[] = {"id", "folio", "caisse", "numPiece", "libelle", "remarque", "dateEffet","numcheque", "idtypecheque", "descecaisse", "tierslib","credit","debit"};
        String listeInt[] = {"dateEffet","credit","debit"};
        String libEntete[] = {"id", "folio", "valcaisse", "descetypecheque", "numPiece", "numcheque", "libelle", "dateSaisie", "dateEffet", "credit", "debit","remarque", "tierslib","etatlib"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/journalcaisse-liste.jsp");

        Liste[] listes = new Liste[3];
        listes[0] = new Liste("descecaisse", new String[]{"Tous", "Caisse", "Banque"}, new String[]{"", "Caisse", "Banque"});

        TypeObjet typeCheque = new TypeObjet();
        typeCheque.setNomTable("typecheque");
        listes[1] = new Liste("idtypecheque", typeCheque, "val", "id");

        Caisse caisse = new Caisse();
        caisse.setNomTable("CAISSE_REEL");
        listes[2] = new Liste("caisse", caisse, "val", "id");

        pr.getFormu().changerEnChamp(listes);
        pr.getFormu().getChamp("numcheque").setLibelle("num cheque");
        pr.getFormu().getChamp("credit1").setLibelle("entree min");
        pr.getFormu().getChamp("credit2").setLibelle("entree max");
        pr.getFormu().getChamp("debit1").setLibelle("sortie min");
        pr.getFormu().getChamp("debit2").setLibelle("sortie max");
        pr.getFormu().getChamp("descecaisse").setLibelle("Bureau");
        pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");
        pr.getFormu().getChamp("libelle").setLibelle("Libellé");
        pr.getFormu().getChamp("idtypecheque").setLibelle("Type");
        pr.getFormu().getChamp("remarque").setLibelle("Num&eacute;ro OP");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("numPiece").setLibelle("Num Piece");
        String[] colSomme = {"credit", "debit"};
        pr.creerObjetPage(libEntete, colSomme);
        if(date1.equalsIgnoreCase(date2)) date1 = Utilitaire.ajoutJourDateString(Utilitaire.stringDate(date2), -1);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Journal de caisse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/journalcaisse-liste.jsp&recap=checked" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="JOURNALCAISSELIBCOMPLET" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIBmiv") == 0) {
                                out.print("selected");
                            }%>>Tous</option>
                        <option value="JOURNALCAISSELIBCOMPLET_CREE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_CREE_miv") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;e</option>
                        <option value="JOURNALCAISSELIBCOMPLET_VISE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_vise_miv") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;</option>
                        <option value="journalcaisselibrecette" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("journalcaisselibrecette") == 0) {
                                out.print("selected");
                            }%>>Recettes</option>
                        <option value="journalcaisselibdepense" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("journalcaisselibdepense") == 0) {
                                out.print("selected");
                            }%>>D&eacute;penses</option>
                        <option value="JOURNALCAISSELIB_PROVISION" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_PROVISION") == 0) {
                                out.print("selected");
                            }%>>Provisions</option>
                        <option value="JOURNALCAISSELIB_SANSPROV" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("JOURNALCAISSELIB_SANSPROV") == 0) {
                                out.print("selected");
                            }%>>Recettes sans provisions</option>


                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
            
        <%  
            String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>

        <div style="background:#ffb401; color:white;" class="box-header">
                <h3 class="box-title" align="center">Solde</h3>
            </div>
            <div class="box-body table-responsive no-padding">
                <div id="selectnonee">
                    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                        <thead>
                            <tr class="head">
                                <th width="25%" align="center" valign="top" style="background-color:#ffffff">Solde initial du <%= " "+date1 %></th>
                                <th width="25%" align="center" valign="top" style="background-color:#ffffff">Solde final du<%= " "+date2 %></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor='white'" style="background-color:white">
                                <td width="25%" align="left">
                                    <%= etatcaisse != null && etatcaisse[0] != null ? Utilitaire.formaterAr(etatcaisse[0].getReste()) : 0 %>
                                </td>
                                <td width="25%" align="left"> 
                                    <%= etatcaisse != null && etatcaisse[1] != null ? Utilitaire.formaterAr(etatcaisse[1].getReste()) : 0 %>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="journal-caisse-liste">
            <input type="hidden" name="bute" value="treso/journalcaisse-liste.jsp"/>
            <input type="hidden" name="classe" value="mg.spat.JournalCaisse"/>
            <input type="hidden" name="acte" value="viser"/>
            <%
                String libEnteteAffiche[] = {"Id", "Folio", "Caisse", "Type", "Num Piece", "num cheque", "Libell�", "Date Saisie", "Date Effet", "Entr�e", "Sortie", "Num&eacute;ro OP", "Tiers","Etat"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                pr.getTableau().setNameBoutton("Viser");

                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
            <%
                if (typecheque != null && typecheque.compareToIgnoreCase("%") == 0) {
                    typecheque = "";
                }
            %>
            <%-- <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=listeJournalCaisse&id=<%=request.getParameter("id")%>&folio=<%=request.getParameter("folio")%>&caisse=<%=request.getParameter("caisse")%>&libelle=<%=request.getParameter("libelle")%>&remarque=<%=request.getParameter("remarque")%>&dateEffet1=<%=request.getParameter("dateEffet1")%>&dateEffet2=<%=request.getParameter("dateEffet2")%>&idtypecheque=<%= typecheque%>&descecaisse=<%=request.getParameter("descecaisse")%>&idplacement=<%= request.getParameter("idplacement")%>&etat=<%= request.getParameter("etatvue")%>" style="margin-right: 10px">Imprimer</a> --%>
        </form>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<script>
    const form = document.getElementById('journal-caisse-liste');
    const footer = form.getElementsByClassName('box-footer')[0];
    const button = footer.getElementsByTagName('button')[0].cloneNode();
    button.innerHTML = 'Transferer';
    button.onclick = function (e) {
//        e.preventDefault();
        form.action = '<%=pr.getLien()%>?but=apresFacture.jsp';
        form.querySelector('[name="acte"]').value = 'transfert';
        form.querySelector('[name="bute"]').value = ' treso/transfert-caisse.jsp';
    }
    footer.append(button);
</script>
<% } catch (Exception e) {
        e.printStackTrace();

    }%>
