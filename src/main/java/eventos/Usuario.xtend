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
	Set<Evento> eventosOrganizados

	/* 	new(String unNombreYApellido, String unEMail, LocalDate unaFechaDeNacimiento, String unaDireccion,  Point unaCoordenada) {
	 * 		nombreYApellido = unNombreYApellido
	 * 		eMail = unEMail
	 * 		fechaDeNacimiento = unaFechaDeNacimiento
	 * 		direccion = unaDireccion

	 * 		coordenadasDireccion = unaCoordenada

	 * 	}
	 */
	// este segundo constructor esta incompleto por ahora se deja para test
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

}

interface TipoDeUsuario {

	def puedoOrganizarElEventoAbierto() {
	}

	def puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
	}

	def entregarInvitacion() {
	}
}

@Accessors
class Free implements TipoDeUsuario {

	val limiteEventosSimultaneos = 1
	val maximoPersonasPorEventoCerrado = 50
	val cantidadMaximaEventosMensuales = 3

	override puedoOrganizarElEventoAbierto() { false }

	override puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
		noSuperaElLimiteDeEventosSimultaneos(unUsuario) && noSuperaCapacidadTipoUsuario(unaCapacidadTotal) &&
			noSuperaLimiteMensualDeEventos(unUsuario, unInicioEvento, unaFinalizacionEvento)
	}

	def noSuperaElLimiteDeEventosSimultaneos(Usuario unUsuario) {
		unUsuario.eventosOrganizados.filter[evento|evento.fechaFinalizacion > LocalDateTime.now()].size() <
			limiteEventosSimultaneos

	}

	def noSuperaCapacidadTipoUsuario(int unaCapacidadTotal) {
		unaCapacidadTotal <= maximoPersonasPorEventoCerrado
	}

	def noSuperaLimiteMensualDeEventos(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento) {
		(noSuperaElLimite(unUsuario, unInicioEvento) && noSuperaElLimite(unUsuario, unaFinalizacionEvento))
	}

	def noSuperaElLimite(Usuario unUsuario, LocalDateTime unaFecha) {
		unUsuario.eventosOrganizados.filter[evento|evento.fechaDeInicio.month == unaFecha.month].size() >
			cantidadMaximaEventosMensuales
	}

	override entregarInvitacion() {
		false
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
