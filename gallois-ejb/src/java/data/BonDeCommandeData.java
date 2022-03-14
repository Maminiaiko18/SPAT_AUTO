/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import mg.spat.Engagement;

/**
 *
 * @author nyamp
 */
public class BonDeCommandeData {
    String idEngagement ;
    Engagement engagement=new Engagement();
    public BonDeCommandeData(String idEngagement) throws Exception{
        if(idEngagement !=null && !idEngagement.equals("")){
            engagement=(Engagement)engagement.getById(idEngagement, "ENGAGEMENTLIB", null);
        }
    }

    public String getIdEngagement() {
        return idEngagement;
    }

    public void setIdEngagement(String idEngagement) {
        this.idEngagement = idEngagement;
    }

    public Engagement getEngagement() {
        return engagement;
    }

    public void setEngagement(Engagement engagement) {
        this.engagement = engagement;
    }
    
    
}
