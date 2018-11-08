package overrides;

import static java.lang.System.out;

public class Main {
  public static void main(String[] args) {
    Parent[] children = new Parent[]{
      new DefaultChild(),
      new FirstChild(),
      new SecondChild()
    };

    ChildHandler handler = new ChildHandler();
    out.println("children handling with apply:");
    for (Parent child : children) {
      out.printf("%s: ", child.getClass().getName());
      child.apply(handler);
    }
    out.println("children handling with handle:");
    for (Parent child : children) {
      out.printf("%s: ", child.getClass().getName());
      handler.handle(child);
    }
  }
}
