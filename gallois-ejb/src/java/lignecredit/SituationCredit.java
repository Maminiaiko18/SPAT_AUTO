/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lignecredit;

import java.sql.Connection;

/**
 *
 * @author
 */
public class SituationCredit extends LigneCredit{
    public SituationCredit(){
        this.setNomTable("ligneCreditDepense");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("SCRD", "get_seqligneCreditDepense");
        this.setId(makePK(c));
    }
}
