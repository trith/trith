package trith.lang;
import  java.util.concurrent.Future;
import  java.util.concurrent.Callable;

/**
 * @author Arto Bendiken
 */
public interface Machine {
  public void execute(Operator operator);
  public Future<?> submit(Callable<?> callable);
  public void halt();

  public Object get();
  public Future peek();
  public Future pop();
  public void push(Future value);
  public void push(Callable<?> callable);
}
