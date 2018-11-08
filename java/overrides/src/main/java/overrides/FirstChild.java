package overrides;

public class FirstChild implements Parent {
  @Override
  public void apply(Handler handler) {
    handler.handle(this);
  }
}
