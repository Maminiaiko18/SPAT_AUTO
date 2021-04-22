/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

/**
 *
 * @author Joe
 */
public class AlphaUtils {
    public static String indexToColumnItr(int index, char[] alphabet) {
        if (index <= 0) throw new IndexOutOfBoundsException("index must be a positive number");
        if (index <= alphabet.length) return Character.toString(alphabet[index - 1]);
        StringBuffer sb = new StringBuffer();
        while (index > 0) {
            sb.insert(0, alphabet[--index % alphabet.length]);
            index /= alphabet.length;
        }
        return sb.toString();
    }

    // Recursive
    public static String indexToColumnRec(int index, char[] alphabet) {
        if (index <= 0) throw new IndexOutOfBoundsException("index must be a positive number");
        if (index <= alphabet.length) return Character.toString(alphabet[index - 1]);
        return indexToColumnRec(--index / alphabet.length, alphabet) + alphabet[index % alphabet.length];
    }

    public static String[] generateSequence(int size) {
        String[] sequence = new String[size];
        int i = 0;
        for (AlphaIterator it = new AlphaIterator(size); it.hasNext();) {
            //System.out.println(" =========== " + it.next());
            sequence[i] = it.next();
            i++;
        }
        return sequence;
    }
}
