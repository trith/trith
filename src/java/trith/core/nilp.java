package trith.core;
import  trith.lang.*;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/core/nilp
 */
public class nilp extends UnaryOperator<Boolean, Object> {
  public static final String URL = "http://trith.org/core/nilp";

  public Boolean execute(Object x) {
    return Boolean.valueOf(x == null);
  }
}
