public class TrailingZeros {

    public static long factorial(int n){
        long k = 1;
        if(n<0){
            return 0;
        }else if(n==0){
            return 1;
        }else{
            for (int i= 1; i<=n; i++ ){
                k = k * i;
            }
            return k;
        }
        
    }
    public static int zeros(int n) {
       long t = TrailingZeros.factorial(n);
       String tS = Long.toString(t);
       int zeros = 0;
       for(int i = tS.length()-1;i>=0;i--){
        if (tS.charAt(i)=='0'){
            zeros+=1;
        }else{
            return zeros;
        }
       }

       return zeros;
    }

    public static void main(String[]aStrings){
        System.out.println(TrailingZeros.zeros(0));
        System.out.println(TrailingZeros.zeros(6));
        System.out.println(TrailingZeros.zeros(14));
    }
}


// wrong!