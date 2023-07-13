function add_line_tab(champ){
    var firstElement = document.getElementById("ajout_multiple_ligne").lastChild.innerHTML;
    var selected = document.getElementById("ajout_multiple_ligne").lastChild.getElementsByTagName("select");
    var indiceNew = $("#ajout_multiple_ligne tr").length;
    console.log("firstElement",firstElement)
    //var newElem = firstElement.toString().replaceAll(/(?<=[^0-9])0(?=[^0-9])/g, ''+indiceNew);
    var newElem = firstElement.replaceAll(/[0-9]/g, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew+""+indiceNew, indiceNew);
    console.log("newElen",newElem)
    $("#ajout_multiple_ligne").append("<tr id='ligne-multiple-"+indiceNew+"'>"+newElem+"</tr>");
    for(let select of selected){
        let name = select.getAttribute("id");
        console.log(name.replace(/\d+/g,indiceNew));
        document.getElementById(name.replace(/\d+/g,indiceNew)).innerHTML = select.innerHTML;
    }
    $("#nombreLigne").val(indiceNew+1);
}

function add_line_tabs(champ){
    var firstElement = document.getElementById("ajout_multiple_ligne").lastChild.innerHTML;
    for(let i=0;i<10;i++){
        var selected = document.getElementById("ajout_multiple_ligne").lastChild.getElementsByTagName("select");
    var indiceNew = $("#ajout_multiple_ligne tr").length;
    console.log("firstElement",firstElement)
    //var newElem = firstElement.toString().replaceAll(/(?<=[^0-9])0(?=[^0-9])/g, ''+indiceNew);
    var newElem = firstElement.replaceAll(/[0-9]/g, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew, indiceNew);
    newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew+""+indiceNew, indiceNew);
    console.log("newElen",newElem)
    $("#ajout_multiple_ligne").append("<tr id='ligne-multiple-"+indiceNew+"'>"+newElem+"</tr>");
        for(let select of selected){
            let name = select.getAttribute("id");
            console.log(name.replace(/\d+/g,indiceNew));
            document.getElementById(name.replace(/\d+/g,indiceNew)).innerHTML = select.innerHTML;
        }
    $("#nombreLigne").val(indiceNew+1);
    }
}


