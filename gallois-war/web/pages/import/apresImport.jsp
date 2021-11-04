<%@page import="mg.spat.exploitant.AdminActivite"%>
<%@page import="mg.spat.exploitant.Activite"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="excel.ImportExcel"%>
<%@page import="user.UserEJB"%>
<%
        UserEJB u = null;
        String acte = null;
        String file = null;
        String lien = null;
       
        try {
       
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            file = request.getParameter("file");
            lien = (String) session.getValue("lien");
            String bute = "exploitants/activites-liste.jsp&etat=ACTIVITELIBCOMPLET_C&rubrique=Conteneur";
            
            if(acte.compareTo("import")==0){
                System.out.println("import excel");
                System.out.println(file);
                
                String idescale = null;
                String mois = null;
                
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = upload.parseRequest(request);
                Iterator i = items.iterator();
                FileItem fichierExcel = null;
                while (i.hasNext()) {
                    FileItem itemTemp = (FileItem) i.next();
                    if(!itemTemp.isFormField()) {
                        fichierExcel = itemTemp;
                    }
                    else {
                        String name = itemTemp.getFieldName();
                        String value = itemTemp.getString();
                        
                        if(name.equalsIgnoreCase("escale")) {
                            idescale = value;
                        }
                        if(name.equalsIgnoreCase("mois")){
                            mois = value;
                        }
                    }
                }
                if(mois==null || mois.length()==0){
                    throw new Exception("mois invalide");
                }
                ImportExcel ex = new ImportExcel();
                ArrayList<Activite> ls=ex.importerTous(fichierExcel.getInputStream(), idescale,utilitaire.Utilitaire.stringToInt(mois) );
                AdminActivite admin= new AdminActivite();
                admin.insererActiviteMultiple(ls, u.getUser().getRefuser()+"", null);
                
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
           <% }
                

            if(acte.compareTo("importJournalier")==0){
                
                System.out.println("import Journalier");
                System.out.println(file);
                String idescale = null;
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = upload.parseRequest(request);
                Iterator i = items.iterator();
                FileItem fichierExcel = null;
                while (i.hasNext()) {
                    FileItem itemTemp = (FileItem) i.next();
                    if(!itemTemp.isFormField()) {
                        fichierExcel = itemTemp;
                    }else {
                        String name = itemTemp.getFieldName();
                        String value = itemTemp.getString();
                        
                        if(name.equalsIgnoreCase("escale")) {
                            idescale = value;
                        }
                    }
                }
                
                ImportExcel ex = new ImportExcel();
                ArrayList<Activite> ls=ex.importJournalier(fichierExcel.getInputStream(),idescale);
                System.out.println("liste.lenght==="+ls.size());
                AdminActivite admin= new AdminActivite();
                admin.insererActiviteMultiple(ls, u.getUser().getRefuser()+"", null);
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
                <% 


             }
                
            
        }catch(Exception e){
            e.printStackTrace();%>
        <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
        history.back();</script>
        <%}
%>