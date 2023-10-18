import java.util.*;
class Camel{
  static String toCamelCase(String s){
    String temp ="";
    List<String> divise = new ArrayList<>(); // initialize the list
    for(int i=0; i<s.length(); i++){
        if(s.charAt(i)=='-' || s.charAt(i)=='_'){ // use || instead of &&
            divise.add(temp);
            temp = "";
        }else{
            temp = temp+ s.charAt(i);
        }
    }
    divise.add(temp);
    String result = "";
    for(int k=0; k<divise.size();k++){
        if (k==0){
            result = result + divise.get(k);
        }else{
            String word = divise.get(k);
            String firstchar = word.substring(0, 1);
            String upper = firstchar.toUpperCase();
            result = result+ (upper + word.substring(1));
        }
    }

    return result;
  }

  public static void main(String []Args){
    System.out.println(toCamelCase("the-stealth-warrior"));
    System.out.println(toCamelCase("The_Stealth_Warrior"));
    System.out.println(toCamelCase("The_Stealth-Warrior"));
    
  }
}