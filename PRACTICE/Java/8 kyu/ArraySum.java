import java.util.*;
public class ArraySum{
    public static int sum(int[] numbers){
        if (numbers==null){
            return 0;
        }else{
            List<Integer> removed = new ArrayList<Integer>();
            int maxi = Integer.MIN_VALUE;
            int mini = Integer.MAX_VALUE;
            for(int i=0; i< numbers.length; i++){
                if(numbers[i]>maxi){
                    maxi = numbers[i];
                }
                if(numbers[i]<mini){
                    mini = numbers[i];
                }
            }
            int minit = 0;
            int maxit = 0;
            for(int k=0; k< numbers.length; k++){
                int t = 0;
                if(numbers[k]==mini && minit == 0){
                    minit = 1;
                    continue;
                }else if(numbers[k]==maxi && maxit == 0){
                    maxit = 1;
                    continue;
                }else{
                    removed.add(t, numbers[k]);
                    t++;
                }
            }
            System.out.println(removed);
            int total = 0;
            for(int p=0; p<removed.size();p++){
                total = total + removed.get(p);
            }

            return total;
        }
    }

    public static void main(String[]args){
        System.out.println(ArraySum.sum(null));
    }
}
