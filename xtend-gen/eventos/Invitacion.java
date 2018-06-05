package eventos;

import eventos.EventoCerrado;
import eventos.Locacion;
import eventos.Usuario;

/* @Accessors
 */public class Invitacion {
  private EventoCerrado unEventoCerrado;
  
  private Usuario unUsuario;
  
  private int cantidadDeAcompanantes;
  
  private /* Boolean */Object aceptada = null;
  
  private int cantidadDeAcompanantesConfirmados = 0;
  
  public Invitacion(final EventoCerrado elEventoCerrado, final Usuario elUsuario, final int laCantidadDeAcompanantes) {
    this.unEventoCerrado = elEventoCerrado;
    this.unUsuario = elUsuario;
    this.cantidadDeAcompanantes = laCantidadDeAcompanantes;
  }
  
  public Boolean rechazar() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Invitacion.aceptada refers to the missing type Boolean");
  }
  
  public boolean fechaParaConfirmar() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method fechaAnteriorALaLimite() from the type Evento refers to the missing type Object");
  }
  
  public int aceptar(final int unaCantidadDeAcompanantes) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Invitacion.aceptada refers to the missing type Boolean");
  }
  
  public Object posiblesAsistentes() {
    throw new Error("Unresolved compilation problems:"
      + "\n+ cannot be resolved."
      + "\n+ cannot be resolved."
      + "\nThe field Invitacion.aceptada refers to the missing type Boolean"
      + "\nThe field Invitacion.aceptada refers to the missing type Boolean"
      + "\nThe field Invitacion.aceptada refers to the missing type Boolean"
      + "\n=== cannot be resolved"
      + "\n=== cannot be resolved"
      + "\n=== cannot be resolved");
  }
  
  public Locacion ubicacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field locacion is not visible");
  }
  
  public boolean notificacionDeCancelacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method agregarMensaje(String) from the type Usuario refers to the missing type Object"
      + "\nThe field Invitacion.aceptada refers to the missing type Boolean"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved");
  }
  
  public Object NotificacionDePostergacion(final /* LocalDateTime */Object nuevaFechaInicio, final /* LocalDateTime */Object nuevaFechaFinalizacion, final /* LocalDate */Object NuevaFechaLimiteConfirmacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method agregarMensaje(String) from the type Usuario refers to the missing type Object"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved");
  }
}
