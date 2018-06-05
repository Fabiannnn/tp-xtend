package eventos;

import eventos.EventoAbierto;
import eventos.EventoCerrado;
import eventos.TipoDeUsuario;
import eventos.Usuario;

/* @Accessors
 */public class UsuarioProfesional implements TipoDeUsuario {
  private final int cantidadMaximaEventosMensuales = 20;
  
  public boolean puedoOrganizarElEventoAbierto(final Usuario unOrganizador, final EventoAbierto unEventoAbierto) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field fechaDeInicio is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe method noSuperaElLimiteDeEventosMensuales(Usuario, LocalDateTime, LocalDateTime) from the type UsuarioProfesional refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime");
  }
  
  public boolean puedePostergarEventos() {
    return true;
  }
  
  public boolean puedeCancelarEventos() {
    return true;
  }
  
  public boolean puedoOrganizarElEventoCerrado(final Usuario unOrganizador, final EventoCerrado unEventoCerrado) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field fechaDeInicio is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe method noSuperaElLimiteDeEventosMensuales(Usuario, LocalDateTime, LocalDateTime) from the type UsuarioProfesional refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime");
  }
  
  public boolean sePuedeEntregarInvitacion(final EventoCerrado unEvento) {
    return true;
  }
  
  public boolean noSuperaElLimiteDeEventosMensuales(final Usuario unUsuario, final /* LocalDateTime */Object unInicioEvento, final /* LocalDateTime */Object unaFinalizacionEvento) {
    throw new Error("Unresolved compilation problems:"
      + "\n&& cannot be resolved."
      + "\nThe method noSuperaElLimite(Usuario, LocalDateTime) from the type UsuarioProfesional refers to the missing type LocalDateTime"
      + "\nThe method noSuperaElLimite(Usuario, LocalDateTime) from the type UsuarioProfesional refers to the missing type LocalDateTime");
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
