package servicios

import eventos.Evento
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class ServicioMultiple implements TipoDeServicio {
	val tipoServicio = "Múltiple"

	var Double descuento = 0d // se pasa como un porcentaje de 0 a 100
	List<Servicio> serviciosMultiples = newArrayList

	override tipoServicio() {
		tipoServicio
	}

	override double costoTotal(Evento evento, Servicio servicio) {
		(costoBaseServicios(evento) * factorDescuento) + costoTrasladoServicios(evento)
	}

	def double costoTrasladoServicios(Evento evento) {
		serviciosMultiples.map[unServicio|unServicio.costoTraslado(evento)].max()
	}

	def double costoBaseServicios(Evento evento) {
		serviciosMultiples.fold(0d, [acum, unServicio|acum + unServicio.costoBaseServicio(evento)])
	}

	def double factorDescuento() {
		1 - (descuento / 100)
	}

	override setDescuento(Double unDescuento) {
		descuento = unDescuento

	}

	override agregarServicio(Servicio servicio) {
		serviciosMultiples.add(servicio)
	}

	override double getDescuento() {
		descuento
	}
}
