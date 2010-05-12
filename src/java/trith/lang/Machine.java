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

  public <T> T get();
  public <T> Future<T> peek();
  public <T> Future<T> pop();
  public void push(Future<?> value);
  public void push(Callable<?> callable);

  public void unshift(Operator op);
}
