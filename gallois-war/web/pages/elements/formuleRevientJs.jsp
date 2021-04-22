<%-- 
    Document   : formuleRevientJs
    Created on : 15 avr. 2019, 09:41:53
    Author     : ionyr
--%>
<script>
    
    var champsEuro = ["totalHA_e", "carburant_e", "peage_e","aeic_e"];
    var champsAr = ["totalHA", "carburant", "peage","aeic"];
    
    function euroToAr(champEuro,champAr,cours){
//        console.log("cours        "+cours);
//        console.log("champ euro        "+$('#'+champEuro).val());
        $('#'+champAr).val(($('#'+champEuro).val() * cours).toFixed(2));
    }
    
    function setAr(){
        var taille = champsEuro.length;
        for(var compteur=0;compteur<taille;compteur++){
            euroToAr(champsEuro[compteur],champsAr[compteur],$('#cours').val());
        }
    }
    
    function toNombre(a){
        if(a==""){
            return 0;
        }
        else{
            return a;
        }
    }
    
    function calculDouane(poidsreel){
        $('#calculDouane').val((parseFloat(toNombre(poidsreel)) * 14000).toFixed(2));
    }
    function calculCoutRevientAr(totalHa,carburant,peage,aeic,degroupage,douane){
        $('#coutRevient').val((parseFloat(toNombre(totalHa)) + parseFloat(toNombre(carburant)) + parseFloat(toNombre(peage)) + parseFloat(toNombre(aeic)) + parseFloat(toNombre(degroupage)) + parseFloat(toNombre(douane))).toFixed(2));
    }
    function calculCoefRevientAr(courtRevient, totalHA){
        $('#coefRevient').val((parseFloat(toNombre(courtRevient)) / parseFloat(toNombre(totalHA))).toFixed(2));
    }
    $(document).ready(function(){
        setAr();
        $('#cours').on("change",function(){
            setAr();
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
        });
        $('#totalHA_e').on("change",function(){
            setAr();
            calculCoefRevientAr($('#coutRevient').val(), $('#totalHA').val());
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
        });
        $('#carburant_e').on("change",function(){
            setAr();
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
        });
        $('#peage_e').on("change",function(){
            setAr();
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
        });
        $('#aeic_e').on("change",function(){
            setAr();
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
        });
        $('#poidsReel').on("change",function(){
            calculDouane($('#poidsReel').val());
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
        });
        
        $('#degroupage').on("change",function(){
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
            calculCoefRevientAr($('#coutRevient').val(), $('#totalHA').val());
        });
        $('#douaneEffective').on("change",function(){
            calculCoutRevientAr($('#totalHA').val(),$('#carburant').val(),$('#peage').val(),$('#aeic').val(),$('#degroupage').val(),$('#douaneEffective').val());
            calculCoefRevientAr($('#coutRevient').val(), $('#totalHA').val());
        });
        $('#coutRevient').on("change",function(){
            calculCoefRevientAr($('#coutRevient').val(), $('#totalHA').val());
        });
        
    });
</script>