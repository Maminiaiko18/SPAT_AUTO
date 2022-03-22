

function add_line_tab(champ){
    var firstElement = $("#ajout_multiple_ligne tr")[0].innerHTML;
    var indiceNew = $("#ajout_multiple_ligne tr").length;
    var newElem = firstElement.replaceAll(/(?<=[^0-9])0(?=[^0-9])/g, indiceNew);
    $("#ajout_multiple_ligne").append("<tr id='ligne-multiple-"+indiceNew+"'>"+newElem+"</tr>");
    $("#nombreLigne").val(indiceNew+1);
}


