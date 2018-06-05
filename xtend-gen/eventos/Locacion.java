package eventos;

import eventos.Entidad;

/* @Accessors
 */public class Locacion implements Entidad {
  private /* String */Object nombre;
  
  private /* Point */Object punto;
  
  private double superficie;
  
  private final double personasPorMetroCuadrado = 0.8;
  
  private int id;
  
  public double distancia(final /* Point */Object otroPunto) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Locacion.punto refers to the missing type Point"
      + "\ndistance cannot be resolved");
  }
  
  public Object estaDentroDelRadioDeCercania(final /* Point */Object otroPunto, final double radioCercania) {
    throw new Error("Unresolved compilation problems:"
      + "\n<= cannot be resolved."
      + "\nThe method distancia(Point) from the type Locacion refers to the missing type Point");
  }
  
  public int capacidadMaxima() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field Math is undefined"
      + "\n* cannot be resolved."
      + "\nCannot cast from Object to int"
      + "\nfloor cannot be resolved");
  }
  
  public void esValido() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Locacion.nombre refers to the missing type String"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nThe field Locacion.punto refers to the missing type Point"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nnullOrEmpty cannot be resolved"
      + "\n=== cannot be resolved");
  }
  
  public int getId() {
    return this.id;
  }
  
  public void agregarId(final int _nextId) {
    this.id = _nextId;
  }
  
  public boolean filtroPorTexto(final /* String */Object cadena) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Locacion.nombre refers to the missing type String"
      + "\ncontains cannot be resolved");
  }
  
  public String toString() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Locacion.nombre refers to the missing type String");
  }
}
