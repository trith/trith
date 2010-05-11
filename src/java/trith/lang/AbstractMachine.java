package trith.lang;
import  java.util.concurrent.ExecutorService;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;
import  java.util.concurrent.ExecutionException;

/**
 * @author Arto Bendiken
 */
public abstract class AbstractMachine implements Machine {
  protected ExecutorService executor;

  protected ExecutorService getExecutor() {
    return executor;
  }

  protected AbstractMachine() {}

  protected AbstractMachine(ExecutorService executor) {
    this.executor = executor;
  }

  public void execute(Operator operator) {
    operator.execute(this);
  }

  public Future<?> submit(Callable<?> callable) {
    return getExecutor().submit(callable);
  }

  public void halt() {
    getExecutor().shutdown();
  }

  public Object get() {
    try {
      return pop().get();
    }
    catch (InterruptedException e) {
      e.printStackTrace(); // FIXME
    }
    catch (ExecutionException e) {
      e.printStackTrace(); // FIXME
    }
    return null;
  }

  public abstract Future peek();
  public abstract Future pop();
  public abstract void push(Future value);

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
    push(String.valueOf(value));
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
