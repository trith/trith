package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/div
 */
public class div extends BinaryOperator<BigDecimal> {
  public static final String URL = "http://trith.org/math/div";

  public BigDecimal execute(BigDecimal a, BigDecimal b) {
    return a.divide(b);
  }
}
