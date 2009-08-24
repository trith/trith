package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

public class mul extends Operator {
  public static void execute(Machine vm) {
    vm.push(
      ((BigDecimal)vm.pop()).multiply((BigDecimal)vm.pop())
    );
  }
}
