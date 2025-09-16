class Node<T> {
    T data;
    Node<T> next;

    public Node(T data) {
        this.data = data;
        this.next = null;
    }
}

class IntegerStack<T> {
    private Node<T> head;
    private int size;

    public IntegerStack() {
        this.head = null;
        this.size = 0;
    }

    public void push(T data) {
        /*
         * Implement the push function. Your implementation should be less than five lines.
         * Remember we are using the head of the linked list as the top of the stack.
         * This function should have an O(1) time complexity.
         *
         */
        Node<T> newNode = new Node<>(data);
        newNode.next = head;
        head = newNode;
        size++;
    }

    public T pop() {
        /*
         * Implement the pop function. Your implementation should be less than five lines.
         * Remember we are using the head of the linked list as the top of the stack.
         * This function should have an O(1) time complexity.
         *
         */
        if (head == null) return null;
        T data = head.data;
        head = head.next;
        size--;
        return data;
    }


    public T peek() {
        /*
         * Implement the peek function. Your implementation should be less than five lines.
         * Peek() checks the value of the top of the stack.
         * This function should have an O(1) time complexity.
         *
         */
        if (head == null) return null;
        return head.data;
    }

    public boolean isEmpty() {
        /*
         * Implement the isEmpty() function. Your implementation should be less than five lines.
         * if the stack does not have any value, return false; otherwise, return true.
         * This function should have an O(1) time complexity.
         */
        return head == null;
    }

    public int size() {
        return size;
    }
}

public class AssignmentOne {

    public static int longestValidParentheses(String s) {
        IntegerStack <Integer> stack = new IntegerStack<>();
        stack.push(-1);
        int maxLen = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '(') {
                /*
                 * Implement the if statement.
                 * You should use some of the operations of the stack.
                 */
                stack.push(i);
            } else {
                /*
                 * Implement the else statement.
                 * You should use some of the operations of the stack.
                 */
                stack.pop();
                if (stack.isEmpty()) {
                    stack.push(i);
                } else {
                    int currentLen = i - stack.peek();
                    maxLen = Math.max(maxLen, currentLen);
                }
            }
        }
        return maxLen;
    }


    /*
     * You may use a main function to test your code during development. However, as stated in the handout,
     * you must remove your main function before submission. We will use a standard main function to test your code.
     * Including your own main function in the submission will cause your code to fail the testing process.
     */

    // TESTING MAIN - REMEMBER TO REMOVE BEFORE SUBMISSION!
    public static void main(String[] args) {
        System.out.println("🧪 Testing Stack Implementation & Parentheses Algorithm");
        System.out.println("=" .repeat(50));

        // Test 1: Simple pairs
        testCase("()", 2, "Simple pair");
        testCase("(())", 4, "Nested pair (2 pairs total)");
        testCase("()()", 4, "Two separate pairs");

        // Test 2: No pairs
        testCase("", 0, "Empty string");
        testCase("(((", 0, "Only opening brackets");
        testCase(")))", 0, "Only closing brackets");

        // Test 3: Mixed cases
        testCase("()())", 4, "Valid pairs + extra closing");
        testCase(")()", 2, "Invalid start + valid pair");
        testCase("(()", 2, "Extra opening + one pair");

        // Test 4: Complex cases
        testCase("(()())", 6, "Complex nested and sequential");
        testCase(")()())", 4, "Invalid start + two pairs + extra");

        System.out.println("\n🎯 All tests completed!");
        System.out.println("💡 Remember: Remove this main() before submission!");
    }

    // Helper function to test our algorithm
    private static void testCase(String input, int expected, String description) {
        int result = longestValidParentheses(input);
        String status = (result == expected) ? "✅ PASS" : "❌ FAIL";

        System.out.printf("%-25s | Input: %-8s | Expected: %-2d | Got: %-2d | %s%n",
                         description, "\"" + input + "\"", expected, result, status);

        if (result != expected) {
            System.out.println("   🔍 Debug: Check your algorithm logic!");
        }
    }

}