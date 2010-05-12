package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;
import  java.util.Collection;
import  java.util.LinkedList;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/cons
 */
public class cons extends BinaryOperator<Object, Object, Object> {
  public static final String URL = "http://trith.org/stream/cons";

  public Object execute(Object a, Object b) {
    if (b instanceof Collection) {
      return execute(a, (Collection)b);
    }
    if (b instanceof Iterator) {
      return execute(a, (Iterator)b);
    }
    if (b instanceof Iterable) {
      return execute(a, ((Iterable)b).iterator());
    }
    if (b instanceof String) {
      return execute(a, (String)b);
    }
    return null; // FIXME
  }

  public Object execute(Object first, Collection rest) {
    // TODO: this should work lazily
    LinkedList result = new LinkedList(rest);
    result.addFirst(first);
    return result;
  }

  public Object execute(Object first, Iterator rest) {
    // TODO: this should work lazily
    LinkedList result = new LinkedList();
    result.addFirst(first);
    while (rest.hasNext()) {
      result.addLast(rest.next());
    }
    return result;
  }

  public Object execute(Object first, String rest) {
    if (!(first instanceof Character)) {
      // TODO: should we throw an error?
    }
    return first.toString().concat(rest);
  }
}
