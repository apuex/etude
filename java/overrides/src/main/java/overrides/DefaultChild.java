package overrides;

public class DefaultChild implements Parent {
  @Override
  public void apply(Handler handler) {
    handler.handle(this);
  }
}
