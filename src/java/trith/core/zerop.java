package trith.core;
import  trith.lang.*;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/core/zerop
 */
public class zerop extends UnaryOperator<Boolean, BigDecimal> {
  public static final String URL = "http://trith.org/core/zerop";

  public Boolean execute(BigDecimal n) {
    return Boolean.valueOf(n.compareTo(BigDecimal.ZERO) == 0);
  }
}
