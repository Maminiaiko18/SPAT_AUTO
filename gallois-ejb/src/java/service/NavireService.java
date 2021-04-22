/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import java.sql.Connection;
import mg.spat.Navire;

/**
 *
 * @author MEVA
 */
public class NavireService {
    public static void testDoublon(Navire v,Connection c) throws Exception{
        try {
            Navire[] lnav=(Navire[])CGenUtil.rechercher(v, "select * from navire where nom='"+v.getNom()+"' and pavillon='"+v.getPavillon()+"'", c);
            if(lnav.length>0)
                throw new Exception("Il y a un doublon de navire!");
        }catch(Exception e){
            throw e;
        }
    }
}
