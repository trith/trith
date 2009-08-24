package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

public class div extends Operator {
  public static void execute(Machine vm) {
    BigDecimal operand = (BigDecimal)vm.pop();
    vm.push(
      ((BigDecimal)vm.pop()).divide(operand)
    );
  }
}