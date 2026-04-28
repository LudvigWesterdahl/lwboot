import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.lang.annotation.*;
import java.lang.annotation.Documented;

public final class Main {

    /**
     * This is the javadoc
     */
    @Target(ElementType.FIELD)
    @Documented
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

        private static final int MAX_WIDTH = 200;

        private int m;

        public MyInitializer() {
            super();
            printMe(true);
            final String someString = String.format("h=%s", "hi");

            m = MAX_WIDTH;
        }

        @Override
        public int order() {
            final int myOrd = 25;

            return this.m + order + myOrd;
        }
    }

    /**
     * This is a comment {@code a = 3} and {@link Initializer} and {@link UpdateMaskField}.
     *
     * @param b this is the variable
     */
    @Deprecated
    private static final void printMe(final boolean b) {
        // This is another comment



        /*
Some multilin ecomment
           */

    }

    public enum Color {
        /**
         * The RED
         */
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

        final java.util.List<Integer> list = new java.util.ArrayList<Integer>();
        final List<Integer> list2 = new ArrayList<>();
        list.add(500);

        System.out.printf("list out [list=%s]%n", list);
        list2.add(500);

        list.add(500);

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



