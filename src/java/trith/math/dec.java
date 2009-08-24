package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

public class dec extends Operator {
  public static void execute(Machine vm) {
    vm.push(
      ((BigDecimal)vm.pop()).subtract(BigDecimal.ONE)
    );
  }
}
