package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/mul
 */
public class mul extends BinaryOperator<BigDecimal, BigDecimal, BigDecimal> {
  public static final String URL = "http://trith.org/math/mul";

  public BigDecimal execute(BigDecimal a, BigDecimal b) {
    return a.multiply(b);
  }
}
