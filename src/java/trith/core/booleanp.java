package trith.core;
import  trith.lang.*;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/core/booleanp
 */
public class booleanp extends UnaryOperator<Boolean, Object> {
  public static final String URL = "http://trith.org/core/booleanp";

  public Boolean execute(Object x) {
    return Boolean.valueOf(x instanceof Boolean);
  }
}
