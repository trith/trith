package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

public class add extends Operator {
  public static void execute(Machine vm) {
    vm.push(
      ((BigDecimal)vm.pop()).add((BigDecimal)vm.pop())
    );
  }
}
