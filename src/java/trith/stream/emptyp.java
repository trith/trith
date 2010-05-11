package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/emptyp
 */
public class emptyp extends UnaryOperator<Boolean, Object> {
  public static final String URL = "http://trith.org/stream/emptyp";

  public Boolean execute(Object obj) {
    if (obj instanceof Iterator) {
      return execute((Iterator)obj);
    }
    if (obj instanceof Iterable) {
      return execute(((Iterable)obj).iterator());
    }
    if (obj instanceof String) {
      return execute((String)obj);
    }
    return null; // FIXME
  }

  public Boolean execute(Iterator iter) {
    return Boolean.valueOf(!iter.hasNext());
  }

  public Boolean execute(String str) {
    return Boolean.valueOf(str.isEmpty());
  }
}
