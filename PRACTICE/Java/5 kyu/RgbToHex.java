import java.util.*;
public class RgbToHex {
    public static String DectoHex(int x){
        List<String> Remain = new ArrayList<String>();
        List<String> Abc = Arrays.asList("A", "B", "C", "D", "E", "F");
        while (x!=0){
            int remain = x % 16;
            String remString = Integer.toString(remain);
            if (remain<10){
                Remain.add(remString);
            }else{
                int extra = remain-10;
                Remain.add(Abc.get(extra));
            }

            x /= 16;
        }

        List<String> Rev = new ArrayList<>(Remain.size());
        for(int i = Remain.size()-1; i>=0; i--){
            Rev.add(Remain.get(i));  
        }

        String Hex ="";

        for(int i = 0; i<Rev.size(); i++){
            Hex = Hex + Rev.get(i);
        }
        
        if(Hex.length()==1){
            Hex = '0'+Hex;
        }

        return Hex;
    }

    public static String rgb(int r, int g, int b) {
        String red;
        String green;
        String blue;

        if (r<=0){
            red = "00";
        }else if(r>=255){
            red = "FF";
        }else{
            red = RgbToHex.DectoHex(r);
        }

        if(g<=0){
            green = "00";
        }else if(g>=255){
            green = "FF";
        }else{
            green = RgbToHex.DectoHex(g);
        }
        
        if(b<=0){
            blue = "00";
        }else if(b>=255){
            blue = "FF";
        } else{
            blue = RgbToHex.DectoHex(b);
        }

        String result = red+green+blue;
        return result;
    }



    public static void main(String[]args){
        System.out.println(RgbToHex.rgb(0, 0, 0));
        System.out.println(RgbToHex.rgb(1, 2, 3));
        System.out.println(RgbToHex.rgb(255, 255, 255));
        System.out.println(RgbToHex.rgb(254, 254, 252));
        System.out.println(RgbToHex.rgb(-20, 275, 125));
    }
}
