package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/pow
 */
public class pow extends BinaryOperator<BigDecimal> {
  public static final String URL = "http://trith.org/math/pow";

  public BigDecimal execute(BigDecimal a, BigDecimal b) {
    return a.pow(b.intValue()); // FIXME
  }
}
