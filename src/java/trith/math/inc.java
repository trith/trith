package trith.math;
import  trith.lang.*;
import  trith.lang.Number;
import  java.math.BigDecimal;

public class inc extends Operator {
  public static void execute(Machine vm) {
    vm.push(
      ((BigDecimal)vm.pop()).add(Number.ONE)
    );
  }
}
