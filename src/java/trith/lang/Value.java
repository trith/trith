package trith.lang;
import  java.util.concurrent.Future;
import  java.util.concurrent.TimeUnit;
import  java.util.concurrent.ExecutionException;
import  java.util.concurrent.TimeoutException;

/**
 * @author Arto Bendiken
 */
public class Value implements Future<Object> {
  protected Object value;

  public Value(Object value) {
    this.value = value;
  }

  public boolean cancel(boolean mayInterruptIfRunning) {
    return false;
  }

  public boolean isCancelled() {
    return false;
  }

  public boolean isDone() {
    return true;
  }

  public Object get() throws InterruptedException, ExecutionException {
    return value;
  }

  public Object get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException, TimeoutException {
    return value;
  }
}
