package trith.lang;
import  java.util.concurrent.ExecutorService;
import  java.util.concurrent.Future;

/**
 * @author Arto Bendiken
 */
public class StandardMachine extends AbstractMachine {
  protected final AbstractMachine machine;

  protected ExecutorService getExecutor() {
    return machine.getExecutor();
  }

  public StandardMachine() {
    this(new SequentialMachine());
  }

  public StandardMachine(int concurrencyLevel) {
    this(new ParallelMachine(concurrencyLevel));
  }

  public StandardMachine(AbstractMachine machine) {
    this.machine = machine;
  }

  public <T> Future<T> peek() {
    return machine.peek();
  }

  public <T> Future<T> pop() {
    return machine.pop();
  }

  public void push(Future<?> value) {
    machine.push(value);
  }

  /**
   * @see trith.core.dup
   */
  public void dup() {
    execute(new trith.core.dup());
  }

  /**
   * @see trith.core.nilp
   */
  public void nilp() {
    execute(new trith.core.nilp());
  }

  /**
   * @see trith.core.nil
   */
  public void nil() {
    execute(new trith.core.nil());
  }

  /**
   * @see trith.core.falsep
   */
  public void falsep() {
    execute(new trith.core.falsep());
  }

  /**
   * @see trith.core.truep
   */
  public void truep() {
    execute(new trith.core.truep());
  }

  /**
   * @see trith.core.stringp
   */
  public void stringp() {
    execute(new trith.core.stringp());
  }

  /**
   * @see trith.core.numberp
   */
  public void numberp() {
    execute(new trith.core.numberp());
  }

  /**
   * @see trith.core.zerop
   */
  public void zerop() {
    execute(new trith.core.zerop());
  }

  /*
   * @see trith.math.abs
   */
  public void abs() {
    execute(new trith.math.abs());
  }

  /*
   * @see trith.math.min
   */
  public void min() {
    execute(new trith.math.min());
  }

  /*
   * @see trith.math.max
   */
  public void max() {
    execute(new trith.math.max());
  }

  /*
   * @see trith.math.neg
   */
  public void neg() {
    execute(new trith.math.neg());
  }

  /*
   * @see trith.math.inc
   */
  public void inc() {
    execute(new trith.math.inc());
  }

  /*
   * @see trith.math.dec
   */
  public void dec() {
    execute(new trith.math.dec());
  }

  /*
   * @see trith.math.add
   */
  public void add() {
    execute(new trith.math.add());
  }

  /*
   * @see trith.math.sub
   */
  public void sub() {
    execute(new trith.math.sub());
  }

  /*
   * @see trith.math.mul
   */
  public void mul() {
    execute(new trith.math.mul());
  }

  /*
   * @see trith.math.div
   */
  public void div() {
    execute(new trith.math.div());
  }

  /*
   * @see trith.math.rem
   */
  public void rem() {
    execute(new trith.math.rem());
  }

  /*
   * @see trith.math.mod
   */
  public void mod() {
    execute(new trith.math.mod());
  }

  /*
   * @see trith.math.pow
   */
  public void pow() {
    execute(new trith.math.pow());
  }

  /*
   * @see trith.stream.emptyp
   */
  public void emptyp() {
    execute(new trith.stream.emptyp());
  }

  /*
   * @see trith.stream.length
   */
  public void length() {
    execute(new trith.stream.length());
  }

  /*
   * @see trith.stream.first
   */
  public void first() {
    execute(new trith.stream.first());
  }

  /*
   * @see trith.stream.rest
   */
  public void rest() {
    execute(new trith.stream.rest());
  }

  /*
   * @see trith.stream.last
   */
  public void last() {
    execute(new trith.stream.last());
  }

  /*
   * @see trith.stream.cons
   */
  public void cons() {
    execute(new trith.stream.cons());
  }
}
