class Solution {
    static String removeExclamationMarks(String s) {
        String noExclamation ="";
        for(int i = 0; i<s.length();i++){
            if(s.charAt(i)=='!'){
                continue;
            }else{
                noExclamation += s.charAt(i);
            }
        }
        return noExclamation;
    }

    public static void main(String []args){
        System.out.println(removeExclamationMarks( "Hello World!"));
    }
}