public class Winner {
    public static String declareWinner(Fighter fighter1, Fighter fighter2, String firstAttacker) {
        String secondAttacker ="";
        Fighter firstAttack;
        Fighter secondAttack;
        if(firstAttacker == fighter1.name){
            secondAttacker = fighter2.name;
            firstAttack = fighter1;
            secondAttack = fighter2;
        }else{
            secondAttacker = fighter1.name;
            firstAttack = fighter2;
            secondAttack = fighter1;
        }

        boolean dead = false;
        int i = 1;
        String Winner ="";
        while (dead==false){
            if(i%2!=0){
                System.out.print(firstAttacker + " attacks " + secondAttacker + "; ");
                secondAttack.health = secondAttack.health - firstAttack.damagePerAttack;
                if(secondAttack.health<=0){
                    System.out.print(secondAttacker + " now has " + secondAttack.health+" health");
                }else{
                    System.out.println(secondAttacker + " now has " + secondAttack.health+" health.");
                }
            }
            if(i%2==0){
                System.out.print(secondAttacker + " attacks " + firstAttacker+"; ");
                firstAttack.health= firstAttack.health -secondAttack.damagePerAttack;
                if (firstAttack.health<=0){
                    System.out.print(firstAttacker + " now has " + firstAttack.health+" health");
                }else{
                    System.out.println(firstAttacker + " now has " + firstAttack.health+" health.");

                }
            }

            if(firstAttack.health<=0){
               Winner =secondAttack.name;
               System.out.println(" and is dead. "+ Winner + " wins.");
               dead = true;
                
            }
            if(secondAttack.health<=0){
                Winner =firstAttack.name;
                System.out.println(" and is dead. "+ Winner + " wins.");
                dead = true;
            }

            i++;
        }
        
        return (Winner);
    }


    public static void main(String [] args){
        System.out.println(Winner.declareWinner(new Fighter("Lew", 10, 2), new Fighter("Harry", 5, 4), "Lew"));
        System.out.println(Winner.declareWinner(new Fighter("Lew", 10, 2), new Fighter("Harry", 5, 4), "Harry"));
        System.out.println(Winner.declareWinner(new Fighter("Harald", 20, 5), new Fighter("Harry", 5, 4), "Harry"));
        System.out.println(Winner.declareWinner(new Fighter("Harald", 20, 5), new Fighter("Harry", 5, 4), "Harald"));
        System.out.println(Winner.declareWinner(new Fighter("Jerry", 30, 3), new Fighter("Harald", 20, 5), "Jerry"));
        System.out.println(Winner.declareWinner(new Fighter("Jerry", 30, 3), new Fighter("Harald", 20, 5), "Harald"));
    
    }
}