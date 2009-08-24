package trith.math;
import  trith.lang.*;
import  java.math.BigDecimal;

public class neg extends Operator {
  public static void execute(Machine vm) {
    vm.push(
      ((BigDecimal)vm.pop()).negate()
    );
  }
}
