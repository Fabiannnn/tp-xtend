package eventos

import java.time.LocalDate
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Set
import java.time.Period
import java.time.LocalDateTime

//import java.time.LocalDateTime
@Accessors
class Usuario {
	String nombreDeUsuario
	String nombreYApellido
	String eMail
	LocalDate fechaDeNacimiento
	String direccion // es necesario??
	Point coordenadasDireccion
	boolean esAntisocial
	Set<Usuario> amigos = newHashSet
	double radioDeCercania
	Set<Invitacion> invitaciones = newHashSet
	Set<String> mensajesGenerales = newHashSet // paraInvitaciones cancelaciones postergaciones
	Set<Entrada> entradaComprada = newHashSet
	LocalDate today = LocalDate.now()
	TipoDeUsuario tipoDeUsuario
	Set<EventoCerrado> eventosCerradosOrganizados = newHashSet
	Set<EventoAbierto> eventosAbiertoOrganizados = newHashSet
	Set<Evento> eventosOrganizados = newHashSet

	new(String unNombreYApellido, String unEMail, LocalDate unaFechaDeNacimiento, String unaDireccion,
		Point unaCoordenada) {
		this.nombreYApellido = unNombreYApellido
		this.eMail = unEMail
		this.fechaDeNacimiento = unaFechaDeNacimiento
		this.direccion = unaDireccion
		this.coordenadasDireccion = unaCoordenada
	}

	/*Falta ver como el usuaria organiza un evento cerrado o abierto consultando previamente segun tipo de usuario */
	// Métodos relacionados con Invitaciones a Eventos Cerrados
	def recibirInvitacion(Invitacion invitacion) {
		this.invitaciones.add(invitacion)
	}

	def crearSetEventosTotal() {
		eventosOrganizados.addAll(eventosCerradosOrganizados)
		eventosOrganizados.addAll(eventosAbiertoOrganizados)
	}

	def recibirMensaje(String string) {
		this.mensajesGenerales.add(string)
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

	def invitarAUnEventoCerrado(EventoCerrado unEventoCerrado, Usuario elInvitado, int unaCantidadDeAcompañantes) {
		if (tipoDeUsuario.sePuedeEntregarInvitacion(unEventoCerrado)) {
			unEventoCerrado.crearInvitacionConAcompañantes(elInvitado, unaCantidadDeAcompañantes)
		}
	}

	// Métodos relacionados con Entradas  a Eventos Abiertos
	def edad() {
		Period.between(fechaDeNacimiento, today).getYears
	}

	def comprarEntradaAUnEventoAbierto(EventoAbierto unEventoAbierto) {
		unEventoAbierto.comprarEntrada(this)
	}

	def devolverEntrada(Entrada entrada) {
		if (entrada.unEventoAbierto.fechaAnteriorALaLimite()) {
			entrada.devolucionEntrada()
		}
	}

	// organizacion de eventos
	def organizarEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		if (tipoDeUsuario.puedoOrganizarElEventoAbierto(unNombre, unOrganizador, unaLocacion, unaFechaInicio,
			unaFechaFinalizacion, unaFechaLimiteConfirmacion, unaEdadMinima, unPrecioEntrada)) {

			eventosAbiertoOrganizados.add(
				new EventoAbierto(unNombre, unOrganizador, unaLocacion, unaFechaInicio, unaFechaFinalizacion,
					unaFechaLimiteConfirmacion, unaEdadMinima, unPrecioEntrada))
		}
	}

	def organizarEventoCerrado(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaCapacidadMaxima) {
		if (tipoDeUsuario.puedoOrganizarElEventoCerrado(unOrganizador, unaFechaInicio, unaFechaFinalizacion,
			unaCapacidadMaxima)) {

			eventosCerradosOrganizados.add(
				new EventoCerrado(unNombre, unOrganizador, unaLocacion, unaFechaInicio, unaFechaFinalizacion,
					unaFechaLimiteConfirmacion, unaCapacidadMaxima))

		}

	}
def cancelarUnEvento(Evento unEvento){
		if (tipoDeUsuario.puedeCancelarPostergarEventos()){
			unEvento.cancelarElEvento()
		}
	
	}
	def postergarUnEvento(Evento unEvento, LocalDateTime nuevaFechaHoraInicio){
		if (tipoDeUsuario.puedeCancelarPostergarEventos()){
			unEvento.postergarElEvento(nuevaFechaHoraInicio)
		}
	
	}


