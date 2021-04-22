package utilitaire;

import bean.CGenUtil;
import bean.UnionIntraTable;
import java.sql.Connection;
import bean.UnionIntraTableUtil;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class UtilitaireMetier {

    public UtilitaireMetier() {
    }

    public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU, Connection c) throws Exception {
	return (mapperMereToFille(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, montant, refU, "0", c));
    }

    public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU, String etat, Connection c) throws Exception {
	try {
	    int tab[] = {2, 3};
	    String val[] = {idMere, idFille};
	    UnionIntraTable uit = new UnionIntraTable();
	    uit.setNomTable(nomtableMappage);
	    uit.setId1(idMere);
	    uit.setId2(idFille);
	    UnionIntraTable[] uu = (UnionIntraTable[]) CGenUtil.rechercher(uit, null, null, c, "");
	    if (uu.length > 0) {
		throw new Exception("Objet d�j� attribu�");
	    }
	    UnionIntraTable u = null;
	    u = new UnionIntraTable(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, utilitaire.Utilitaire.stringToDouble(montant), utilitaire.Utilitaire.stringToInt(etat));
	    u.insertToTableWithHisto(refU, c);
	    return u.getId();
	} catch (Exception ex) {
	    ex.printStackTrace();
	    c.rollback();
	    return null;
	}
    }

    public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU, String etat) throws Exception {
	Connection c = null;
	try {
	    c = new utilitaire.UtilDB().GetConn();
	    c.setAutoCommit(false);
	    String g = mapperMereToFille(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, montant, refU, etat, c);
	    c.commit();
	    return g;
	} catch (Exception ex) {
	    c.rollback();
	    return null;
	} finally {
	    if (c != null) {
		c.close();
	    }
	}
    }

    public static String mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU) throws Exception {
	return (mapperMereToFille(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, montant, refU, "0"));
    }

    public static void deleteMereToFille(String nomtable, String idMere, String idFille, String refU, Connection c) throws Exception {
	try {
	    UnionIntraTable uti = new UnionIntraTable();
	    uti.setNomTable(nomtable);
	    uti.setId1(idMere);
	    uti.setId2(idFille);
	    //System.out.println("========nomtable:"+uti.getNomTable()+" Id1:"+uti.getId1()+" Id2:"+uti.getId2());
	    UnionIntraTable[] ui = (UnionIntraTable[]) CGenUtil.rechercher(uti, null, null, c, "");
	    //System.out.println(" ========= length "+ui.length+ " ui nomtable:"+ui[0].getNomTable());
	    if (ui != null && ui.length > 0) {
		ui[0].setNomTable(nomtable);
		ui[0].deleteToTableWithHisto(refU, c);
	    }
	} catch (Exception ex) {
	    ex.printStackTrace();
	    throw new Exception(ex.getMessage());
	}
    }

    public static String mapperMereToFilleMetier(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU) throws Exception {
	return (mapperMereToFilleMetier(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, montant, refU, "0"));
    }

    public static String mapperMereToFilleMetier(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU, String etat) throws Exception {
	Connection c = null;
	try {
	    c = new utilitaire.UtilDB().GetConn();
	    c.setAutoCommit(false);
	    String g = mapperMereToFilleMetier(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, montant, refU, etat, c);
	    c.commit();
	    return g;
	} catch (Exception ex) {
	    c.rollback();
	    return null;
	} finally {
	    if (c != null) {
		c.close();
	    }
	}
    }

    public static String mapperMereToFilleMetier(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU, Connection c) throws Exception {
	return (mapperMereToFilleMetier(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, montant, refU, "0", c));
    }

    public static String mapperMereToFilleMetier(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU, String etat, Connection c) throws Exception {
	try {
	    int tab[] = {2, 3};
	    String val[] = {idMere, idFille};
	    UnionIntraTable uit = new UnionIntraTable();
	    uit.setNomTable(nomtableMappage);
	    uit.setId1(idMere);
	    uit.setId2(idFille);
	    UnionIntraTable[] uu = (UnionIntraTable[]) CGenUtil.rechercher(uit, null, null, c, "");
	    UnionIntraTable u = null;
	    u = new UnionIntraTable(nomtableMappage, nomFonctMap, suffixeMap, idMere, idFille, rem, utilitaire.Utilitaire.stringToDouble(montant), utilitaire.Utilitaire.stringToInt(etat));
	    if (uu.length > 0) {
		throw new Exception("Objet d�j� attribu�");
	    }
            u.insertToTableWithHisto(refU, c);
	    
	    return u.getId();
	} catch (Exception ex) {
	    ex.printStackTrace();
	    c.rollback();
	    throw ex;
	}
    }
}
