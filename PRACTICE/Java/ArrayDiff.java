public class ArrayDiff {

  public static int[] arrayDiff(int[] a, int[] b) {
    for(int i = 0; i<a.length; i++){
        boolean isin = false;
        for (int k = 0; k<b.length; k++){
            if(b[k]==a[i]){
                isin = true;
            }
        }
        if(isin==true){
            continue;
        }else{
            int[] arraynew = new int[a.length-1];
            for(int t = 0;t<a.length;t++){
                if(t!=i){
                    arraynew[t]=a[t];
                }else{
                    arraynew[t]=a[t+1];
                }
            }
        }
    }
    a = arraynew;
    return a;
  }

}