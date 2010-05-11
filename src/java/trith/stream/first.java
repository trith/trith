package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/first
 */
public class first extends UnaryStreamOperator<Object, Object> {
  public static final String URL = "http://trith.org/stream/first";

  public Object execute(Iterator iter) {
    if (iter.hasNext()) {
      return iter.next();
    }
    return null; // FIXME
  }

  public Object execute(String str) {
    return Character.valueOf(str.charAt(0));
  }
}
