package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;
import  java.util.Collections;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/rest
 */
public class rest extends UnaryStreamOperator<Object, Object> {
  public static final String URL = "http://trith.org/stream/rest";

  public Object execute(Iterator iter) {
    if (!iter.hasNext()) {
      return Collections.EMPTY_LIST;
    }
    else {
      iter.next();
      return iter;
    }
  }

  public Object execute(String str) {
    if (str.isEmpty()) {
      return Collections.EMPTY_LIST;
    }
    else {
      return str.substring(1);
    }
  }
}
