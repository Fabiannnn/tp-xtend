package servicios

import eventos.Evento
import excepciones.EventoException
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Observable
class TarifaPorPersona implements TipoDeTarifa {
//	public val tipoTarifa="Por Persona"
	override double costo(Servicio unServicio, Evento unEvento) {
		Math.max((costoBasePorCapacidad(unServicio, unEvento)), (unEvento.cantidadAsistentes() *
			unServicio.costoPorPersona ))
	}

	override boolean validarTipoTarifa(Servicio unServicio) {
		if (!(unServicio.costoPorPersona > 0)) {
			throw new EventoException("Falta establecer costo por persona")
		}
		return true
	}

	def double costoBasePorCapacidad(Servicio unServicio, Evento unEvento) {
		Math.round(unEvento.capacidadMaxima() * unServicio.porcentajeCostoMinimo / 100) * unServicio.costoPorPersona
	}

	override String tipoTarifa(){
		"Por Persona"
	}
}
