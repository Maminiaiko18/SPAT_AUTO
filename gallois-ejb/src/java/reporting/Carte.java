/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package reporting;

import java.sql.Date;

/**
 *
 * @author Doudou
 */
public class Carte extends ServeurPDF {
    private  Date daty;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public Carte(){
    }
}
