package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/max
 */
public class max extends BinaryOperator<BigDecimal, BigDecimal, BigDecimal> {
  public static final String URL = "http://trith.org/math/max";

  public BigDecimal execute(BigDecimal a, BigDecimal b) {
    return a.max(b);
  }
}
