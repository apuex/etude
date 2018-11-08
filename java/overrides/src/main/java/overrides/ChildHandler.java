package overrides;

import static java.lang.System.out;

public class ChildHandler implements Handler {
  @Override
  public void handle(Parent p) {
    out.println("Default => handle(Parent)");
  }

  @Override
  public void handle(DefaultChild p) {
    out.println("handle(DefaultChild)");
  }

  @Override
  public void handle(FirstChild p) {
    out.println("handle(FirstChild)");
  }

  @Override
  public void handle(SecondChild p) {
    out.println("handle(SecondChild)");
  }
}
