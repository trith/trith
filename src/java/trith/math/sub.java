package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/sub
 */
public class sub extends BinaryOperator<BigDecimal> {
  public static final String URL = "http://trith.org/math/sub";

  public BigDecimal execute(BigDecimal a, BigDecimal b) {
    return a.subtract(b);
  }
}
