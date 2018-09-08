package servicios

import eventos.Evento
import org.uqbar.commons.model.annotations.Observable

interface TipoDeTarifa {
	def double costo(Servicio unServicio, Evento unEvento)

	def boolean validarTipoTarifa(Servicio unservicio)

	def String tipoTarifa()
}
