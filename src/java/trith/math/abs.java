package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/abs
 */
public class abs extends UnaryOperator<BigDecimal, BigDecimal> {
  public static final String URL = "http://trith.org/math/abs";

  public BigDecimal execute(BigDecimal n) {
    return n.abs();
  }
}
