package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;
import  java.math.BigInteger;

public class mod extends Operator {
  public static void execute(Machine vm) {
    BigInteger operand = ((BigDecimal)vm.pop()).toBigIntegerExact();
    vm.push(
      new BigDecimal(((BigDecimal)vm.pop()).toBigIntegerExact().mod(operand))
    );
  }
}
