package trith.core;
import  trith.lang.*;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/core/stringp
 */
public class stringp extends UnaryOperator<Boolean, Object> {
  public static final String URL = "http://trith.org/core/stringp";

  public Boolean execute(Object x) {
    return Boolean.valueOf(x instanceof String);
  }
}
