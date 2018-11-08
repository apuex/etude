package overrides;

public class SecondChild implements Parent {
  @Override
  public void apply(Handler handler) {
    handler.handle(this);
  }
}
