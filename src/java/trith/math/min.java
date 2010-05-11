package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/min
 */
public class min extends BinaryOperator<BigDecimal, BigDecimal, BigDecimal> {
  public static final String URL = "http://trith.org/math/min";

  public BigDecimal execute(BigDecimal a, BigDecimal b) {
    return a.min(b);
  }
}
