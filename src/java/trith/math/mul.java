package trith.math;
import  trith.lang.*;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;
import  java.util.concurrent.ExecutionException;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/mul
 */
public class mul implements Operator {
  public static final String URL = "http://trith.org/math/mul";

  public void execute(Machine machine) {
    final Future a = machine.pop();
    final Future b = machine.pop();
    machine.push(new Callable<BigDecimal>() {
      public BigDecimal call() {
        try {
          return ((BigDecimal)a.get()).multiply((BigDecimal)b.get());
        }
        catch (InterruptedException e) {} // FIXME
        catch (ExecutionException e) {}   // FIXME
        return null;
      }
    });
  }
}
