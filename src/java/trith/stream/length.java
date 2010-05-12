package trith.stream;
import  trith.lang.*;
import  trith.lang.Number;
import  java.math.BigDecimal;
import  java.util.Iterator;
import  java.util.Collection;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/length
 */
public class length extends UnaryStreamOperator<BigDecimal, Object> {
  public static final String URL = "http://trith.org/stream/length";

  /**
   * @see http://java.sun.com/javase/6/docs/api/java/lang/Character.html#unicode
   */
  public BigDecimal execute(String str) {
    //return Number.valueOf(str.codePointCount(0, str.length())); // TODO
    return Number.valueOf(str.length());
  }

  public BigDecimal execute(Collection coll) {
    return Number.valueOf(coll.size());
  }

  public BigDecimal execute(Iterator iter) {
    long length = 0;
    while (iter.hasNext()) {
      length++;
      iter.next();
    }
    return Number.valueOf(length);
  }
}
