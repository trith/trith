package trith.lang;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;
import  java.util.concurrent.ExecutionException;

/**
 * @author Arto Bendiken
 */
public abstract class UnaryOperator<T> implements Operator {
  public void execute(Machine machine) {
    final Future<T> x = machine.pop();

    machine.push(new Callable<T>() {
      public T call() {
        try {
          return execute(x.get());
        }
        catch (InterruptedException e) {
          e.printStackTrace(); // FIXME
        }
        catch (ExecutionException e) {
          e.printStackTrace(); // FIXME
        }
        return null;
      }
    });
  }

  public abstract T execute(T x);
}
