package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/neg
 */
public class neg extends UnaryOperator<BigDecimal, BigDecimal> {
  public static final String URL = "http://trith.org/math/neg";

  public BigDecimal execute(BigDecimal n) {
    return n.negate();
  }
}
