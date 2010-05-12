package trith.stream;
import  trith.lang.*;
import  java.util.concurrent.Future;
import  java.util.concurrent.ExecutionException;
import  java.util.Iterator;
import  java.util.Collection;
import  java.util.List;
import  java.math.BigDecimal;

/**
 * @author Arto Bendiken
 * @see    http://trith.org/stream/nth
 */
public class nth implements Operator {
  public static final String URL = "http://trith.org/stream/nth";

  public void execute(final Machine machine) {
    final Future<BigDecimal> a = machine.pop();

    machine.unshift(new UnaryStreamOperator<Object, Object>() {
      public int getIndex() {
        try {
          return a.get().intValue();
        }
        catch (InterruptedException e) {
          e.printStackTrace(); // FIXME
        }
        catch (ExecutionException e) {
          e.printStackTrace(); // FIXME
        }
        return -1; // FIXME
      }

      public Object execute(String str) {
        return str.charAt(getIndex());
      }

      public Object execute(List list) {
        return list.get(getIndex());
      }

      public Object execute(Iterator iter) {
        int index      = getIndex();
        int position   = 0;
        while (iter.hasNext()) {
          Object element = iter.next();
          if (index == position++) {
            return element;
          }
        }
        throw new ArrayIndexOutOfBoundsException(index);
      }
    });
  }
}
