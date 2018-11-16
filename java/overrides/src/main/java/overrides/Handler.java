package overrides;

public interface Handler {
  public void handle(Parent p);
  public void handle(DefaultChild p);
  public void handle(FirstChild p);
  public void handle(SecondChild p);
}
