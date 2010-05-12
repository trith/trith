package trith.lang;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;
import  java.util.concurrent.ExecutionException;
import  java.util.concurrent.TimeUnit;
import  java.util.concurrent.TimeoutException;

/**
 * @author Arto Bendiken
 * @see    http://en.wikipedia.org/wiki/Futures_and_promises
 */
public class Promise<V> implements Future {
  protected boolean isForced = false;
  protected V result;
  protected Callable<V> callable;

  public Promise() {}

  public Promise(Callable<V> callable) {
    this.callable = callable;
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

  public V get() throws InterruptedException, ExecutionException {
    try {
      return force();
    }
    catch (Exception e) {
      throw new ExecutionException(e);
    }
  }

  public V get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException, TimeoutException {
    return get(); // FIXME
  }

  public V force() throws Exception {
    if (!isForced) { // TODO: make this atomic
      isForced = true;
      result   = call();
    }
    return result;
  }

  public V call() throws Exception {
    return callable.call();
  }
}
