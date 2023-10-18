public class Cockroach
{
    public int cockroachSpeed(double x){
      double cm= x * 100000;
      double time= 3600;   // 1 hour = 60 minutes = 3600 seconds
      double convert = cm/time;
      int coflo = (int)Math.floor(convert);
      return coflo;
    }

    public static void main(String []args){ 
      Cockroach cockroach = new Cockroach();
      System.out.println(cockroach.cockroachSpeed(1.08));
    }
  }

