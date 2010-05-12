package trith.lang;
import  java.util.concurrent.Executors;

/**
 * @author Arto Bendiken
 */
public class SequentialMachine extends AbstractMachine {
  public SequentialMachine() {
    super(Executors.newSingleThreadExecutor());
  }
}
