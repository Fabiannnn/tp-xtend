package servicios

import eventos.Evento
import java.util.List
import org.uqbar.commons.model.annotations.Observable

interface TipoDeServicio {

	def double costoTotal(Evento evento, Servicio servicio)

	def void agregarServicio(Servicio servicio)

	def void setDescuento(Double unDescuento)

	def double getDescuento()

	def String tipoServicio()

}
