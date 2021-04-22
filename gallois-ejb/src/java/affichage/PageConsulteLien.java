/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package affichage;

public class PageConsulteLien{
    
        public PageConsulteLien(){
        }
    
        public PageConsulteLien(String lien,String queryString){
            setLien(lien);
            setQueryString(queryString);
        }
        private String lien;

        public String getLien() {
            return lien;
        }

        public void setLien(String lien) {
            this.lien = lien;
        }

        public String getQueryString() {
            return queryString;
        }

        public void setQueryString(String queryString) {
            this.queryString = queryString;
        }
        private String queryString;
    }
