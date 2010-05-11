package trith.lang;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;
import  java.util.concurrent.ExecutionException;

/**
 * @author Arto Bendiken
 */
public abstract class UnaryOperator<T, A> implements Operator {
  public void execute(Machine machine) {
    final Future<A> a = machine.pop();

    machine.push(new Callable<T>() {
      public T call() {
        try {
          return execute(a.get());
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

  public abstract T execute(A a);
}
