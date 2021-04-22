<%@page import="service.SpatService"%>
<%
    SpatService.testerBonProvisoire(request.getParameter("id"), null);
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-2">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/bon-provisoire-montant.jsp&idcaisse=<%=request.getParameter("idcaisse")%>"><i class="fa fa-arrow-circle-left"></i></a>Montant</h1>
                    </div>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="montantlib">Montant</label>
                                <input type="number" class="form-control" id="montantlib" aria-describedby="montantlib" name="credit">
                            </div>
                            <input name="caisse" type="hidden" id="caisse" value="<%=request.getParameter("idcaisse")%>">
                            <input name="acte" type="hidden" id="acte" value="insert">
                            <input name="folio" type="hidden" id="folio" value="<%=request.getParameter("id")%>">
                            <input name="bute" type="hidden" id="bute" value="treso/journalcaisse-fiche.jsp">
                            <input name="classe" type="hidden" id="classe" value="mg.spat.JournalCaisse">
                            <input name="nomtable" type="hidden" id="nomtable" value="journalcaisse">
                            <br/>
                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">Valider</button>           
                            </div>
                            <br/>

                        </div>
                    </form>
                </div>
            </div>
        </div>
                        
    </div>        
</div>