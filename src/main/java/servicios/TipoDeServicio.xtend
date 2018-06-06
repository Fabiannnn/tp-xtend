package servicios

import eventos.Evento

interface TipoDeServicio {
//	def double costoDeTraslado (Evento evento, Servicio servicio)
	def double costoTotal(Evento evento, Servicio servicio)
	def void agregarServicio(Servicio servicio)
}
