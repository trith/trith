package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;
import  java.math.BigInteger;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/math/mod
 */
public class mod extends BinaryOperator<BigDecimal> {
  public static final String URL = "http://trith.org/math/mod";

  public BigDecimal execute(BigDecimal a, BigDecimal b) {
    return new BigDecimal(a.toBigIntegerExact().mod(b.toBigIntegerExact()));
  }
}
