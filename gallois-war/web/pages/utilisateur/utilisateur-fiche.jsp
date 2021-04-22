
<%@page import="mg.cnaps.sig.SigPersonnes"%>
<%@page import="mg.cnaps.medecine.MedDemandeConsultation"%>
<%@page import="mg.cnaps.medecine.MedConsultation"%>
<%@page import="mg.cnaps.pointage.PointSanction"%>
<%@page import="mg.cnaps.formation.FormParticipantInfoComplet"%>
<%@page import="mg.cnaps.pret.PretDemande"%>
<%@page import="mg.cnaps.pret.PretEmprunt"%>
<%@page import="mg.cnaps.immo.ImmoCession"%>
<%@page import="java.sql.Connection"%>
<%@page import="mg.cnaps.immo.ImmoLibelleAttribue"%>
<%@page import="mg.cnaps.formation.FormParticipantInfoLog"%>
<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="mg.cnaps.formation.FormParticipantDemande"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.log.*" %>
<%@page import="mg.cnaps.paie.*"%>
<%!
    LogPersonnel personnel;
    Connection c = null;
    PaieInfoPersonnel[] infopersonnels;
    PaieDemandeavance[] demandeavances;
    PaiePersonnelElementpaie[] perseltpaiehistos;
    PaieAvancement[] avancements;
    FormParticipantInfoComplet[] participants;
    ImmoLibelleAttribue[] liste_immo;
    PageConsulte pc;
    ImmoCession[] listeCession;
    UserEJB u = null;
    String lien = null;
    String id = null;
    PretEmprunt[] emprunts;
    double totalperseltpaiehistosGain;
    double totalperseltpaiehistosRetenues;
    PretDemande[] demandeprets;
    double totaldemandeprets;
    double totalpret;
    FormFormation[] formations;
    FormFormation formation;
    PointSanction sanction;
    PointSanction[] sanctions;
    MedConsultation[] consultations;
    MedConsultation consultation;
    MedDemandeConsultation[] demandeconsultations;
    MedDemandeConsultation demandeconsultation;
%>
<%
    try {
        u = (UserEJB) session.getAttribute("u");
        lien = (String) session.getValue("lien");
        c = new UtilDB().GetConn();
        personnel = new LogPersonnel();
        personnel.setNomTable("LOG_PERSONNEL_INFOCOMPLET");
        String[] libellePersonnelFiche = {"Id", "Permis de Conduire", "Chemin Permis de conduire", "Remarque", "Id Personne", "Nom", "Prenom", "Date de naissance", "Sexe", "Numero CIN", "Date CIN", "Fokotany", "Acte de naissance", "Date Duplicata CIN", "Adresse", "Direction", "Service"};
        pc = new PageConsulte(personnel, request, (user.UserEJB) session.getValue("u"));
        pc.setLibAffichage(libellePersonnelFiche);
        pc.setTitre("Fiche Personnel");
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="tab-pane active" id="tab_8-2">
            <div class="row">
                <div class="col-md-6">
                    <div class="box-fiche">
                        <div class="box">
                            <div class="box-title with-border">
                                <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=utilisateur/utilisateur-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                            </div>
                            <div class="box-body">
                                <%
                                    out.println(pc.getHtml());
                                %>
                                <br/>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%out.println(pc.getBasPage());%>
        </div>
    </div><!-- /.tab-content -->
</div><!-- nav-tabs-custom -->
<%} catch (Exception e) {
        throw new Exception(e.getMessage());
    } finally {
        if (c != null) {
            c.close();
        }
    }%>
