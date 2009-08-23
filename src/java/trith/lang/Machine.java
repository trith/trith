package trith.lang;
import  java.util.Stack;
import  java.util.EmptyStackException;

public class Machine {
  public final Stack stack = new Stack();
  public final Stack queue = new Stack();

  public Object peek() {
    try {
      return stack.peek();
    }
    catch (EmptyStackException e) {
      return null;
    }
  }

  public Object pop() {
    try {
      return stack.pop();
    }
    catch (EmptyStackException e) {
      throw new StackUnderflowError();
    }
  }

  public void push(Object value) {
    stack.push(value);
  }

  public void push(boolean value) {
    stack.push(Boolean.valueOf(value));
  }

  public void push(char value) {
    stack.push(String.valueOf(value));
  }

  public void push(byte value) {
    stack.push(Number.valueOf(value));
  }

  public void push(short value) {
    stack.push(Number.valueOf(value));
  }

  public void push(int value) {
    stack.push(Number.valueOf(value));
  }

  public void push(long value) {
    stack.push(Number.valueOf(value));
  }

  public void push(float value) {
    stack.push(Number.valueOf(value));
  }

  public void push(double value) {
    stack.push(Number.valueOf(value));
  }

  public void execute(Operator op) {
    op.execute(this);
  }

  public void execute(String op) {
    // TODO
  }
}
