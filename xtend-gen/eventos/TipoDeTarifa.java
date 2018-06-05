package eventos;

import eventos.Evento;
import eventos.Servicio;

public interface TipoDeTarifa {
  public abstract double costo(final Servicio unServicio, final Evento unEvento);
  
  public abstract boolean validarTipoTarifa(final Servicio unservicio);
}
