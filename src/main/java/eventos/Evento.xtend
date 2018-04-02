package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration
import org.uqbar.geodds.Point
import java.time.LocalDate
import java.util.Set

@Accessors
abstract class Evento {
	String nombre
	Usuario organizador
	LocalDateTime fechaDeInicio
	LocalDateTime fechaFinalizacion
	Locacion locacion
	int capacidadMaxima = 0
	LocalDate fechaLimiteConfirmacion

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion) {
		this.nombre = unNombre
		organizador = unOrganizador
		locacion = unaLocacion
	}

	def capacidadMaxima() {
		capacidadMaxima
	}

	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds() / 3600.0
	}

	def double distancia(Point ubicacion) {
		locacion.distancia(ubicacion)
	}

	def hayEntradasDisponibles() {}

	def esExitoso() {}

	def esUnFracaso() {}

	def fechaLimiteConfirmacion() { fechaLimiteConfirmacion }

}

class EventoAbierto extends Evento {
	int edadMinima
	Set<Usuario> asistentesCompradores // va aca o son los usuarios quienes saben de que eventos compraron entradas

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion) {
		super(unNombre, unOrganizador, unaLocacion)
	}

	def edadMinima() { edadMinima }

	override capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	override hayEntradasDisponibles() { if(asistentesCompradores.size() < this.capacidadMaxima()) true else false } // o limitar elementos de la lista por capacidad maxima
}

class EventoCerrado extends Evento {
	/* 	List<Usuario> asistentesInvitados = newArrayList // usuario cantidad de invitados  no se si esto va aca o iria en los usuarios
	 */
	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, int unaCapacidadMaxima) {
		super(unNombre, unOrganizador, unaLocacion)
		this.capacidadMaxima = unaCapacidadMaxima
	}

}
