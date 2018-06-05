package eventos;

import eventos.Evento;
import eventos.Servicio;
import eventos.TipoDeTarifa;

public class TarifaFija implements TipoDeTarifa {
  public double costo(final Servicio unServicio, final Evento unEvento) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field costoFijo is not visible");
  }
  
  public boolean validarTipoTarifa(final Servicio unServicio) {
    throw new Error("Unresolved compilation problems:"
      + "\n> cannot be resolved."
      + "\nThe field costoFijo is not visible"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\n! cannot be resolved");
  }
}
