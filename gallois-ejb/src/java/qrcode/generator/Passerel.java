/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package qrcode.generator;

import java.awt.Image;
import java.awt.image.BufferedImage;

/**
 *
 * @author DellDevmobile
 */
public class Passerel {
    private boolean isCrypt=false;
    private String texte="";
    private GeneratorQrCode g;
    private SimpleGenerator sg;
    public Passerel(){
        
    }
    public String getTexte(){
        return this.texte;
    }
    public void setTexte(String txt){
        this.texte=txt;
    }
    public boolean getCrypt(){
        return this.isCrypt;
    }
    public void setCrypt(boolean crypt){
        this.isCrypt=crypt;
    }
    public Passerel(String text,boolean iscrypt){
        this.texte=text;
        this.isCrypt=iscrypt;
    }
    public BufferedImage Generate() throws Exception{
        if(!texte.equals("")){
            if (!isCrypt){
                sg=new SimpleGenerator(texte);
                return sg.createImages();
            }
            else{
                g=new GeneratorQrCode(texte);
                return g.createImages();
            }
        }
        return null;
    }
    
}
