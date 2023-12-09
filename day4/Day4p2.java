import java.io.*;  
import java.util.Arrays;

class Day4p2 {
    public static void main(String[] args) {
        int[] winningNumbers = new int[10];
        int[] myNumbers = new int[25];
        int[] cardInstances = new int[202];
        Arrays.fill(cardInstances, 1);
        int solution = 0;
        int cardNumber = 0;

        try (BufferedReader br = new BufferedReader(new FileReader("data.txt"))) {
            String line;

            while ((line = br.readLine()) != null) {
                String[] winningNumbersString = line.split(": ")[1].split("\\|")[0].split(" ");
                String[] myNumbersString = line.split(": ")[1].split("\\|")[1].split(" ");
                int numMatches = 0;
                cardNumber++;
                int pos = 0;

                for (int i = 0; i < winningNumbersString.length; i++) {
                    if (winningNumbersString[i] != "") {
                        System.out.println(winningNumbersString[i]);
                        winningNumbers[pos++] = Integer.parseInt(winningNumbersString[i]);
                    }
                }
                
                pos = 0;
                for (int i = 0; i < myNumbersString.length; i++) {
                    if (myNumbersString[i] != "") {
                        myNumbers[pos++] = Integer.parseInt(myNumbersString[i]);
                    }
                }
                
                for (int i = 0; i < 10; i++) {
                    int winningNumber = winningNumbers[i];

                    for (int j = 0; j < 25; j++) {
                        int myNumber = myNumbers[j];
                        if (myNumber == winningNumber) {
                            numMatches += 1;
                        }
                    }
                }

                for (int i = 1; i <= numMatches; i++) {
                    cardInstances[cardNumber+i-1] += cardInstances[cardNumber-1];   
                }
            }
        } catch (IOException e) {
            System.err.println(e);
        }

        for (int i = 0; i < cardInstances.length; i++) {
            solution += cardInstances[i];
        }

        System.out.println(solution);
    }
}