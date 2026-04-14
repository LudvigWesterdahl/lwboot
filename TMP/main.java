import java.util.concurrent.ThreadLocalRandom;

public final class Main {

    private static void printArg(final String arg) {
        System.out.printf("arg=%s\n", arg);
        final int value = 25;
        final Integer b = 25;
        final boolean b = true;
        final double d = 25;
        final long l = 29;
        final short s = 29;
        final char c = 100;
        
    



        if (arg.startsWith("12")) {
            throw new IllegalArgumentException(String.format(
                "bad arg %s",
                arg
            ));
        }

        return;
    }

    public static void main(String[] args) {
        System.out.println("Hello World!");
        for (final String arg : args) {
            printArg(arg);
        }

        int rand = ThreadLocalRandom.current().nextInt();
        printArg("got rand = " + rand);
    }
}
