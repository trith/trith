package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;
import  java.util.Collection;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/emptyp
 */
public class emptyp extends UnaryStreamOperator<Boolean, Object> {
  public static final String URL = "http://trith.org/stream/emptyp";

  public Boolean execute(String str) {
    return Boolean.valueOf(str.isEmpty());
  }

  public Boolean execute(Collection coll) {
    return Boolean.valueOf(coll.isEmpty());
  }

  public Boolean execute(Iterator iter) {
    return Boolean.valueOf(!iter.hasNext());
  }
}
