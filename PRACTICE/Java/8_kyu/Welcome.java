import java.util.*;

public class Welcome {
    public class Pair<L,R>{
        private L l;
        private R r;
        public Pair(L l, R r){
            this.l = l;
            this.r = r;
        }
        public L getL(){return l;}
        public R getR(){return r;}
        public void setL(L l){this.l = l;}
        public void setR(R r){this.r = r;}

    }
   public static String greet(String language){
        List<Pair<String, String>> languages = new ArrayList<Pair<String, String>>();
        Welcome welcome = new Welcome();
        languages.add(welcome.new Pair<String, String>("english", "Welcome"));
        languages.add(welcome.new Pair<String, String>("czech", "Vitejte"));
        languages.add(welcome.new Pair<String, String>("danish", "Velkomst"));
        languages.add(welcome.new Pair<String, String>("dutch", "Welkom"));
        languages.add(welcome.new Pair<String, String>("estonian", "Tere tulemast"));
        languages.add(welcome.new Pair<String, String>("finnish", "Tervetuloa"));
        languages.add(welcome.new Pair<String, String>("flemish", "Welgekomen"));
        languages.add(welcome.new Pair<String, String>("french", "Bienvenue"));
        languages.add(welcome.new Pair<String, String>("german", "Willkommen"));
        languages.add(welcome.new Pair<String, String>("irish", "Failte"));
        languages.add(welcome.new Pair<String, String>("italian", "Benvenuto"));
        languages.add(welcome.new Pair<String, String>("latvian", "Gaidits"));
        languages.add(welcome.new Pair<String, String>("lithuanian", "Laukiamas"));
        languages.add(welcome.new Pair<String, String>("polish", "Witamy"));
        languages.add(welcome.new Pair<String, String>("spanish", "Bienvenido"));
        languages.add(welcome.new Pair<String, String>("swedish", "Valkommen"));
        languages.add(welcome.new Pair<String, String>("welsh", "Croeso"));


        for (int i=0; i<languages.size(); i++){
            if(languages.get(i).getL() == language){
                String welcomes = languages.get(i).getR();
                String result = String.format("Your function should have returned '%s'. Try again.", welcomes);
                return result;
            }
        }

        return ("Your function should have returned 'Welcome'. Try again.");
        
   }

    public static void main(String []args){
        System.out.println(greet("english"));
        System.out.println(greet("dutch"));
        System.out.println(greet("IP_ADDRESS_INVALID"));
    }
}