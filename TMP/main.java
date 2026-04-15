import java.util.concurrent.ThreadLocalRandom;
import java.lang.annotation.*;

public final class Main {

    @Target(ElementType.FIELD)
    public @interface UpdateMaskField {

        String value() default "";
    }

    public interface Initializer {

        int order();

    }

    public static class MyClass {

    }

    public static final class MyInitializer extends MyClass implements Initializer {

        @UpdateMaskField(value = "hi")
        private final int order = 39;

        private int m;

        public MyInitializer() {
            super();

            m = 39;
        }

        @Override
        public int order() {
            return this.m + order;
        }
    }

    /**
     * This is a comment
     * @param b this is the variable
     */
    private static final void printMe(final boolean b) {
        // This is another comment



        /*
Some multilin ecomment
           */

    }

    public enum Color {

        RED,
        BLUE;
    }

    private static void printArg(final String arg) {
        System.out.printf("arg=%s\n", arg);
        final int value = 25;
        final Integer i = 25;
        final boolean b = true;
        final boolean b2 = false;
        final double d = 25;
        final Color color = Color.RED;
        final char c2 = '\n';
        final long l = 29;
        final float f2 = 3f;
        final double d3 = 30.25;
        final short s = 29;
        final char c = 100;
        final String v = null;
        printMe(false);

        final String val = "NBSP=\u020F!!!";
        final char nbsp = '\u020F';
        
        final Initializer myInit = new MyInitializer();
        System.out.println("myInit.order = " + myInit.order());




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
