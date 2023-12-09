import java.io.*;  

class Day4p1 {
    public static void main(String[] args) {
        int[] winningNumbers = new int[10];
        int[] myNumbers = new int[25];
        int solution = 0;

        try (BufferedReader br = new BufferedReader(new FileReader("data.txt"))) {
            String line;

            while ((line = br.readLine()) != null) {
                int totalPointsOnCard = 0;
                String[] winningNumbersString = line.split(": ")[1].split("\\|")[0].split(" ");
                String[] myNumbersString = line.split(": ")[1].split("\\|")[1].split(" ");
                
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
                            if (totalPointsOnCard == 0) {
                                totalPointsOnCard = 1;
                            } else {
                                totalPointsOnCard *= 2;
                            }
                        }
                    }
                }
                solution += totalPointsOnCard;
            }
        } catch (IOException e) {
            System.err.println(e);
        }

        System.out.println(solution);
    }
}