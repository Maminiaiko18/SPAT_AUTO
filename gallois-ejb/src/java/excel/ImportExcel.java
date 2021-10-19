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
    public static ArrayList<Activite> importerTous(InputStream fileUrl) throws Exception {
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

}
