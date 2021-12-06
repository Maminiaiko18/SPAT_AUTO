<%-- 
    Document   : accueil-capitainerie
    Created on : 26 févr. 2020, 09:14:32
    Author     : Maharo
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
        <title>CAPITAINERIE</title>
    </head>
    <body>
    <div class="content-wrapper">

 <div class="menupage" style="background-image: url('../assets/img/spat_fond.jpg');">
       
      <a class="btn btn-primary pull-left btnentete"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">Finance</a> 
      </br>
        </br>
                
        <div class="content-accueil">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                   <a href="<%=(String) session.getValue("lien") + "?but=accueil/facturation.jsp&colGroupe1=categorie_facture" %>"><button class=" menubtn btncolor">Facturation</button></a>
                </div>
            </div>
                        </br>

            <div class="row">
                <div class="col-md-4 col-md-offset-0">
                    <a href="<%=(String) session.getValue("lien") + "?but= accueil/budget.jsp&type=debit&colGroupe1=caisse" %>"><button class=" menubtn btncolor">Budget</button></a>
                </div>
                <div class="col-md-4 col-md-offset-4">
                  <a href="<%=(String) session.getValue("lien") + "?but=accueil/tresorerie.jsp" %>"><button class=" menubtn btncolor">Trésorerie</button></a>
                </div>
            </div> 
           
                </br>
                   </br>
            <div class="row">
                <div class="col-md-4">
                    <a href="<%=(String) session.getValue("lien") + "?but=accueil/etats-financiers.jsp" %>"><button class=" menubtn btncolor">Etat- Financiers</button></a>
                </div>
                <div class="col-md-4 col-md-offset-4">
                    <a href="<%=(String) session.getValue("lien") + "?but=accueil/engagement.jsp" %>"><button class=" menubtn btncolor">Engagement</button></a>
                </div>
            </div>
               
        </div>
    </div> 
</div>


  
</div>
</body>
</html>
