package trith.stream;
import  trith.lang.*;
import  trith.lang.Number;
import  java.math.BigDecimal;
import  java.util.Iterator;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/length
 */
public class length extends UnaryOperator<BigDecimal, Object> {
  public static final String URL = "http://trith.org/stream/length";

  public BigDecimal execute(Object obj) {
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

  public BigDecimal execute(Iterator iter) {
    long length = 0;
    while (iter.hasNext()) {
      length++;
      iter.next();
    }
    return Number.valueOf(length);
  }

  public BigDecimal execute(String str) {
    return Number.valueOf(str.length());
  }
}
