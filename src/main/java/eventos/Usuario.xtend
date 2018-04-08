package eventos

import java.time.LocalDate
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Set
import java.time.Period
import java.time.LocalDateTime

@Accessors
class Usuario {
	String nombreDeUsuario
	String nombreYApellido
	String eMail
	LocalDate fechaDeNacimiento
	String direccion // es necesario??
	Point coordenadasDireccion
	boolean esAntisocial
	Set<Usuario> amigos
	double radioDeCercania
	Set<Invitacion> invitaciones = newHashSet
	Set<String> mensajesInvitaciones = newHashSet
	Set<Entrada> entradaComprada = newHashSet
	LocalDate today = LocalDate.now()
	TipoDeUsuario tipoDeUsuario
	Set<EventoCerrado> eventosOrganizados= newHashSet

	new(String unNombreYApellido, String unEMail, LocalDate unaFechaDeNacimiento, String unaDireccion,
		Point unaCoordenada) {
		this.nombreYApellido = unNombreYApellido
		this.eMail = unEMail
		this.fechaDeNacimiento = unaFechaDeNacimiento
		this.direccion = unaDireccion
		this.coordenadasDireccion = unaCoordenada

	}

	// Métodos relacionados con Invitaciones a Eventos Cerrados
	def recibirInvitacion(Invitacion invitacion) {
		this.invitaciones.add(invitacion)
	}

	def recibirMensaje(String string) {
		this.mensajesInvitaciones.add(string)
	}

	def rechazarInvitacion(Invitacion invitacion) {
		if (this.equals(invitacion.unUsuario) && invitacion.unEventoCerrado.fechaAnteriorALaLimite())
			invitacion.rechazar()
	}

	def aceptarInvitacion(Invitacion invitacion, int cantidadAcompañantes) {
		if (this.equals(invitacion.unUsuario) && (invitacion.cantidadDeAcompañantes >= cantidadAcompañantes) &&
			invitacion.unEventoCerrado.fechaAnteriorALaLimite()) {
			invitacion.aceptar(cantidadAcompañantes)
		}
	}

	// Métodos relacionados con Entradas  a Eventos Abiertos
	def edad() {
		Period.between(fechaDeNacimiento, today).getYears
	}

	def devolverEntrada(Entrada entrada) {
		if (entrada.unEventoAbierto.fechaAnteriorALaLimite()) {
			entrada.devolucionEntrada()
		}
	}
	def void setUsuarioFree(){tipoDeUsuario = new UsuarioFree}
//		def void setUsuarioAmateur(){tipoDeUsuario = new UsuarioAmateur}
//			def void setUsuarioProfesionale(){tipoDeUsuario = new UsuarioProfesional}

}

interface TipoDeUsuario {

	def boolean puedoOrganizarElEventoAbierto()

	def boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal)

	def boolean entregarInvitacion()
}

@Accessors
class UsuarioFree implements TipoDeUsuario {

	val limiteEventosSimultaneos = 1
	val maximoPersonasPorEventoCerrado = 50
	val cantidadMaximaEventosMensuales = 3

	override boolean puedoOrganizarElEventoAbierto() { false }

	override boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
		noSuperaElLimiteDeEventosSimultaneos(unUsuario) && noSuperaCapacidadTipoUsuario(unaCapacidadTotal) &&
			noSuperaLimiteMensualDeEventos(unUsuario, unInicioEvento, unaFinalizacionEvento)
	}

	override boolean entregarInvitacion() {
		false
	}

	def boolean noSuperaElLimiteDeEventosSimultaneos(Usuario unUsuario) {
		unUsuario.eventosOrganizados.filter[evento|evento.fechaFinalizacion > LocalDateTime.now()].size() <
			limiteEventosSimultaneos

	}

	def boolean noSuperaCapacidadTipoUsuario(int unaCapacidadTotal) {
		unaCapacidadTotal <= maximoPersonasPorEventoCerrado
	}

	def boolean noSuperaLimiteMensualDeEventos(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento) {
		(noSuperaElLimite(unUsuario, unInicioEvento) && noSuperaElLimite(unUsuario, unaFinalizacionEvento))
	}

	def boolean noSuperaElLimite(Usuario unUsuario, LocalDateTime unaFecha) {
		unUsuario.eventosOrganizados.filter[evento|evento.fechaDeInicio.month == unaFecha.month].size() <
			cantidadMaximaEventosMensuales
	}

}
/*
 * @Accessors
 * class Amateur implements TipoUsuario {
 * 	new(int unaCantidadDeEventosSimultaneos, int unaCantidadMaximaDeInvitaciones) {
 * 		super(5)
 * 		this.cantidadMaximaDeInvitacionesPorEvento = 50
 * 	}

 * 	override organizarEvento() {
 * 	}

 * 	override entregarInvitacion() {
 * 	}

 * }

 * @Accessors
 * class Profesional implements TipoUsuario {
 * 	new(int unaCantidadDeEventosSimultaneos) {
 * 		super(5)
 * 	}

 * 	override organizarEvento() {
 * 	}

 * 	override entregarInvitacion() {
 * 	}
 * }
 */
