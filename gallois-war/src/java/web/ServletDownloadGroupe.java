package web;

import affichage.TableauRecherche;
import bean.CGenUtil;
import bean.ClassMAPTable;
import com.itextpdf.text.Document;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.StringReader;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

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
@WebServlet(name = "ServletDownloadGroupe", urlPatterns = {"/downloadGroupe"})
public class ServletDownloadGroupe extends HttpServlet {

    protected void doPost(HttpServletRequest arg0, HttpServletResponse arg1)
            throws ServletException, IOException {
        OutputStream os = arg1.getOutputStream();
        try {
            String ext = arg0.getParameter("ext");
            //String donn=arg0.getParameter("donnee");
            String awhere = arg0.getParameter("awhere");
            if (awhere == null) {
                awhere = "";
            }
            arg1.setContentType("text/plain");
            SimpleDateFormat fd = new SimpleDateFormat("yyyy-MM-dd");
            String d = fd.format(new Date());
            String fileName = "export-" + d + "." + ext;
            arg1.setHeader("Content-Disposition", "attachment;filename=export-" + d + "." + ext);

            String type = arg0.getParameter("donnee");

            if (type.compareTo("0") == 0) {
                if (ext.compareTo("xls") == 0) {
                    arg1.setContentType("application/vnd.ms-excel");
                    os.write(arg0.getParameter("table").replace('*', '"').getBytes());
                }
                if (ext.compareTo("pdf") == 0) {

                    arg1.setContentType("application/pdf");
                    File fichier = new File(getServletContext().getRealPath("") + fileName);

                    String htmlStringEntete = UtilitaireFormat.generateEntete(arg0.getParameter("titre"), "");
                    htmlStringEntete += arg0.getParameter("table").replace('*', '"') + "</body></html>";

                    String fileNameWithPath = getServletContext().getRealPath("") + fileName;
                    OutputStream file = new FileOutputStream(new File(fileNameWithPath));
                    Document document = new Document();
                    try {
                        PdfWriter.getInstance(document, file);
                        document.open();
                        HTMLWorker htmlWorker = new HTMLWorker(document);
                        htmlWorker.parse(new StringReader(htmlStringEntete));
                        document.close();
                        file.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    System.out.println("PDF Created!");

                    // This should send the file to browser
                    OutputStream out = arg1.getOutputStream();
                    FileInputStream in = new FileInputStream(fileNameWithPath);

                    byte[] buffer = new byte[4096];
                    int length;
                    while ((length = in.read(buffer)) > 0) {
                        out.write(buffer, 0, length);
                    }
                    in.close();
                    out.flush();
                    fichier.delete();
                } else {
                    String donnee = arg0.getParameter(ext);
                    os.write((donnee).replace('*', '"').getBytes());
                    os.flush();
                }

            } else if (type.compareTo("1") == 0) {
                String[] entete = Utilitaire.split(arg0.getParameter("entete"), ";");
                String[] entetelibelle = Utilitaire.split(arg0.getParameter("entetelibelle"), ";");

                String colDefaut = arg0.getParameter("colDefaut");
                String[] lcD = null;
                String somDefaut = arg0.getParameter("somDefaut");
                String[] lsD = null;
                String colInt = arg0.getParameter("colInt");
                String[] lcI = null;
                String valInt = arg0.getParameter("valInt");
                String[] lvI = null;
                String ordre = arg0.getParameter("ordre");
                if (somDefaut.compareTo("") != 0 || somDefaut != null) {
                    lsD = Utilitaire.split(somDefaut, ",");
                }
                if (colDefaut.compareTo("") != 0 || colDefaut != null) {
                    lcD = Utilitaire.split(colDefaut, ",");
                }
                if (colInt.compareTo("") != 0 || colInt != null) {
                    lcI = Utilitaire.split(colInt, ",");
                }
                if (valInt.compareTo("") != 0 || valInt != null) {
                    lvI = Utilitaire.split(valInt, ",");
                }
                ClassMAPTable o = (ClassMAPTable) arg0.getSession().getAttribute("critere");

                Connection con = (new UtilDB()).GetConn();
                bean.ResultatEtSomme cx = (bean.ResultatEtSomme) CGenUtil.rechercherGroupe(o, lcD, lsD, lcI, lvI, awhere, lsD, ordre, con);
                con.close();
                ClassMAPTable[] c = (ClassMAPTable[]) cx.getResultat();
                TableauRecherche tr = new TableauRecherche(c, entete);
                tr.setLibelleAffiche(entetelibelle);
                tr.makeHtml();

                if (ext.compareToIgnoreCase("xml") == 0) {
                    os.write(tr.getExpxml().getBytes());
                } else if (ext.compareToIgnoreCase("pdf") == 0) {
                    tr.makeHtmlPDF();
                    //System.out.println(body);
                    arg1.setContentType("application/pdf");
                    File fichier = new File(getServletContext().getRealPath("") + fileName);

                    String htmlStringEntete = UtilitaireFormat.generateEntete(arg0.getParameter("titre"), "");
                    htmlStringEntete += tr.getHtmlPDF();

                    String fileNameWithPath = getServletContext().getRealPath("") + fileName;
                    OutputStream file = new FileOutputStream(new File(fileNameWithPath));
                    Document document = new Document();
                    try {
                        PdfWriter.getInstance(document, file);
                        document.open();
                        HTMLWorker htmlWorker = new HTMLWorker(document);
                        htmlWorker.parse(new StringReader(htmlStringEntete));

                        document.close();
                        file.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    System.out.println("PDF Created!");

                    // This should send the file to browser
                    OutputStream out = arg1.getOutputStream();
                    FileInputStream in = new FileInputStream(fileNameWithPath);

                    byte[] buffer = new byte[4096];
                    int length;
                    while ((length = in.read(buffer)) > 0) {
                        out.write(buffer, 0, length);
                    }
                    in.close();
                    out.flush();
                    fichier.delete();
                } else {
                    if (ext.compareToIgnoreCase("csv") == 0) {
                        os.write(tr.getExpcsv().getBytes());

                    } else {
                        if (ext.compareToIgnoreCase("xls") == 0) {
                            arg1.setContentType("application/vnd.ms-excel");
                            os.write(tr.getHtml().getBytes());
                            ;
                        }
                    }
                }
                os.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            os.close();
        }
    }

    protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1)
            throws ServletException, IOException {
    }
}
