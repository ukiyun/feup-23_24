
public class Multiples {

  public int solution(int number) {
      int divisors = 0;
      for(int i=0; i<number; i++){
        if(i%3==0 || i%5==0){
          divisors += i;
        }
      }

      return divisors;

  }
}