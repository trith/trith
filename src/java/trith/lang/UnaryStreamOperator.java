package trith.lang;
import  java.util.Iterator;
import  java.util.Collection;
import  java.util.List;

/**
 * @author Arto Bendiken
 */
public abstract class UnaryStreamOperator<T, A> extends UnaryOperator<T, A> {
  public T execute(A a) {
    if (a instanceof String) {
      return execute((String)a);
    }
    if (a instanceof List) {
      return execute((List)a);
    }
    if (a instanceof Collection) {
      return execute((Collection)a);
    }
    if (a instanceof Iterator) {
      return execute((Iterator)a);
    }
    if (a instanceof Iterable) {
      return execute((Iterable)a);
    }
    return null; // FIXME
  }

  public abstract T execute(String a);
  public abstract T execute(Iterator a);

  public T execute(List a) {
    return execute((Collection)a);
  }

  public T execute(Collection a) {
    return execute(a.iterator());
  }

  public T execute(Iterable a) {
    return execute(a.iterator());
  }
}
