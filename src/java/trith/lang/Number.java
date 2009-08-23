package trith.lang;
import  java.math.BigDecimal;
import  java.math.BigInteger;

public class Number {
  public static BigDecimal valueOf(BigDecimal value) {
    return value;
  }

  public static BigDecimal valueOf(BigInteger value) {
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
