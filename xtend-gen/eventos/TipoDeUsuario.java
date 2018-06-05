package eventos;

import eventos.EventoAbierto;
import eventos.EventoCerrado;
import eventos.Usuario;

public interface TipoDeUsuario {
  public abstract boolean puedoOrganizarElEventoAbierto(final Usuario unOrganizador, final EventoAbierto unEventoAbierto);
  
  public abstract boolean puedoOrganizarElEventoCerrado(final Usuario unOrganizador, final EventoCerrado unEventoCerrado);
  
  public abstract boolean puedePostergarEventos();
  
  public abstract boolean puedeCancelarEventos();
  
  public abstract boolean sePuedeEntregarInvitacion(final EventoCerrado unEvento);
}
