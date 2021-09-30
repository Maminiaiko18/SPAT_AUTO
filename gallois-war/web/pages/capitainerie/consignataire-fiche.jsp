<%-- 
    Document   : consignataire-fiche
    Created on : 14 janv. 2021, 14:08:06
    Author     : Sanda
--%>
<%@ page import="affichage.PageConsulte"%>
<%@ page import="mg.spat.Client"%>
<%@ page import="user.UserEJB"%>
<%
    String  parametre = request.getParameter("id"),
            nomtable = "CONSIGNATAIREMAT",
            titre = "fiche de consignataire",
            lien = (String) session.getValue("lien");    
    Client objet = new Client();
    objet.setNomTable(nomtable);
    PageConsulte pc = new PageConsulte(objet, request, (user.UserEJB) session.getValue("u"));
    
    pc.getChampByName("Cdcat").setVisible(false);
    pc.getChampByName("Faxclt").setVisible(false);
    pc.getChampByName("Nmcin").setVisible(false);
    pc.getChampByName("Rc").setVisible(false);
    
    pc.getChampByName("cdclt").setLibelle("ID");
    pc.getChampByName("nomclt").setLibelle("Nom");
    pc.getChampByName("adrclt").setLibelle("Adresse");
    pc.getChampByName("nmsttclt").setLibelle("Stat");
    pc.getChampByName("telclt").setLibelle("Contact");
        
    Client base = (Client) pc.getBase();

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><%=titre%></h1>
                    </div>
                    <div class="box-body">
                        <% out.println(pc.getHtml());%>
                        <br/>
                        <div class="pull-right">
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>