package i18n;
import java.util.*;

public class i18nProperties{
	private Locale locale;
	private ResourceBundle resourceBundle;
	public Locale getLocale(){
		return locale;
	}
	public void setLocale(String local){
		//Locale l=new Locale(local,"");
		//this.locale=l;
	}
	public ResourceBundle getResourceBundle(){
		return resourceBundle;
	}
	public void setResourceBundle(String resourceBundle){
		ResourceBundle rB=ResourceBundle.getBundle(resourceBundle,getLocale());
		this.resourceBundle=rB;
	}
}