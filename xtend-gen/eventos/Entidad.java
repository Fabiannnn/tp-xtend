package eventos;

public interface Entidad {
  public abstract void esValido();
  
  public abstract int getId();
  
  public abstract void agregarId(final int _nextId);
  
  public abstract boolean filtroPorTexto(final /* String */Object cadena);
}
