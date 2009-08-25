package trith.lang;
import  java.math.BigDecimal;
import  java.math.BigInteger;

public class Number {
  public static final BigDecimal ZERO  = BigDecimal.ZERO;
  public static final BigDecimal ONE   = BigDecimal.ONE;
  public static final BigDecimal TWO   = BigDecimal.valueOf(2);
  public static final BigDecimal THREE = BigDecimal.valueOf(3);
  public static final BigDecimal FOUR  = BigDecimal.valueOf(4);
  public static final BigDecimal FIVE  = BigDecimal.valueOf(5);
  public static final BigDecimal SIX   = BigDecimal.valueOf(6);
  public static final BigDecimal SEVEN = BigDecimal.valueOf(7);
  public static final BigDecimal EIGHT = BigDecimal.valueOf(8);
  public static final BigDecimal NINE  = BigDecimal.valueOf(9);
  public static final BigDecimal TEN   = BigDecimal.TEN;

  public static BigDecimal valueOf(BigDecimal value) {
    return value;
  }

  public static BigDecimal valueOf(BigInteger value) {
    return new BigDecimal(value);
  }

  public static BigDecimal valueOf(String value) {
    return new BigDecimal(value);
  }

  public static BigDecimal valueOf(byte value) {
    return BigDecimal.valueOf(value);
  }

  public static BigDecimal valueOf(short value) {
    return BigDecimal.valueOf(value);
  }

  public static BigDecimal valueOf(int value) {
    return BigDecimal.valueOf(value);
  }

  public static BigDecimal valueOf(long value) {
    return BigDecimal.valueOf(value);
  }

  public static BigDecimal valueOf(float value) {
    return BigDecimal.valueOf(value);
  }

  public static BigDecimal valueOf(double value) {
    return BigDecimal.valueOf(value);
  }
}
