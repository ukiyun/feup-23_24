import java.util.*;
public class Between {
    public static int[] between(int a, int b){
        List<Integer> net = new ArrayList<Integer>();
        int k = 0;
        for(int i=a; i<=b;i++){
            net.add(k, i);
            k++;
        }

        int[] net2 = net.stream().mapToInt(i->i).toArray();
        return net2;
    }


    public static void main(String [] args){
        System.out.println(between(1, 4));
        System.out.println(between(-2, 2));
    }
}
