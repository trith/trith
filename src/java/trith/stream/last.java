package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;
import  java.util.List;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/last
 */
public class last extends UnaryStreamOperator<Object, Object> {
  public static final String URL = "http://trith.org/stream/last";

  public Object execute(String str) {
    if (str.isEmpty()) {
      return null;
    }
    else {
      //return Character.valueOf(str.codePointBefore(str.length()));
      return Character.valueOf(str.charAt(str.length() - 1));
    }
  }

  public Object execute(List list) {
    if (list.isEmpty()) {
      return null;
    }
    else {
      return list.get(list.size() - 1);
    }
  }

  public Object execute(Iterator iter) {
    if (!iter.hasNext()) {
      return null;
    }
    else {
      Object element = null;
      while (iter.hasNext()) {
        element = iter.next();
      }
      return element;
    }
  }
}
