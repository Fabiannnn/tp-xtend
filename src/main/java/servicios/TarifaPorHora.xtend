package servicios

import eventos.Evento
import excepciones.EventoException
import org.uqbar.commons.model.annotations.Observable

@Observable
class TarifaPorHora implements TipoDeTarifa {
	//public val tipoTarifa="Por Hora"
	override double costo(Servicio unServicio, Evento unEvento) {
		unServicio.costoPorHora * unEvento.duracion + unServicio.costoMinimo
	}

	override boolean validarTipoTarifa(Servicio unServicio) {
		if (!(unServicio.costoPorHora > 0)) {
			throw new EventoException("Falta establecer costo por hora")
		}
		return true
	}
		override String tipoTarifa(){
		"Por Hora"
	}
}
