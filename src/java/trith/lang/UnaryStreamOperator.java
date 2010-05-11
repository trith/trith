package trith.lang;
import  java.util.Iterator;

/**
 * @author Arto Bendiken
 */
public abstract class UnaryStreamOperator<T, A> extends UnaryOperator<T, A> {
  public T execute(A a) {
    if (a instanceof Iterator) {
      return execute((Iterator)a);
    }
    if (a instanceof Iterable) {
      return execute(((Iterable)a).iterator());
    }
    if (a instanceof String) {
      return execute((String)a);
    }
    return null; // FIXME
  }

  public abstract T execute(Iterator a);
  public abstract T execute(String a);
}
