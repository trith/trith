package trith.stream;
import  trith.lang.*;
import  java.util.Iterator;
import  java.util.Collection;
import  java.util.List;
import  java.util.LinkedList;
import  java.util.ArrayList;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/cons
 */
public class cons extends BinaryOperator<Object, Object, Object> {
  public static final String URL = "http://trith.org/stream/cons";

  public Object execute(Object a, Object b) {
    if (b instanceof String) {
      return execute(a, (String)b);
    }
    if (b instanceof List) {
      return execute(a, (List)b);
    }
    if (b instanceof Collection) {
      return execute(a, (Collection)b);
    }
    if (b instanceof Iterator) {
      return execute(a, (Iterator)b);
    }
    if (b instanceof Iterable) {
      return execute(a, (Iterable)b);
    }
    return null; // FIXME
  }

  public Object execute(Object first, String rest) {
    if (!(first instanceof Character)) {
      // TODO: should we throw an error?
    }
    return first.toString().concat(rest);
  }

  public Object execute(Object first, List rest) {
    if (rest instanceof LinkedList) {
      LinkedList result = (LinkedList)((LinkedList)rest).clone();
      result.addFirst(first);
      return result;
    }
    if (rest instanceof ArrayList) {
      ArrayList result = (ArrayList)((ArrayList)rest).clone();
      result.add(0, first);
      return result;
    }
    else {
      // Object#clone is protected in classes we don't explicitly know
      // about, so we'll have to fall back to the Collection interface:
      return execute(first, (Collection)rest);
    }
  }

  public Object execute(Object first, Collection rest) {
    // TODO: this should work lazily
    LinkedList result = new LinkedList(rest);
    result.addFirst(first);
    return result;
  }

  public Object execute(Object first, Iterator rest) {
    // FIXME: this should work lazily
    LinkedList result = new LinkedList();
    result.addFirst(first);
    while (rest.hasNext()) {
      result.addLast(rest.next());
    }
    return result;
  }

  public Object execute(Object first, Iterable rest) {
    return execute(first, rest.iterator());
  }
}
