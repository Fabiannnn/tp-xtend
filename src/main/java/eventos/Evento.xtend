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

	override hayEntradasDisponibles() {
		asistentesCompradores.size() < this.capacidadMaxima()
	} 
}

@Accessors
class EventoCerrado extends Evento {
	Set<Invitacion> Invitados = newHashSet // ver como pasar a Set
	Invitacion  nuevaInvitacion 
	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, int unaCapacidadMaxima) {
		super(unNombre, unOrganizador, unaLocacion)
		this.capacidadMaxima = unaCapacidadMaxima
	}

	def crearInvitacionConAcompañantes(Usuario elInvitado, int unaCantidadDeAcompañantes) {
		if (hayCapacidadDisponible(unaCantidadDeAcompañantes + 1)) {

		nuevaInvitacion= new Invitacion(this, elInvitado, unaCantidadDeAcompañantes)
			registrarInvitacionEnEvento(nuevaInvitacion )
			registrarInvitacionEnUsuario(nuevaInvitacion, elInvitado )
						
	
		} else
		println ("...")
			//ver como mandar string al organizador que no se mando la invitacion

	}

	def boolean hayCapacidadDisponible(int unaCantidadTotal) {
		unaCantidadTotal <= (capacidadMaxima() - cantidadPosiblesAsistentes())

	}

	def registrarInvitacionEnEvento(Invitacion nuevaInvitacion) {
		Invitados.add(nuevaInvitacion)
				
	}
	

	def registrarInvitacionEnUsuario(Invitacion nuevaInvitacion, Usuario elInvitado) {
		elInvitado.recibirInvitacion(nuevaInvitacion)
		elInvitado.recibirMensaje("Fuiste invitado a"+this.nombre+", con "+nuevaInvitacion.cantidadDeAcompañantes)
		
	}
	def int cantidadPosiblesAsistentes() {
		Invitados.fold(0)[acum, Invitados|acum + Invitados.cantidadDeAcompañantes + 1]
	}
}
