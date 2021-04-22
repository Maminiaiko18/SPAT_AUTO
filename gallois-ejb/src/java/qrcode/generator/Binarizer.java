package qrcode.generator;

import java.util.ArrayList;
import java.util.BitSet;

	public class Binarizer{
        public int E;
        public Binarizer(int e){
            this.E = e;
        }
        public String toBin(){
            String Resultat = "";
            int i = 0;
            int q;
          ArrayList<Boolean> res=new ArrayList<Boolean>();
            if (this.E == 1){
                boolean b = true;
                res.add(b);
            }
            else if(this.E==0){
                boolean b = false;
                res.add(b);
            }
            while ((q = this.E / 2)!=0){
                if (q != 1){
                    int r = this.E % 2;
                    if (r == 1){
                        boolean b = true;
                        res.add(b);
                    }
                    else{
                        boolean b = false;
                        res.add(b);
                    }
                    this.E = q;
                    i++;
                }
                else if (q==1){
                    int r = this.E % 2;
                    if (r == 1){
                        boolean b = true;
                        res.add(b);
                    }
                    else{
                        boolean b = false;
                        res.add(b);
                    }
                    boolean bol = true;
                    res.add(bol);
                    break;
                }
                
            }
            BitSet bt = new BitSet(res.size());
            int k=0;
            for (int j =res.size()-1; j >=0; j--){
                bt.set(j, res.get(k));
                k++;
            }
            for (int j = 0; j < bt.length(); j++){
                if (bt.get(j))
                    Resultat += "1";
                else Resultat += "0";
            }

            return Resultat;
        }
    }

