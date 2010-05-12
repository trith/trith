package trith.core;
import  trith.lang.*;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/core/nil
 */
public class nil extends NullaryOperator<Object> {
  public static final String URL = "http://trith.org/core/nil";

  public Object execute() {
    return null;
  }
}
