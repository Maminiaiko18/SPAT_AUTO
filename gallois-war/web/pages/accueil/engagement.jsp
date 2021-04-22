<%-- 
    Document   : engagement
    Created on : 14 avr. 2021, 11:24:08
    Author     : john
--%>

<style type="text/css">
  
    .row div a {
        width: 100%;
    }
    
    .row {
        margin-top: 50px;
    }
    
    .content-accueil {
        margin: auto;
        background: no-repeat;
        background-size: 80%;
        background-position: center;
        
        
    }
    
</style>

<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ENGAGEMENT</title>
    </head>
    <body>
    <div class="content-wrapper">

 <div class="menupage" style="background-image: url('../assets/img/spat_fond.jpg');">
       
      <a class="btn btn-primary pull-left btnentete"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">Engagement</a> 
      </br>
        </br>
                
        <div class="content-accueil">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                   <a href="<%=(String) session.getValue("lien") + "?but=stock/bc/bondecommande-analyse.jsp&colGroupe1=fournisseur" %>"><button class=" menubtn btncolor">Bon de commande</button></a>
                </div>
            </div>
                        </br>

            <div class="row">
                <div class="col-md-4 col-md-offset-0">
                    <a href="<%=(String) session.getValue("lien") + "?but=facture/analyse-facturefournisseur.jsp&colGroupe1=nomfournisseur" %>"><button class=" menubtn btncolor">Facture fournisseur</button></a>
                </div>
                <div class="col-md-4 col-md-offset-4">
                  <a href="<%=(String) session.getValue("lien") + "?but=ded/ordonnerpayement-analyse.jsp&colGroupe1=tiers" %>"><button class=" menubtn btncolor">OP</button></a>
                </div>
            </div>     
        </div>
    </div> 
</div>


  
</div>
</body>
</html>
