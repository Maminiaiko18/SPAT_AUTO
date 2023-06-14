

function add_line_tab(champ){
    var firstElement = document.getElementById("ajout_multiple_ligne").lastChild.innerHTML;
    var indiceNew = $("#ajout_multiple_ligne tr").length;
    var indiceAvant = indiceNew-1;
    var selectElement = document.getElementById("unite_"+indiceAvant);
    var contenu = '<select name="unite_'+indiceNew +'" class="form-control" id="unite_'+indiceNew +'" >'+selectElement.innerHTML + '</select>';
    //var newElem = firstElement.toString().replaceAll(/(?<=[^0-9])0(?=[^0-9])/g, ''+indiceNew);
    var newElem = firstElement.replaceAll(/[0-9]/g, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew+""+indiceNew, indiceNew);
    console.log("newElen",newElem)
    $("#ajout_multiple_ligne").append("<tr id='ligne-multiple-"+indiceNew+"'>"+newElem+"</tr>");
    $("#nombreLigne").val(indiceNew+1);
    var parentElement = document.getElementById("unite_"+indiceNew).parentNode; 
    parentElement.innerHTML = contenu;

}



function add_line_tabs(champ){
    var firstElement = document.getElementById("ajout_multiple_ligne").lastChild.innerHTML;
    
    for(let i=0;i<10;i++){
        var indiceNew = $("#ajout_multiple_ligne tr").length;
        var indiceAvant = indiceNew-1
        var selectElement = document.getElementById("unite_"+indiceAvant);
        var contenu = '<select name="unite_'+indiceNew +'" class="form-control" id="unite_'+indiceNew +'" >'+selectElement.innerHTML+ '</select>';
        //var newElem = firstElement.replaceAll(/(?<=[^0-9])0(?=[^0-9])/g, (indiceNew+i));
        var newElem = firstElement.replaceAll(/[0-9]/g, indiceNew);
        newElem = newElem.replaceAll(indiceNew+""+indiceNew, indiceNew);
        newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew, indiceNew);
        newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew+""+indiceNew, indiceNew);
        $("#ajout_multiple_ligne").append("<tr id='ligne-multiple-"+(indiceNew)+"'>"+newElem+"</tr>");
        $("#nombreLigne").val(indiceNew+(1));
        var parentElement = document.getElementById("unite_"+indiceNew).parentNode;
        parentElement.innerHTML = contenu;

    }
}


