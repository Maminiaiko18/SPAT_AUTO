/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import java.util.Iterator;

/**
 *
 * @author Joe
 */
public class AlphaIterator implements Iterator<String>{
    
    private int maxIndex;
    private int index;
    private char[] alphabet;

    public AlphaIterator() {
        this(Integer.MAX_VALUE);
    }

    public AlphaIterator(int maxIndex) {
        this(maxIndex, "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray());
    }

    public AlphaIterator(char[] alphabet) {
        this(Integer.MAX_VALUE, alphabet);
    }

    public AlphaIterator(int maxIndex, char[] alphabet) {
        this.maxIndex = maxIndex;
        this.alphabet = alphabet;
        this.index = 1;
    }
    
    @Override
    public boolean hasNext() {
        return this.index < this.maxIndex;
    }

    @Override
    public String next() {
        return AlphaUtils.indexToColumnItr(this.index++, this.alphabet);
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
