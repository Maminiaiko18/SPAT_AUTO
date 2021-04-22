/**
 * 6 oct. 2015
 *
 * @author Manda
 */
package utilitaire;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import net.sourceforge.jeval.EvaluationException;
import net.sourceforge.jeval.Evaluator;

public class UtilitaireFormule {

    public static double eval(String expression, HashMap<String, String> variables) throws EvaluationException {
        expression = expression.replace(",",".");
        expression = expression.replace("[", "#{").replace("]", "}");
        return evalWithCurlyBrackets(expression, variables);
    }

    public static double evalWithCurlyBrackets(String expression, HashMap<String, String> variables) throws EvaluationException {
        Evaluator expr = new Evaluator();
        expr.setVariables(variables);
        String evaluate = expr.evaluate(expression);
        return Double.parseDouble(evaluate);
    }
    
    public static boolean isFormuleWithBrackets(String expression){
        return (expression.contains("[") && expression.contains("]"));
    }
    
    public static String[] extractExpressionWithBrackets(String expression) throws Exception{
        Pattern p = Pattern.compile("\\[(.*?)\\]");
        Matcher m = p.matcher(expression);
        List<String> toRet = new ArrayList<>();
        int nb=0;
        while(m.find()) {
            toRet.add(m.group(1));
            nb++;
        }
        if(nb==0){
            throw new EvaluationException("Formula invalid, use Brackets []");
        }
        String[] ret = new String[toRet.size()];
        ret = toRet.toArray(ret);
        return ret;
    }

}
