package eventos;

import eventos.EventoAbierto;
import eventos.EventoCerrado;
import eventos.TipoDeUsuario;
import eventos.Usuario;

/* @Accessors
 */public class UsuarioAmateur implements TipoDeUsuario {
  private final int limiteEventosSimultaneos = 5;
  
  private final int maximoInvitacionesEventoCerrado = 50;
  
  private boolean puedoOrganizarElEventoAbierto = true;
  
  public boolean puedoOrganizarElEventoAbierto(final Usuario unOrganizador, final EventoAbierto unEventoAbierto) {
    throw new Error("Unresolved compilation problems:"
      + "\n&& cannot be resolved.");
  }
  
  public boolean puedePostergarEventos() {
    return true;
  }
  
  public boolean puedeCancelarEventos() {
    return true;
  }
  
  public boolean puedoOrganizarElEventoCerrado(final Usuario unOrganizador, final EventoCerrado unEventoCerrado) {
    return this.noSuperaElLimiteDeEventosSimultaneos(unOrganizador);
  }
  
  public boolean sePuedeEntregarInvitacion(final EventoCerrado unEventoCerrado) {
    throw new Error("Unresolved compilation problems:"
      + "\n< cannot be resolved.");
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
}
