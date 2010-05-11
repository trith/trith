package trith.stream;
import  trith.lang.*;
import  trith.lang.Number;
import  java.math.BigDecimal;
import  java.util.Iterator;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/length
 */
public class length extends UnaryStreamOperator<BigDecimal, Object> {
  public static final String URL = "http://trith.org/stream/length";

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
