public class Power2{
  public static long[] powersOfTwo(int n){
    long[] powers2 = new long[n+1];
    for(int i= 0; i<= n;i++){
        long power = (long)Math.pow(2, i);
        powers2[i] = power;
    }

    return powers2;
  }


  public static void main(String [] Args){
    System.out.println(java.util.Arrays.toString(powersOfTwo(0)));
    System.out.println(java.util.Arrays.toString(powersOfTwo(1)));
    System.out.println(java.util.Arrays.toString(powersOfTwo(4)));
  }
}