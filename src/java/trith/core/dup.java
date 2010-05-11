package trith.core;
import  trith.lang.*;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/core/dup
 */
public class dup implements Operator {
  public static final String URL = "http://trith.org/core/dup";

  public void execute(Machine machine) {
    machine.push(machine.peek());
  }
}
