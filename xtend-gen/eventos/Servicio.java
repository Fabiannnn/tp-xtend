package eventos;

import eventos.Entidad;
import eventos.Evento;
import eventos.TarifaFija;
import eventos.TarifaPorHora;
import eventos.TarifaPorPersona;
import eventos.TipoDeTarifa;

/* @Accessors
 */public class Servicio implements Entidad {
  private /* String */Object descripcion;
  
  private TipoDeTarifa tipoDeTarifa;
  
  private double costoFijo = 0;
  
  private double costoMinimo = 0;
  
  private double costoPorHora = 0;
  
  private double porcentajeCostoMinimo = 0;
  
  private double costoPorPersona = 0;
  
  private double costoPorKm = 0;
  
  private /* Point */Object ubicacion;
  
  private int id;
  
  public TipoDeTarifa setTarifaFija() {
    TarifaFija _tarifaFija = new TarifaFija();
    return this.tipoDeTarifa = _tarifaFija;
  }
  
  public double costoTotal(final Evento unEvento) {
    throw new Error("Unresolved compilation problems:"
      + "\n+ cannot be resolved.");
  }
  
  public double costoTraslado(final Evento unEvento) {
    throw new Error("Unresolved compilation problems:"
      + "\n* cannot be resolved."
      + "\nThe field locacion is not visible"
      + "\nThe method distancia(Point) from the type Locacion refers to the missing type Point"
      + "\nThe field Servicio.ubicacion refers to the missing type Point");
  }
  
  public void setTarifaPorHora() {
    TarifaPorHora _tarifaPorHora = new TarifaPorHora();
    this.tipoDeTarifa = _tarifaPorHora;
  }
  
  public void setTarifaPorPersona() {
    TarifaPorPersona _tarifaPorPersona = new TarifaPorPersona();
    this.tipoDeTarifa = _tarifaPorPersona;
  }
  
  public void esValido() {
    this.validarUbicacion();
    this.validarDescripcion();
    this.validarTarifa();
  }
  
  public void validarUbicacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Servicio.ubicacion refers to the missing type Point"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\n=== cannot be resolved");
  }
  
  public void validarDescripcion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Servicio.descripcion refers to the missing type String"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nnullOrEmpty cannot be resolved");
  }
  
  public boolean validarTarifa() {
    throw new Error("Unresolved compilation problems:"
      + "\n!== cannot be resolved."
      + "\nThe constructor EventoException(String) refers to the missing type String");
  }
  
  public int getId() {
    return this.id;
  }
  
  public void agregarId(final int _nextId) {
    this.id = _nextId;
  }
  
  public boolean filtroPorTexto(final /* String */Object cadena) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Servicio.descripcion refers to the missing type String"
      + "\nstartsWith cannot be resolved");
  }
}
