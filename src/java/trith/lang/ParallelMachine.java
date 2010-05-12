package trith.lang;
import  java.util.concurrent.Executors;
import  java.util.concurrent.Future;
import  java.util.Stack;
import  java.util.EmptyStackException;

/**
 * @author Arto Bendiken
 */
public class ParallelMachine extends AbstractMachine {
  public final Stack<Future> stack = new Stack<Future>();
  public final Stack<Future> queue = new Stack<Future>();

  public ParallelMachine() {
    this(4); // TODO: figure out how many CPUs are available
  }

  public ParallelMachine(int threads) {
    super(Executors.newFixedThreadPool(threads));
  }

  public <T> Future<T> peek() {
    try {
      return stack.peek();
    }
    catch (EmptyStackException e) {
      return null;
    }
  }

  public <T> Future<T> pop() {
    try {
      return stack.pop();
    }
    catch (EmptyStackException e) {
      throw new StackUnderflowError();
    }
  }

  public void push(Future<?> value) {
    stack.push(value);
  }

  public void unshift(Operator op) {
    queue.push(new Value(op));
  }
}
