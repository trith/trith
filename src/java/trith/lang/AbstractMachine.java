package trith.lang;
import  java.util.concurrent.ExecutorService;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;
import  java.util.concurrent.ExecutionException;
import  java.util.Stack;
import  java.util.EmptyStackException;

/**
 * @author Arto Bendiken
 */
public abstract class AbstractMachine implements Machine {
  public final Stack<Future> stack = new Stack<Future>();
  public final Stack<Future> queue = new Stack<Future>();

  protected ExecutorService executor;

  protected ExecutorService getExecutor() {
    return executor;
  }

  protected AbstractMachine() {}

  protected AbstractMachine(ExecutorService executor) {
    this.executor = executor;
  }

  public void execute() {
    Object op;
    while ((op = shift()) != null) {
      if (op instanceof Future) {
        try {
          op = ((Future)op).get();
        }
        catch (InterruptedException e) {
          e.printStackTrace(); // FIXME
        }
        catch (ExecutionException e) {
          e.printStackTrace(); // FIXME
        }
      }
      if (op instanceof Operator) {
        ((Operator)op).execute(this);
      }
      else {
        push(op);
      }
    }
  }

  public void execute(Operator operator) {
    unshift(operator);
    execute();
  }

  public Future<?> submit(Callable<?> callable) {
    return getExecutor().submit(callable);
  }

  public void halt() {
    getExecutor().shutdown();
  }

  public Object shift() {
    if (!queue.empty()) {
      return queue.pop();
    }
    else {
      return null;
    }
  }

  public void unshift(Operator op) {
    queue.push(new Value(op));
  }

  public <T> T get() {
    try {
      return this.<T>pop().get();
    }
    catch (InterruptedException e) {
      e.printStackTrace(); // FIXME
    }
    catch (ExecutionException e) {
      e.printStackTrace(); // FIXME
    }
    return null;
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

  public void push(Callable<?> callable) {
    push(submit(callable));
  }

  public void push(Object value) {
    push(new Value(value));
  }

  public void push(boolean value) {
    push(Boolean.valueOf(value));
  }

  public void push(char value) {
    push(Character.valueOf(value));
  }

  public void push(byte value) {
    push(Number.valueOf(value));
  }

  public void push(short value) {
    push(Number.valueOf(value));
  }

  public void push(int value) {
    push(Number.valueOf(value));
  }

  public void push(long value) {
    push(Number.valueOf(value));
  }

  public void push(float value) {
    push(Number.valueOf(value));
  }

  public void push(double value) {
    push(Number.valueOf(value));
  }
}
