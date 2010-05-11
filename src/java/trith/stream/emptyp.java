package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/emptyp
 */
public class emptyp extends UnaryStreamOperator<Boolean, Object> {
  public static final String URL = "http://trith.org/stream/emptyp";

  public Boolean execute(Iterator iter) {
    return Boolean.valueOf(!iter.hasNext());
  }

  public Boolean execute(String str) {
    return Boolean.valueOf(str.isEmpty());
  }
}
