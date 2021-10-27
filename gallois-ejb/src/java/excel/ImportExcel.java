/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package excel;

import bean.CGenUtil;
import bean.Champ;
import bean.ClassMAPTable;
import bean.ListeColonneTable;
import java.io.File;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.util.List;
import java.util.ArrayList;
import mg.spat.exploitant.Activite;
import mg.spat.exploitant.AdminActivite;
import utilitaire.Utilitaire;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Cell;
import utilitaire.Constante;


public class ImportExcel {
    
    private static Workbook workbook;
    private static Sheet sheet;
    public static ArrayList<Activite> importerTous(InputStream fileUrl, String idescale) throws Exception {
        try {
            String heuredeb = "00:00:00";
            String heurefin = "00:00:00";
            
            workbook = WorkbookFactory.create((fileUrl));
            sheet = workbook.getSheetAt(0);
            int indice = 10; // miala ny indice 0 satria titre
            Row row = sheet.getRow(indice);
            AdminActivite act = new AdminActivite();
            ArrayList<Activite> ls = new ArrayList();
            
            Row rowAnnee = sheet.getRow(5);
            Cell years2 = rowAnnee.getCell(0);
            String entete = years2.getStringCellValue();
            String[] entetesplit = entete.split(" ");
            int place =  entetesplit.length-1;
            String annee = entetesplit[place];
            while (row != null) {
                //System.out.println(indice);
                    Cell clause = row.getCell(0);
                    if(clause.getCellType()!=0){
                        break;
                    }
                    //System.out.println(clause);
                int cellNumber = row.getPhysicalNumberOfCells();
                    for (int co = 0; co < cellNumber; co++) {
                        System.out.println(co);
                        Cell c = row.getCell(co);
                        String idConteneur = act.genererRubrique(co);
                        if(idConteneur==null){
                            //System.out.println(co);
                        }else if(c.getNumericCellValue()==0){
                        
                        }else{
                            //System.out.println(idConteneur);  
                            Cell daty = row.getCell(4);
                            String date = utilitaire.Utilitaire.datetostring(daty.getDateCellValue());
                            String[] datesplit= date.split("/");

                            java.sql.Date datefin =utilitaire.Utilitaire.stringDate(date);
                            int mois =utilitaire.Utilitaire.stringToInt(datesplit[1]);
                            double qte = c.getNumericCellValue();
                            Activite temp = new Activite(datefin, Constante.idMICTSL, idConteneur, qte, mois, utilitaire.Utilitaire.stringToInt(annee), datefin,datefin, heuredeb, heurefin);
                            temp.setBateau(idescale);
                            ls.add(temp);
                            
                            //System.out.println(temp.getRubrique()+"*****"+temp.getQte());
                        }
                       
                    }
                    indice++;
                    row = sheet.getRow(indice);
               
            }
            
            
            //System.out.println("isany*****="+ls.size());
            return ls;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Erreur lors de l'import du fichier Excel");
        }
        
    }
    
    public ArrayList<Activite> importJournalier(InputStream fileUrl, String idescale) throws Exception{
        workbook = WorkbookFactory.create((fileUrl));
            sheet = workbook.getSheetAt(0);
            int indice = 19; // miala entet
            Row row = sheet.getRow(indice);
            
            AdminActivite act = new AdminActivite();
            int[] colIlaina = {4,11,15,21}; 
            
            Row rowDate = sheet.getRow(1);
            Cell cellDate =  rowDate.getCell(34);
            String date = cellDate.getStringCellValue();
            System.out.println(date);
            String[] datesplit = date.split(" ");
            String dateString = datesplit[0];
            String heure = datesplit[1];
            System.out.println(heure);
            String[] splitdate = dateString.split("/");
            
            
            
            java.sql.Date daty = utilitaire.Utilitaire.stringDate(dateString);
            int mois =utilitaire.Utilitaire.stringToInt(splitdate[1]);//utilitaire.Utilitaire.getMois(daty);
            int annee =utilitaire.Utilitaire.stringToInt(splitdate[2]);// utilitaire.Utilitaire.getAnnee(daty);
            String heuredeb = heure.replace(".", ":")+":00";
            String heurefin = heuredeb;
            
            ArrayList<Activite> ls = new ArrayList();
            //System.out.println("etoooooooo");
            
            while (1<2) {
                
                    //System.out.println(indice);
                    row = sheet.getRow(indice);
                    
                   
                    Cell cellRubrique = row.getCell(1);
                    String rubrique = cellRubrique.getStringCellValue();
                    //System.out.println("****"+rubrique);
                    if(rubrique.length()==0 || rubrique.compareToIgnoreCase("TOTAL:")==0){
                        break;
                    }
                    
                    int compteCol = 0;
                    while(compteCol < colIlaina.length){
                        
                        Cell cellValeur = row.getCell(colIlaina[compteCol]);
                        ////System.out.println("col"+colIlaina[compteCol]);
                        
                        Double val =0.0;
                        if(cellValeur.getCellType()==1){
                            val = utilitaire.Utilitaire.stringToDouble(cellValeur.getStringCellValue());
                            //System.out.println(cellValeur.getStringCellValue());
                        }else{
                            val = cellValeur.getNumericCellValue();
                            //System.out.println(cellValeur.getNumericCellValue());
                        }
                        
                        
                        
                        
                        if(val!=0){
                            if(rubrique.compareToIgnoreCase("20  Full")==0){
                                //System.out.println("20 Full");
                                String idConteneur = act.Rubrique20Full(colIlaina[compteCol]);
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                ls.add(temp);
                            
                            }
                            if(rubrique.compareToIgnoreCase("20  Empty")==0){
                                ////System.out.println("20 E");
                                String idConteneur = act.Rubrique20Empty(colIlaina[compteCol]);
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("40  Full")==0){
                                //System.out.println("40 Full");
                                String idConteneur = act.Rubrique40Full(colIlaina[compteCol]);
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("40  Empty")==0){
                                //System.out.println("40 E");
                                String idConteneur = act.Rubrique40Empty(colIlaina[compteCol]);
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("45  Full")==0){
                                //System.out.println("45 Full");
                                String idConteneur = act.Rubrique45Full(colIlaina[compteCol]);
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("45  Empty")==0){
                                //System.out.println("45 E");
                                String idConteneur = act.Rubrique45Empty(colIlaina[compteCol]);
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                ls.add(temp);
                            }
                        }
                        compteCol = compteCol+1;
                    }
                            
                indice = indice+1;
            }
            
            return ls;
            
    }

}
