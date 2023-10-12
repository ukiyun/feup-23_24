public class Bob {
  public static int enough(int cap, int on, int wait){
    if(on+wait <= cap){
        return 0;
    }else{
        int total = on + wait;
        int left = total-cap;
        return left;
    }   
  }


  public static void main(String []args){
    System.out.println(enough(100, 60, 50));
  }
}