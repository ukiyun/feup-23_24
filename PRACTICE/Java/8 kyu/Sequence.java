public class Sequence{

  public static int[] reverse(int n){
    int[] reve = new int[n];
    int k = 0;
    for(int i=n; i>0; i--){
        reve[k] = i;
        k++;
    }
    return reve;
  }

}