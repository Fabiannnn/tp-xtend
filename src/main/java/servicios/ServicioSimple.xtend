package servicios

import excepciones.EventoException
import eventos.Evento

class ServicioSimple implements TipoDeServicio {

	override double costoTotal(Evento evento, Servicio servicio) {
		servicio.costoBaseServicio(evento) + servicio.costoTraslado(evento)
	}

	override void agregarServicio(Servicio servicio) {
		throw new EventoException("No puede agregar un servicio a un servicio simple")
	}
}
