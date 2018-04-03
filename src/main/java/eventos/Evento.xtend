package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration
import org.uqbar.geodds.Point
import java.time.LocalDate
import java.util.Set
import java.util.List

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
@Accessors
class EventoCerrado extends Evento {
	List<Invitacion> Invitados = newArrayList
	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, int unaCapacidadMaxima) {
		super(unNombre, unOrganizador, unaLocacion)
		this.capacidadMaxima = unaCapacidadMaxima
	}
	
	def invitadoConAcompañantes(Usuario elInvitado, int unaCantidadDeAcompañantes){
		  hayCapacidadDisponible(unaCantidadDeAcompañantes+1)
		
	}
	def boolean hayCapacidadDisponible(int unaCantidadTotal){
		unaCantidadTotal <= (capacidadMaxima()-cantidadPosiblesAsistentes())

	}
	def agregarInvitacion(Invitacion invitacion){
		Invitados.add(invitacion)
	}
	def int cantidadPosiblesAsistentes(){
		 Invitados.fold(0)[acum, Invitados |acum + Invitados.cantidadDeAcompañantes+1]
	}
}