	def void setUsuarioFree() { tipoDeUsuario = new UsuarioFree }

	def void setUsuarioAmateur() { tipoDeUsuario = new UsuarioAmateur }

	def void setUsuarioProfesional() { tipoDeUsuario = new UsuarioProfesional }

	def agregarAmigoALaLista(Usuario unUsuario, Usuario unAmigo) {
		amigos.add(unAmigo)
	}






}

interface TipoDeUsuario {

	def boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada)

	def boolean puedeCancelarPostergarEventos()

	def boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal)

	def boolean sePuedeEntregarInvitacion(EventoCerrado unEvento)

}

@Accessors
class UsuarioFree implements TipoDeUsuario {

	val limiteEventosSimultaneos = 1
	val maximoPersonasPorEventoCerrado = 50
	val cantidadMaximaEventosMensuales = 3
	boolean puedoOrganizarElEventoAbierto = false
	boolean puedeCancelarPostergarEventos = false

	override boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) { puedoOrganizarElEventoAbierto }

	override boolean puedeCancelarPostergarEventos() { puedeCancelarPostergarEventos }

	override boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
		noSuperaElLimiteDeEventosSimultaneos(unUsuario) && noSuperaCapacidadTipoUsuario(unaCapacidadTotal) &&
			noSuperaLimiteMensualDeEventos(unUsuario, unInicioEvento, unaFinalizacionEvento)
	}

	override boolean sePuedeEntregarInvitacion(EventoCerrado unEvento) {
		true
	}

	def boolean noSuperaElLimiteDeEventosSimultaneos(Usuario unUsuario) {
		unUsuario.crearSetEventosTotal()
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
		unUsuario.crearSetEventosTotal()
		unUsuario.eventosOrganizados.filter[evento|evento.fechaDeInicio.month == unaFecha.month].size() <
			cantidadMaximaEventosMensuales
	}

}

@Accessors
class UsuarioAmateur implements TipoDeUsuario {

	val limiteEventosSimultaneos = 5
	val maximoInvitacionesEventoCerrado = 50
	boolean puedoOrganizarElEventoAbierto = true

	boolean puedeCancelarPostergarEventos = true

	override boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		puedoOrganizarElEventoAbierto && noSuperaElLimiteDeEventosSimultaneos(unOrganizador)
	}

	override boolean puedeCancelarPostergarEventos() { puedeCancelarPostergarEventos }

	override boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
		noSuperaElLimiteDeEventosSimultaneos(unUsuario)
	}

	override boolean sePuedeEntregarInvitacion(EventoCerrado unEventoCerrado) {
		unEventoCerrado.cantidadDeInvitacionesDadas() < maximoInvitacionesEventoCerrado
	}

	def boolean noSuperaElLimiteDeEventosSimultaneos(Usuario unUsuario) {
		unUsuario.crearSetEventosTotal()
		unUsuario.eventosOrganizados.filter[evento|evento.fechaFinalizacion > LocalDateTime.now()].size() <
			limiteEventosSimultaneos
	}
}

@Accessors
class UsuarioProfesional implements TipoDeUsuario {

	val cantidadMaximaEventosMensuales = 20
	boolean puedoOrganizarElEventoAbierto = true
	boolean puedeCancelarPostergarEventos = true

	override boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		puedoOrganizarElEventoAbierto && noSuperaElLimiteDeEventosMensuales(unOrganizador, unaFechaInicio,
			unaFechaFinalizacion)
	}

	override boolean puedeCancelarPostergarEventos() { puedeCancelarPostergarEventos }

	override boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
		noSuperaElLimiteDeEventosMensuales(unUsuario, unInicioEvento, unaFinalizacionEvento)
	}

	override boolean sePuedeEntregarInvitacion(EventoCerrado unEvento) {
		true
	}

	def boolean noSuperaElLimiteDeEventosMensuales(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento) {
		(noSuperaElLimite(unUsuario, unInicioEvento) && noSuperaElLimite(unUsuario, unaFinalizacionEvento))
	}

	def boolean noSuperaElLimite(Usuario unUsuario, LocalDateTime unaFecha) {
		unUsuario.crearSetEventosTotal()
		unUsuario.eventosOrganizados.filter[evento|evento.fechaDeInicio.month == unaFecha.month].size() <
			cantidadMaximaEventosMensuales
	}

}
