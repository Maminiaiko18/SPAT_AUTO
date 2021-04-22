package affichage;

import bean.CGenUtil;
import bean.ClassMAPTable;

public class ListeMultiple extends Liste{
    private String javascript;

	public ListeMultiple(String nom, ClassMAPTable type, String colAff, String colVal){
		setNom(nom);
		setSingleton(type);
		setColAffiche(colAff);
		setColValeur(colVal);
	}
	public ListeMultiple(String nom, String ajax, ClassMAPTable type, String colAff, String colVal){
		setNom(nom);
		setSingleton(type);
		setColAffiche(colAff);
		setColValeur(colVal);
		setJavascript(ajax);
	}
	
        public String getJavascript(){
            return this.javascript;
        }
        public void setJavascript(String javascript){
            this.javascript = javascript;
        }
        
	public void makeHtml()throws Exception{
		String temp="";
		temp="<select name="+getNom()+" class="+getCss()+" id="+getNom()+" "+getJavascript()+" "+getAutre()+"multiple=\"multiple\">";
		if(this.getBase()==null||this.getBase().length==0)
		{
		  if( getValeurBrute()!=null && getValeurBrute().length>0)
		  temp=makeHtmlValeur(temp);
		}
		else
		{
		  for(int i=0;i<this.getBase().length;i++)
		  {
			String champValeur=String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]),getColValeur()));
			String champAffiche=String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]),getColAffiche()));
			String selected="";
			if((getValeur()==null || getValeur().compareToIgnoreCase("")==0)&&getDefaultSelected()!=null)
			{
			  if(champValeur.compareToIgnoreCase(getDefaultSelected())==0)selected="selected";
			}
			else if(champValeur.compareToIgnoreCase(getValeur())==0)
			{
			  selected="selected";
			}
			temp+="<option value='"+champValeur+"' "+selected+">"+champAffiche+"</option>";
		  }
		}
		temp+="</select>";
		setHtml(temp);
	}
}