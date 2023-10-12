import java.util.*;
public class Positive {
    public static int sum(int[] arr){
        if(arr.length==0){
            return 0;
        }
        List<Integer> pos = new ArrayList<Integer>();
        int k = 0;
        for(int i = 0; i<arr.length; i++){
            if(arr[i]>0){
                pos.add(k, arr[i]);
                k++;
            }
        }

        if(pos.size()==0){
            return 0;
        }else{
            int summ = 0;
            for(int j = 0; j<pos.size(); j++){
                summ = summ + pos.get(j);
            }
            return summ;
        }
    }

    public static void main(String [] args){
        System.out.println(sum(new int[]{1,2,3,4,5}));
        System.out.println(sum(new int[]{1,-2,3,4,5}));
        System.out.println(sum(new int[]{}));
        System.out.println(sum(new int[]{-1,-2,-3,-4,-5}));
        System.out.println(sum(new int[]{-1,2,3,4,-5}));
        
    }
}
