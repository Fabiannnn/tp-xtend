package eventos;

import eventos.EventoAbierto;
import eventos.EventoCerrado;
import eventos.TipoDeUsuario;
import eventos.Usuario;

/* @Accessors
 */public class UsuarioFree implements TipoDeUsuario {
  private final int limiteEventosSimultaneos = 1;
  
  private final int maximoPersonasPorEventoCerrado = 50;
  
  private final int cantidadMaximaEventosMensuales = 3;
  
  public boolean puedoOrganizarElEventoAbierto(final Usuario unOrganizador, final EventoAbierto unEventoAbierto) {
    return false;
  }
  
  public boolean puedePostergarEventos() {
    return false;
  }
  
  public boolean puedeCancelarEventos() {
    return false;
  }
  
  public boolean puedoOrganizarElEventoCerrado(final Usuario unOrganizador, final EventoCerrado unEventoCerrado) {
    throw new Error("Unresolved compilation problems:"
      + "\n&& cannot be resolved."
      + "\nThe field fechaDeInicio is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe method noSuperaLimiteMensualDeEventos(Usuario, LocalDateTime, LocalDateTime) from the type UsuarioFree refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\n&& cannot be resolved");
  }
  
  public boolean sePuedeEntregarInvitacion(final EventoCerrado unEvento) {
    return true;
  }
  
  public boolean noSuperaElLimiteDeEventosSimultaneos(final Usuario unUsuario) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field LocalDateTime is undefined"
      + "\nThe field eventosOrganizados is not visible"
      + "\nThe field Usuario.eventosOrganizados refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\nfechaFinalizacion cannot be resolved"
      + "\n> cannot be resolved"
      + "\nnow cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n< cannot be resolved");
  }
  
  public boolean noSuperaCapacidadTipoUsuario(final int unaCapacidadTotal) {
    throw new Error("Unresolved compilation problems:"
      + "\n<= cannot be resolved.");
  }
  
  public boolean noSuperaLimiteMensualDeEventos(final Usuario unUsuario, final /* LocalDateTime */Object unInicioEvento, final /* LocalDateTime */Object unaFinalizacionEvento) {
    throw new Error("Unresolved compilation problems:"
      + "\n&& cannot be resolved."
      + "\nThe method noSuperaElLimite(Usuario, LocalDateTime) from the type UsuarioFree refers to the missing type LocalDateTime"
      + "\nThe method noSuperaElLimite(Usuario, LocalDateTime) from the type UsuarioFree refers to the missing type LocalDateTime");
  }
  
  public boolean noSuperaElLimite(final Usuario unUsuario, final /* LocalDateTime */Object unaFecha) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field eventosOrganizados is not visible"
      + "\nThe field Usuario.eventosOrganizados refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\nfechaDeInicio cannot be resolved"
      + "\nmonth cannot be resolved"
      + "\n== cannot be resolved"
      + "\nmonth cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n< cannot be resolved");
  }
}
