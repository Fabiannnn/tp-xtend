package servicios

import eventos.Evento

interface TipoDeServicio {

	def double costoTotal(Evento evento, Servicio servicio)

	def void agregarServicio(Servicio servicio)

	def void setDescuento(Double unDescuento)

	def double getDescuento()
}
