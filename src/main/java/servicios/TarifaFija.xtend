package servicios

import eventos.Evento
import excepciones.EventoException

class TarifaFija implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
		unServicio.costoFijo
	}

	override boolean validarTipoTarifa(Servicio unServicio) {
		if (!(unServicio.costoFijo > 0)) {
			throw new EventoException("Falta establecer costo fijo")
		}
		return true
	}
}
