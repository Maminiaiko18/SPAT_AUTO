<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil" %>
<%@page import="bean.TypeObjet" %>
<%
    String lang = String.valueOf(session.getAttribute("lang"));
    String[] mots = {"Generer etats", "Exercice", "Type de compte", "Type etat", "Mois debut", "Mois fin", "Du compte", "Au compte", "Afficher"};
    String[] ret = Utilitaire.transformerLangue(mots, lang);

%>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%=ret[0]%></h1>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="box-body">
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="Exercice"><%=ret[1]%></label>
                        <input type="text" id="exercice" name="exercice" class="form-control" value="<%= Utilitaire.getAnneeEnCours()%>">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="Type de compte"><%=ret[2]%></label>
                        <select name="typecompte" id="typecompte" class="form-control">
                            <option value="1">G&eacute;n&eacute;ral</option>
                            <option value="3">Analytique</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="Type etat"><%=ret[3]%></label>
                        <select name="typeetat" id="typeetat" class="form-control">
                            <option value="1">Balance</option>
                            <option value="2">Grand Livre</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="Etat">Etat</label>
                        <select name="etat" id="etat" class="form-control">
                            <option value="1">Tous</option>
                            <option value="2">Visée</option>
                            <option value="3">Non Visée</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="Mois début"><%=ret[4]%></label>
                            <select name="mois1" id="mois1" class="form-control">
                                <option value="1">Janvier</option>
                                <option value="2">Fevrier</option>
                                <option value="3">Mars</option>
                                <option value="4">Avril</option>
                                <option value="5">Mai</option>
                                <option value="6">Juin</option>
                                <option value="7">Juillet</option>
                                <option value="8">Aout</option>
                                <option value="9">Septembre</option>
                                <option value="10">Octobre</option>
                                <option value="11">Novembre</option>
                                <option value="12">Decembre</option>
                            </select>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="Mois fin"><%=ret[5]%></label>
                            <select name="mois2" id="mois2" class="form-control">
                                <option value="1">Janvier</option>
                                <option value="2">Fevrier</option>
                                <option value="3">Mars</option>
                                <option value="4">Avril</option>
                                <option value="5">Mai</option>
                                <option value="6">Juin</option>
                                <option value="7">Juillet</option>
                                <option value="8">Aout</option>
                                <option value="9">Septembre</option>
                                <option value="10">Octobre</option>
                                <option value="11">Novembre</option>
                                <option value="12">Decembre</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="plage1"><%=ret[6]%></label>
                            <input id="plage1" name="plage1" onkeypress="findLibelleCompte('plage1')" onfocusout="focusOut('plage1')" class="form-control" type="text" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="plage2"><%=ret[7]%></label>
                            <input id="plage2" name="plage2" onkeypress="findLibelleCompte('plage2')" onfocusout="focusOut('plage2')" class="form-control" type="text" />
                        </div>

                    </div>
                </div>
            </div>
            <div class="box-footer">
                <a class="btn btn-primary pull-right" type="submit" onclick="ecranBalanceCompteGeneral()"><%=ret[8]%></a>
            </div>
        </div>
    </section>
</div>

<script>

    function ecranBalanceCompteGeneral() {
        var date1, date2, plage1, plage2, exercice, typecompte, url, typeetat;
        date1 = $('#mois1').val();
        date2 = $('#mois2').val();
        plage1 = $('#plage1').val();
        plage2 = $('#plage2').val();
        exercice = $('#exercice').val();
        typecompte = $('#typecompte').val();
        typeetat = $('#typeetat').val();
        etat = $('#etat').val();
        if (date1 != '' && date2 != '') {
            if (typeetat == '1') {
//                url = 'compta/etat/balanceCompteGeneral-etat_2.jsp?date1='+date1+'&date2='+date2+'&plage1='+plage1+'&plage2='+plage2+'&exercice='+exercice+'&typecompte='+typecompte;
                url = 'compta/balanceCompteGeneral-etat_2_1.jsp?date1=' + date1 + '&date2=' + date2 + '&plage1=' + plage1 + '&plage2=' + plage2 + '&exercice=' + exercice + '&typecompte=' + typecompte + '&etat=' + etat;
                window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
            }
            if (typeetat == '2') {
                if (plage1 != '' && plage2 != '') {
                    url = 'compta/grandLivreCompte-etatMultiple_1.jsp?date1=' + date1 + '&date2=' + date2 + '&plage1=' + plage1 + '&plage2=' + plage2 + '&exercice=' + exercice + '&typecompte=' + typecompte + '&etat=' + etat;
                    window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
                } else {
                    alert('Champ compte manquant.');
                }
            }
        } else {
            alert('Champ date manquant.');
        }
    }

    function focusOut(idinput) {
        var value = $("#" + idinput).val();
        if (value.trim() == "") {
            return;
        } else {
            var temp = value.split(":");
            $("#" + idinput).val(temp[0].trim());
        }
    }

    function findLibelleCompte(idinput) {
        $(document).on('keydown', '#' + idinput, function (e) {
            var keyCode = e.keyCode || e.which;

            if (keyCode == 9 || keyCode == 13) {
                var prest = $('#' + idinput).val();
                if (prest != null && prest.trim() != "") {
                    var temp = prest.split(":");
                    //                $('#code' + itemp).val(temp[0].trim());
//                    document.getElementById("libelleCompte").value = temp[1].trim();
                    $('#' + idinput).val(temp[0].trim());
                }

            } else {
                var compte = "";
                var data = <%= session.getAttribute("comptaComptes")%>;
                $('#' + idinput).autocomplete({
                    source: function (request, response) {
                        var matches = $.map(data, function (acItem) {
                            if (acItem.toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                                return acItem;
                            }
                        });
                        response(matches);
                    },
                    minLength: 0,
                    select: function (e, ui) {
                        var selectedObj = ui.item;
                        var prest = selectedObj.value;
                        var temp = prest.split(":");
                        //$("#"+idinput+i).val(temp[1].trim());
                        // document.getElementById("libelleCompte").value = temp[1].trim();
                        compte = temp[0].trim();
                        $("#" + idinput).val(compte);

                    }
                });
            }
        });
    }
</script>