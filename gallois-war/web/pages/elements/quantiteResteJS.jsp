<%-- 
    Document   : quantiteResteJS
    Created on : 3 mai 2019, 14:18:54
    Author     : ionyr
--%>
<script>
    function calculReste(total, qte, input){
        /*console.log('ato am calcul reste');
        console.log('parseInt(total)            '+parseInt(total));
        console.log("parseInt($('#'+qte).val())            "+parseInt($('#'+qte).val()));
        console.log("input            "+input);*/
        var tot = parseInt($('#'+qte).val());
        if(tot<0){
            tot = 0;
            $('#'+qte).val(tot);
        }
        var reste = parseInt(total) - tot;
        if(reste<0){ 
            alert("Il ne reste que "+total+" à livrer"); 
            console.log("apres alert");
            $('#'+qte).val(total);
            console.log("apres val");
        }
        else{
            $('#'+input).val(reste);
        }
    }
    $(document).ready(function(){
    });
</script>