package trith.lang;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;
import  java.util.concurrent.ExecutionException;

/**
 * @author Arto Bendiken
 * @see    http://en.wikipedia.org/wiki/Arity#Nullary
 */
public abstract class NullaryOperator<T> implements Operator {
  public void execute(Machine machine) {
    machine.push(new Callable<T>() {
      public T call() {
        return execute();
      }
    });
  }

  public abstract T execute();
}
