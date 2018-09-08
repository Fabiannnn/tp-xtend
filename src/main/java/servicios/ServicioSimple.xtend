package servicios

import excepciones.EventoException
import eventos.Evento
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class ServicioSimple implements TipoDeServicio {
	val tipoServicio = "Simple"

	override tipoServicio() {
		tipoServicio
	}

	override double costoTotal(Evento evento, Servicio servicio) {
		servicio.costoBaseServicio(evento) + servicio.costoTraslado(evento)
	}

	override void agregarServicio(Servicio servicio) {
		throw new EventoException("No puede agregar un servicio a un servicio simple")
	}

	override setDescuento(Double unDescuento) {
		throw new EventoException("Un servicio simple NoTiene Descuentos")
	}

	override double getDescuento() {
		throw new EventoException("Un servicio simple NoTiene Descuentos")
	}
}
