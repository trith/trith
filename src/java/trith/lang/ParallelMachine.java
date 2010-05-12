package trith.lang;
import  java.util.concurrent.Executors;

/**
 * @author Arto Bendiken
 */
public class ParallelMachine extends AbstractMachine {
  public ParallelMachine() {
    this(4); // TODO: figure out how many CPUs are available
  }

  public ParallelMachine(int threads) {
    super(Executors.newFixedThreadPool(threads));
  }
}
