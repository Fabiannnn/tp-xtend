package servicios

import eventos.Evento

interface TipoDeTarifa {
	def double costo(Servicio unServicio, Evento unEvento)

	def boolean validarTipoTarifa(Servicio unservicio)
}
