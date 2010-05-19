package trith.core;
import  trith.lang.*;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/core/nump
 */
public class nump extends UnaryOperator<Boolean, Object> {
  public static final String URL = "http://trith.org/core/nump";

  public Boolean execute(Object n) {
    return Boolean.valueOf(n instanceof java.lang.Number);
  }
}
