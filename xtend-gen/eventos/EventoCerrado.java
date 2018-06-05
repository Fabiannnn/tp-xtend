package eventos;

import eventos.Evento;
import eventos.Invitacion;
import eventos.Usuario;

/* @Accessors
 */public class EventoCerrado extends Evento {
  private final static double COEF_EXITO = 0.9;
  
  private /* Set<Invitacion> */Object invitados /* Skipped initializer because of errors */;
  
  private int capacidadMaxima = 0;
  
  public void crearInvitacion(final Usuario elInvitado, final int unaCantidadDeAcompanantes) {
    throw new Error("Unresolved compilation problems:"
      + "\n&& cannot be resolved."
      + "\n+ cannot be resolved."
      + "\nThe method fechaAnteriorALaLimite() from the type Evento refers to the missing type Object"
      + "\nThe method registrarInvitacionEnEvento(Invitacion) from the type EventoCerrado refers to the missing type Object"
      + "\nThe method registrarInvitacionEnUsuario(Invitacion, Usuario) from the type EventoCerrado refers to the missing type Object"
      + "\nThe constructor EventoException(String) refers to the missing type String");
  }
  
  public Object getInvitadosDelEvento() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field unUsuario is undefined"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nmap cannot be resolved"
      + "\ntoList cannot be resolved");
  }
  
  public boolean hayCapacidadDisponible(final int unaCantidadTotal) {
    throw new Error("Unresolved compilation problems:"
      + "\n<= cannot be resolved."
      + "\n- cannot be resolved.");
  }
  
  public Object registrarInvitacionEnEvento(final Invitacion nuevaInvitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nadd cannot be resolved");
  }
  
  public Object registrarInvitacionEnUsuario(final Invitacion nuevaInvitacion, final Usuario elInvitado) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method recibirInvitacion(Invitacion) from the type Usuario refers to the missing type Object");
  }
  
  public int cantidadAsistentes() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nfold cannot be resolved"
      + "\n+ cannot be resolved"
      + "\nposiblesAsistentes cannot be resolved");
  }
  
  public int cantidadDeInvitaciones() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nsize cannot be resolved");
  }
  
  public void cancelarElEvento() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field cancelado is not visible"
      + "\nThe method notificarAInvitadosCancelacion() from the type EventoCerrado refers to the missing type Object");
  }
  
  public int capacidadMaxima() {
    return this.capacidadMaxima;
  }
  
  public Object notificarAInvitadosCancelacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\naceptada cannot be resolved"
      + "\n!= cannot be resolved"
      + "\nforall cannot be resolved"
      + "\nnotificacionDeCancelacion cannot be resolved");
  }
  
  public void postergarElEvento(final /* LocalDateTime */Object nuevaFechaHoraInicio) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field fechaDeInicio is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe field fechaLimiteConfirmacion is not visible"
      + "\nThe method postergarElEvento(LocalDateTime) from the type Evento refers to the missing type LocalDateTime"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nforall cannot be resolved"
      + "\nNotificacionDePostergacion cannot be resolved");
  }
  
  public boolean esExitoso() {
    throw new Error("Unresolved compilation problems:"
      + "\n! cannot be resolved."
      + "\nThe field cancelado is not visible"
      + "\nThe method asistenciaExitosa() from the type EventoCerrado refers to the missing type Object"
      + "\n&& cannot be resolved");
  }
  
  public Object asistenciaExitosa() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\naceptada cannot be resolved"
      + "\n=== cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n/ cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n>= cannot be resolved");
  }
  
  public boolean esUnFracaso() {
    throw new Error("Unresolved compilation problems:"
      + "\n! cannot be resolved."
      + "\nThe method or field LocalDateTime is undefined"
      + "\nThe field cancelado is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe method asistenciaFracaso() from the type EventoCerrado refers to the missing type Object"
      + "\n&& cannot be resolved"
      + "\nnow cannot be resolved"
      + "\nisAfter cannot be resolved"
      + "\n&& cannot be resolved");
  }
  
  public Object asistenciaFracaso() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\naceptada cannot be resolved"
      + "\n!== cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n/ cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n< cannot be resolved");
  }
}
