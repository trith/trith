package trith.lang;

class Symbol {
  public final String name;

  public static Symbol intern(String name) {
    return new Symbol(name);
  }

  public static Symbol valueOf(String name) {
    return new Symbol(name);
  }

  public static Symbol valueOf(char name) {
    return new Symbol(name);
  }

  public Symbol(String name) {
    this.name = name.intern();
  }

  public Symbol(char name) {
    this.name = String.valueOf(name).intern();
  }

  public String toString() {
    return name;
  }
}
