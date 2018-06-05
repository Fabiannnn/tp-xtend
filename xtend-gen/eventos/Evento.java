package eventos;

import eventos.Locacion;
import eventos.Usuario;

/* @Accessors
 */public abstract class Evento {
  private /* String */Object nombre;
  
  private Usuario organizador;
  
  private /* LocalDateTime */Object fechaDeInicio;
  
  private /* LocalDateTime */Object fechaFinalizacion;
  
  private Locacion locacion;
  
  private /* LocalDate */Object fechaLimiteConfirmacion;
  
  private boolean cancelado = false;
  
  private boolean postergado = false;
  
  public abstract boolean esUnFracaso();
  
  public abstract int capacidadMaxima();
  
  public abstract void cancelarElEvento();
  
  public abstract boolean esExitoso();
  
  public abstract int cantidadAsistentes();
  
  public double duracion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field Duration is undefined"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nbetween cannot be resolved"
      + "\ngetSeconds cannot be resolved"
      + "\n/ cannot be resolved");
  }
  
  public double distancia(final /* Point */Object ubicacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method distancia(Point) from the type Locacion refers to the missing type Point");
  }
  
  public Object fechaAnteriorALaLimite() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field LocalDate is undefined"
      + "\nThe method or field LocalDate is undefined"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nnow cannot be resolved"
      + "\n<= cannot be resolved"
      + "\nfrom cannot be resolved");
  }
  
  public void postergarElEvento(final /* LocalDateTime */Object nuevaFechaHoraInicio) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method cambiarFechasEvento(LocalDateTime) from the type Evento refers to the missing type Object");
  }
  
  public Object cambiarFechasEvento(final /* LocalDateTime */Object nuevaFechaHoraInicio) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method calcularDiferenciaTiempo(LocalDateTime) from the type Evento refers to the missing type Object"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nCannot cast from Object to int"
      + "\nplusHours cannot be resolved"
      + "\nplusHours cannot be resolved"
      + "\nplusDays cannot be resolved"
      + "\n/ cannot be resolved");
  }
  
  public Object calcularDiferenciaTiempo(final /* LocalDateTime */Object nuevaFechaHoraInicio) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field Duration is undefined"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nbetween cannot be resolved"
      + "\ntoHours cannot be resolved");
  }
  
  public boolean validarDatosEvento() {
    throw new Error("Unresolved compilation problems:"
      + "\n&& cannot be resolved.");
  }
  
  public boolean validarFechas() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field LocalDate is undefined"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\n< cannot be resolved"
      + "\nfrom cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n< cannot be resolved"
      + "\n! cannot be resolved");
  }
  
  public boolean validarDatosCompletos() {
    throw new Error("Unresolved compilation problems:"
      + "\n=== cannot be resolved."
      + "\nThe field Evento.nombre refers to the missing type String"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nnullOrEmpty cannot be resolved"
      + "\n|| cannot be resolved"
      + "\n=== cannot be resolved"
      + "\n|| cannot be resolved"
      + "\n=== cannot be resolved"
      + "\n|| cannot be resolved"
      + "\n=== cannot be resolved"
      + "\n|| cannot be resolved");
  }
  
  public String toString() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Evento.nombre refers to the missing type String");
  }
}
