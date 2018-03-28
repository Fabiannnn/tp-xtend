package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration
import org.uqbar.geodds.Point

@Accessors
class Evento {
	String nombre
	LocalDateTime fechaDeInicio
	LocalDateTime fechaFinalizacion
	Locacion locacion

	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds() / 3600.0
	}

	def double distancia(Point ubicacion) {
		locacion.distancia(ubicacion)
	}

	new(String unNombre, Locacion unaLocacion) {
		this.nombre = unNombre
		locacion = unaLocacion
	}
}
