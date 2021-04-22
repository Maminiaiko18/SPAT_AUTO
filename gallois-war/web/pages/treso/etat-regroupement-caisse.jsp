<%-- 
    Document   : etat-regroupement-caisse
    Created on : 7 nov. 2019, 09:05:54
    Author     : HP
--%>

<%@page import="java.util.Set"%>
<%@page import="java.sql.Date"%>
<%@page import="datas.JournalDatas"%>
<%@page import="java.util.HashMap"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.Utilitaire"%>

<%
    try{
    Date d =Utilitaire.stringDate(request.getParameter("date"));
    String caisse=request.getParameter("caisse");
    System.out.println("caisse============="+caisse);
    if(d==null)
        throw new Exception("Date requis pour la sortie du journal.");
        
    JournalCaisse j = new JournalCaisse();
    j.setNomTable("JOURNALCAISSELIBCOMPLET");
    
    
    HashMap<String,double[]> autres = new JournalDatas(d,caisse).getAutres();
    
    
    String listeCrt[] = {"id", "caisse", "dateEffet"};
    String listeInt[] = {"dateEffet"};
    String libEntete[] = {"id","folio","caisse","numPiece","libelle","remarque","dateSaisie","dateEffet","debit","credit","idcaisse"};
        
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setAWhere(" and dateeffet='"+request.getParameter("date")+"'");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    
    JournalCaisse[] journal = (JournalCaisse[]) pr.getTableau().getData();
    

%>

<div class="content-wrapper" id="content" >
    <div class="row">
        <div class="col-md-12">
            <div class="box-body">
                <div class="box">
                    <center>
                        <h3 class="box-title" id="titre-export" align="center">
                            <b>SOCIETE DU PORT A GESTION AUTONOME DE TOAMASINA</b>
                        </h3>
                    </center>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="row">
            <div class="col-md-8">
                <center>
                    <h4 class="box-title" id="titre-export" align="center">
                        <b>JOURNAL DE CAISSE</b>
                    </h4>
                </center>
            </div>
            <div class="col-md-4">
                <div class="row">FOLIO N° <%if(journal.length>0)out.print(journal[0].getFolio());%></div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8">
                <center>
                    <h4 class="box-title" id="titre-export" align="center">
                        <b>CAISSE DEPENSE</b>
                    </h4>
                </center>
            </div>
            <div class="col-md-4">
                <div class="row">JOURNEE DU <%=request.getParameter("date")%></div>
            </div>
        </div>
    </div>
    <div class="row">
         <div class="col-md-12">
            <div class="box-body">
                <div class="box">
                    <div id="table-container">
                        <table border="1" width="100%" style="border-collapse: collapse;">
                            <tr>
                                <th colspan=1 width="10%" style="text-align: center;" align="center">NUM PIECE</th>
                                <th colspan=1 width="40%" style="text-align: center;" align="center">LIBELLE</th>
                                <th colspan=1 width="25%" style="text-align: center;" align="center">DEBIT</th>
                                <th colspan=1 width="25%" style="text-align: center;" align="center">CREDIT</th>
                            </tr>
                            <% double sommeDebit = 0;
                               double sommeCredit = 0;
                                for(int i=0;i<journal.length;i++){ 
                                    sommeDebit+=journal[i].getDebit();
                                    sommeCredit+=journal[i].getCredit();
                            %>
                            <tr style="border-bottom: 0px solid #ccc;">
                                <td colspan=1 align="center"><%=journal[i].getNumPiece() %></td>
                                <td colspan=1 > <%=journal[i].getLibelle()%></td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterArOrNull(journal[i].getDebit()) %> </td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterArOrNull(journal[i].getCredit()) %> </td>
                            </tr>
                            <% } %>
                            <tr style="border-top: 1px solid  ;" >
                                <td colspan=1></td>
                                <td colspan=1 align="center"><b> Total </b></td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterAr(sommeDebit) %> </td>
                                <td colspan=1 align="right"><%=Utilitaire.formaterAr(sommeCredit) %> </td>
                            </tr>
                            <%  Object[] keys = (Object[]) autres.keySet().toArray();
                                for(int s=0;s<keys.length;s++){ 
                                    sommeDebit+=autres.get(keys[s])[0];
                                    sommeCredit+=autres.get(keys[s])[1];
                            %>
                                <tr style="border-bottom: 0px solid #ccc">
                                    <td style="border-bottom: 0px solid #fff"></td>
                                    <td colspan=1 style="border-top: 0px solid #000 ;"> <%=s+1%> - <%=keys[s]%> </td>
                                    <td colspan=1 align="right"> <%=Utilitaire.formaterArOrNull(autres.get(keys[s])[0] ) %></td>
                                    <td colspan=1 align="right" > <%=Utilitaire.formaterArOrNull(autres.get(keys[s])[1]) %></td>
                                </tr>
                            <% } %>

                            <tr style="border-bottom: 1px solid  ;">
                                <td colspan=1></td>
                                <td colspan=1 align="center"> <b>Somme </b></td>
                                <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(sommeDebit) %> </b></td>
                                <td colspan=1 align="right"><b><%=Utilitaire.formaterAr(sommeCredit) %> </b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
         </div>
    </div>
</div>
<%
    }catch(Exception e){
        e.printStackTrace();
    }
%>