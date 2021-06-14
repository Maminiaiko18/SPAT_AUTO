<%
    String lien = (String) session.getValue("lien");
%>
<script>
    function debuter(){
        document.getElementById("acte").value="debut";
        document.getElementById("profil").submit();
    }
    function finir(){
        document.getElementById("acte").value="fin";
        document.getElementById("profil").submit();
    }
</script>
<div class="content-wrapper">
    <br/>
    <br/>
    <div class="col-md-6 col-md-offset-3" style="background-color: white;">
        <h1>Profil Commandant</h1>
        <form action="<%=lien%>?but=apresCommandant.jsp" method="post" id="profil">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <td>
                            <label for="idEscale" tabindex="3">Choix Escale</label> 
                        </td>
                        <td>
                            <input name="idEscalelibelle" type="textbox" class="form-control" id="idEscalelibelle" tabindex="4" readonly>
                            <input type="hidden" value="" name="idEscale" id="idEscale">
                        </td>
                        <td>
                            <input name="choix" type="button" class="submit" onclick="pagePopUp('choix/listeMouvementArriveeChoix.jsp?champReturn=idEscale;idEscalelibelle&amp;apresLienPageAppel=')" value="...">
                        </td>
                    </tr>
                </tbody>
            </table>

            <input name="debut" type="button" class="btn btn-info pull-left" id="debut" value="Début" onclick="debuter()">
            <input name="fin" type="button" class="btn btn-warning pull-right" id="fin" value="Fin" onclick="finir()">
            <input name="acte" type="hidden" id="acte">

            <br/>
            <br/>
        </form>
    </div>
</div>
