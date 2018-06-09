package servicios

import eventos.Evento
import excepciones.EventoException

class TarifaPorHora implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
		unServicio.costoPorHora * unEvento.duracion + unServicio.costoMinimo
	}

	override boolean validarTipoTarifa(Servicio unServicio) {
		if (!(unServicio.costoPorHora > 0)) {
			throw new EventoException("Falta establecer costo por hora")
		}
		return true
	}
}