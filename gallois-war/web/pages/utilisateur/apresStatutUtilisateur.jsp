<%@ page import="user.*" %>
<%@ page import="historique.*" %>
<%
    String lien = (String) session.getAttribute("lien");
    String refuser = request.getParameter("refuser");
    String acte = request.getParameter("acte");
    if (lien == null || lien.trim().isEmpty()) {
        lien = "globalnegoce.jsp";
    }
    String redirect = request.getContextPath() + "/pages/" + lien
            + "?but=parametre/utilisateur-fiche.jsp&refuser=" + (refuser == null ? "" : refuser);
    String msg = "Erreur lors du changement de statut.";
    try {
        if (!"POST".equalsIgnoreCase(request.getMethod())) {
            msg = "Methode non autorisee.";
        } else if (refuser == null || !refuser.matches("^[0-9]{1,10}$") || acte == null || (!"desactiver".equals(acte) && !"reactiver".equals(acte))) {
            msg = "Parametres invalides.";
        } else {
            UserEJB u = (UserEJB) session.getAttribute("u");
            if (u == null || u.getUser() == null) {
                msg = "Utilisateur non connecte.";
            } else {
                String idrole = u.getUser().getIdrole();
                if (!"admin".equals(idrole) && !"dg".equals(idrole)) {
                    msg = "Droit insuffisant.";
                } else {
                    String actorRef = String.valueOf(u.getUser().getRefuser());
                    String apiServiceRef = System.getenv("SPATERP_USER_API_REFUSER");
                    Object[] cancellations = new historique.AnnulationUtilisateurUtil().rechercher(2, refuser);
                    if (cancellations == null) {
                        msg = "Erreur lors du changement de statut.";
                    } else {
                        boolean disabled = cancellations.length > 0;
                        if ("desactiver".equals(acte)) {
                            if (refuser.equals(actorRef)) {
                                msg = "Impossible de desactiver son propre compte.";
                            } else if (apiServiceRef != null && refuser.equals(apiServiceRef)) {
                                msg = "Operation refusee.";
                            } else if (disabled) {
                                msg = "Compte deja desactive.";
                            } else {
                                u.desactiveUtilisateur(refuser);
                                msg = "Utilisateur desactive.";
                            }
                        } else {
                            if (!disabled) {
                                msg = "Compte deja actif.";
                            } else {
                                HistoriqueLocal historique = HistoriqueEJBClient.lookupHistoriqueEJBBeanLocal();
                                historique.activeUtilisateur(refuser, actorRef);
                                msg = "Utilisateur reactive.";
                            }
                        }
                    }
                }
            }
        }
    } catch (Exception e) {
        log("Erreur lors du changement de statut de l'utilisateur " + refuser, e);
        msg = "Erreur lors du changement de statut.";
    }
    session.setAttribute("statutUtilisateurMsg:" + (refuser == null ? "" : refuser), msg);
    response.sendRedirect(redirect);
%>
