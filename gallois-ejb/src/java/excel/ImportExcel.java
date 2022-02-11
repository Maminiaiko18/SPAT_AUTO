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
    public static ArrayList<Activite> importerTous(InputStream fileUrl, String idescale, int mois) throws Exception {
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
            
            Row rowtype = sheet.getRow(9);// ligne anle type
            Row rowcategorie = sheet.getRow(7);
            while (row != null) {
                //System.out.println(indice);
                    Cell clause = row.getCell(0);
                    if(clause.getCellType()!=0){
                        break;
                    }
                    //System.out.println(clause);
                int cellNumber = row.getPhysicalNumberOfCells();
                    String nomnavire = row.getCell(2).getStringCellValue();//col 3
                    String numerovoyage=row.getCell(3).getStringCellValue(); //col 4
                    
                    for (int co = 0; co < cellNumber; co++) {
                        //System.out.println(co);
                        Cell c = row.getCell(co);
                        
                        String idConteneur = act.genererRubrique(co);
                        if(idConteneur==null){
                            //System.out.println(co);
                        }else if(c.getNumericCellValue()==0){
                        
                        }else{
                             
                            Cell daty = row.getCell(4);
                            String date = utilitaire.Utilitaire.datetostring(daty.getDateCellValue());
                            

                            java.sql.Date datefin =utilitaire.Utilitaire.stringDate(date);
                            
                            double qte = c.getNumericCellValue();
                            
                            String type =rowtype.getCell(co).getStringCellValue()+" ";//"co" //ligne ery amn entete
                            int indicecat = genererCategorieMensuel(co);
                            String categorie=rowcategorie.getCell(indicecat).getStringCellValue();// mbola mila condition kely
                            String designation=numerovoyage + nomnavire+ type +categorie;
                            Activite temp = new Activite(datefin, Constante.idMICTSL, idConteneur, qte, mois, utilitaire.Utilitaire.stringToInt(annee), datefin,datefin, heuredeb, heurefin);
                            temp.setBateau(idescale);
                            temp.setDesignation(designation);
                            //System.out.println(designation);
                            ls.add(temp);
                                                        
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
    
    public static int genererCategorieMensuel(int indiceX){
    
        int val =0;
        if(indiceX>= 5 && indiceX<=8){
            val = 5;
        }
        if(indiceX>=10 && indiceX<=13){
            val = 10;
        }
        if(indiceX>=17 && indiceX<=20){
            val = 17;
        }
        if(indiceX>=22 && indiceX<=25){
            val=22;
        }                      
    return val;
    }
    
    public ArrayList<Activite> importJournalier(InputStream fileUrl, String idescale) throws Exception{
        workbook = WorkbookFactory.create((fileUrl));
            sheet = workbook.getSheetAt(0);
            int indice = 19; // miala entet
            Row row = sheet.getRow(indice);
            
            AdminActivite act = new AdminActivite();
            int[] colIlaina = {4,11,15,21}; 
            
            Row rowDate = sheet.getRow(12);
            Cell cellDate =  rowDate.getCell(8);
            String date = cellDate.getStringCellValue();
            System.out.println(date);
            String[] datesplit = date.split(" ");
            String dateString = datesplit[0];
            String heure = datesplit[1];
            System.out.println(heure);
            String[] splitdate = dateString.split("/");
            
            int mois =utilitaire.Utilitaire.stringToInt(splitdate[0]);//utilitaire.Utilitaire.getMois(daty);
            int annee =utilitaire.Utilitaire.stringToInt(splitdate[2]);// utilitaire.Utilitaire.getAnnee(daty);
            
            java.sql.Date daty = utilitaire.Utilitaire.stringDate(splitdate[1]+"/"+mois+"/"+annee);// satry mm/jj/aaaa ny format an daty anle excel
            
            String heuredeb = heure.replace(".", ":")+":00";
            String heurefin = heuredeb;
            
            ArrayList<Activite> ls = new ArrayList();
            String numerovoyage =sheet.getRow(10).getCell(8).getStringCellValue();//ligne 11 et colonne I = 9
            String nomnavire =sheet.getRow(8).getCell(8).getStringCellValue();//ligne 9 et colonne I = 9
            
            Row lignecategorie = sheet.getRow(18);
            while (row!=null) {
                
                    //System.out.println(indice);
                    row = sheet.getRow(indice);
                    
                   
                    Cell cellRubrique = row.getCell(1);
                    String rubrique = cellRubrique.getStringCellValue();
                    //System.out.println("****"+rubrique);
                    if(rubrique.length()==0 || rubrique.compareToIgnoreCase("TOTAL:")==0){
                        break;
                    }
                    System.out.println("ligne="+indice);
                    int compteCol = 0;
                    String type = rubrique;
                    while(compteCol < colIlaina.length){
                        System.out.println("col="+compteCol);
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
                                String categorie = lignecategorie.getCell(colIlaina[compteCol]).getStringCellValue();
                                String designation=numerovoyage+" " + nomnavire+" "+ type +" "+categorie;
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                temp.setDesignation(designation);
                                //System.out.print(designation);
                                ls.add(temp);
                            
                            }
                            if(rubrique.compareToIgnoreCase("20  Empty")==0){
                                ////System.out.println("20 E");
                                String idConteneur = act.Rubrique20Empty(colIlaina[compteCol]);
                                String categorie = lignecategorie.getCell(colIlaina[compteCol]).getStringCellValue();
                                String designation=numerovoyage+" " + nomnavire+" "+ type +" "+categorie;
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                temp.setDesignation(designation);
                                //System.out.print(designation);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("40  Full")==0){
                                //System.out.println("40 Full");
                                String idConteneur = act.Rubrique40Full(colIlaina[compteCol]);
                                 String categorie = lignecategorie.getCell(colIlaina[compteCol]).getStringCellValue();
                                String designation=numerovoyage+" " + nomnavire+" "+ type +" "+categorie;
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                temp.setDesignation(designation);
                                //System.out.print(designation);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("40  Empty")==0){
                                //System.out.println("40 E");
                                String idConteneur = act.Rubrique40Empty(colIlaina[compteCol]);
                                 String categorie = lignecategorie.getCell(colIlaina[compteCol]).getStringCellValue();
                                String designation=numerovoyage+" " + nomnavire+" "+ type +" "+categorie;
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                temp.setDesignation(designation);
                                //System.out.print(designation);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("45  Full")==0){
                                //System.out.println("45 Full");
                                String idConteneur = act.Rubrique45Full(colIlaina[compteCol]);
                                 String categorie = lignecategorie.getCell(colIlaina[compteCol]).getStringCellValue();
                                String designation=numerovoyage+" " + nomnavire+" "+ type +" "+categorie;
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                temp.setDesignation(designation);
                                //System.out.print(designation);
                                ls.add(temp);
                            }
                            if(rubrique.compareToIgnoreCase("45  Empty")==0){
                                //System.out.println("45 E");
                                String idConteneur = act.Rubrique45Empty(colIlaina[compteCol]);
                                 String categorie = lignecategorie.getCell(colIlaina[compteCol]).getStringCellValue();
                                String designation=numerovoyage+" " + nomnavire+" "+ type +" "+categorie;
                                Activite temp = new Activite(daty, Constante.idMICTSL, idConteneur, val, mois, annee, daty,daty, heuredeb, heurefin);
                                temp.setBateau(idescale);
                                temp.setDesignation(designation);
                                //System.out.print(designation);
                                ls.add(temp);
                            }
                        }
                        compteCol = compteCol+1;
                    }
                            
                indice = indice+1;
                row = sheet.getRow(indice);
            }
            
            return ls;
            
    }

}
