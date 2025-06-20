public class Main {
     public static void main(String[] args) {
        // Getting the Logger instance
        Logger logger1 = Logger.getInstance();
        logger1.log("First log message");

        // Try to get the Logger again
        Logger logger2 = Logger.getInstance();
        logger2.log("Second log message");

        // Check if both instances are the same
        if (logger1 == logger2) {
            System.out.println("Singleton confirmed. Only one Logger instance exists.");
        } else {
            System.out.println(" Singleton failed. Different instances exist.");
        }
    }
}
