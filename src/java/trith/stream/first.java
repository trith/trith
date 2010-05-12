package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;
import  java.util.List;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/first
 */
public class first extends UnaryStreamOperator<Object, Object> {
  public static final String URL = "http://trith.org/stream/first";

  public Object execute(String str) {
    if (str.isEmpty()) {
      return null;
    }
    else {
      return Character.valueOf(str.charAt(0));
    }
  }

  public Object execute(List list) {
    if (list.isEmpty()) {
      return null;
    }
    else {
      return list.get(0);
    }
  }

  public Object execute(Iterator iter) {
    if (!iter.hasNext()) {
      return null;
    }
    else {
      return iter.next();
    }
  }
}
