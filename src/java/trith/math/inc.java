package trith.math;
import  trith.lang.*;
import  trith.lang.Number;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/inc
 */
public class inc extends UnaryOperator<BigDecimal, BigDecimal> {
  public static final String URL = "http://trith.org/math/inc";

  public BigDecimal execute(BigDecimal n) {
    return n.add(Number.ONE);
  }
}
