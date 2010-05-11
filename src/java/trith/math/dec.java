package trith.math;
import  trith.lang.*;
import  trith.lang.Number;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/dec
 */
public class dec extends UnaryOperator<BigDecimal, BigDecimal> {
  public static final String URL = "http://trith.org/math/dec";

  public BigDecimal execute(BigDecimal n) {
    return n.subtract(Number.ONE);
  }
}
