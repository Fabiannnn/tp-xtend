package eventos

import java.time.LocalDate
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Set
import java.time.Period
import java.time.LocalDateTime
import excepciones.EventoException

@Accessors
class Usuario implements Entidad {

	String nombreUsuario
	String nombreApellido
	String email
	LocalDate fechaNacimiento
	Point coordenadas
	boolean esAntisocial
	Set<Usuario> amigos = newHashSet
	double radioDeCercania
	double saldoCuenta = 0.0 // esto se agrego segun issue 8
	Set<Invitacion> invitaciones = newHashSet
	Set<String> notificaciones = newHashSet // paraInvitaciones cancelaciones postergaciones
	Set<Entrada> entradaComprada = newHashSet
	TipoDeUsuario tipoDeUsuario
	Set<Evento> eventosOrganizados = newHashSet
	int id

// Métodos relacionados con Invitaciones a Eventos Cerrados
	def recibirInvitacion(Invitacion invitacion) {
		invitaciones.add(invitacion)
		agregarMensaje("Fuiste invitado a" + invitacion.unEventoCerrado + ", con " + invitacion.cantidadDeAcompanantes)
	}

	def agregarMensaje(String string) {
		notificaciones.add(string)
	}

	def rechazarInvitacion(Invitacion invitacion) {
		if (equals(invitacion.unUsuario) && invitacion.fechaParaConfirmar())
			invitacion.rechazar()
	}

	def aceptarInvitacion(Invitacion invitacion, int cantidadAcompanantes) {
		if (equals(invitacion.unUsuario) && (invitacion.cantidadDeAcompanantes >= cantidadAcompanantes) &&
			invitacion.fechaParaConfirmar()) {
			invitacion.aceptar(cantidadAcompanantes)
		}
	}

	def invitarAUnEventoCerrado(EventoCerrado unEventoCerrado, Usuario elInvitado, int unaCantidadDeAcompanantes) {
		if (tipoDeUsuario.sePuedeEntregarInvitacion(unEventoCerrado)) {
			unEventoCerrado.crearInvitacion(elInvitado, unaCantidadDeAcompanantes)
		}
	}

// Métodos relacionados con Entradas  a Eventos Abiertos
	def edad() {
		Period.between(fechaNacimiento, LocalDate.now()).getYears
	}

	def comprarEntradaAUnEventoAbierto(EventoAbierto unEventoAbierto) {
		unEventoAbierto.comprarEntrada(this)
	}

	def devolverEntrada(Entrada entrada) {
		if (entrada.unEventoAbierto.fechaAnteriorALaLimite()) {
			entrada.devolucionEntrada()
		}
	}

// este cambio ya lo vio Rodrigo
	def organizarEventoAbierto(EventoAbierto unEventoAbierto) {
		if (unEventoAbierto.validarDatosEvento()) {
			if (tipoDeUsuario.puedoOrganizarElEventoAbierto(this, unEventoAbierto)) {
				unEventoAbierto.organizador = this
				eventosOrganizados.add(
					unEventoAbierto
				)
			} else {
				throw new EventoException("El Usuario No puede organizar el evento")
			}
		}
	}

	def agregarAmigoALaLista(Usuario unAmigo) {
		amigos.add(unAmigo)
	}

// Este cambio ya lo vio Rodrigo
	def organizarEventoCerrado(EventoCerrado unEventoCerrado) {
		if (unEventoCerrado.validarDatosEvento()) {
			if (tipoDeUsuario.puedoOrganizarElEventoCerrado(this, unEventoCerrado)) {
				unEventoCerrado.organizador = this
				eventosOrganizados.add(unEventoCerrado)
			} else {
				throw new EventoException("No se puede organizar el evento")
			}
		}
	}

	def cancelarUnEvento(Evento unEvento) {
		if (tipoDeUsuario.puedeCancelarEventos()) {
			unEvento.cancelarElEvento()
		}
	}

	def postergarUnEvento(
		Evento unEvento,
		LocalDateTime nuevaFechaHoraInicio
	) {
		if (tipoDeUsuario.puedePostergarEventos()) {
			unEvento.postergarElEvento(nuevaFechaHoraInicio)
		}
	}

	// Métodos relacionados con Aceptacion y rechazo masivos
	def aceptacionMasiva() {
		invitaciones.forEach(invitacion|noEstaAceptada(invitacion))
	}

	def noEstaAceptada(Invitacion invitacion) {
		if (invitacion.aceptada === null) {
			aceptarSiCorresponde(invitacion)
		}
	}

	def aceptarSiCorresponde(Invitacion invitacion) {
		val cantidadAmigosParaComparar = 4
		if (elOrganizadorEsAmigo(invitacion) || esDentroDelRadioDeCercania(invitacion) ||
			asistenMasAmigos(invitacion, cantidadAmigosParaComparar)) {
			invitacion.aceptar(invitacion.cantidadDeAcompanantes)
		}
	}

	def elOrganizadorEsAmigo(Invitacion invitacion) {
		amigos.contains(invitacion.unEventoCerrado.organizador)
	}

	def asistenMasAmigos(Invitacion invitacion, int cantidadAmigosParaComparar) {
		cantidadDeAmigosInvitados(invitacion) > cantidadAmigosParaComparar
	}

	def int cantidadDeAmigosInvitados(Invitacion invitacion) { // MEJORAR ESTO
		amigos.filter[unUsuario|invitacion.unEventoCerrado.invitados.contains(unUsuario)].size()
	}

	def esDentroDelRadioDeCercania(Invitacion invitacion) {
		invitacion.ubicacion().estaDentroDelRadioDeCercania(coordenadas, radioDeCercania)
	}

	def rechazoMasivo() {
		invitaciones.forEach [ invitacion |
			if (invitacion.aceptada === null) {
				voyARechazarla(invitacion)
			}
		]
	}

	def voyARechazarla(Invitacion invitacion) {
		if (esAntisocial) {
			antisocialRechazaInvitacion(invitacion)
		} else {
			noAntisocialRechazaInvitacion(invitacion)
		}
	}

	def antisocialRechazaInvitacion(Invitacion invitacion) {
		val cantidadAmigosParaComparar = 1
		if ((esDentroDelRadioDeCercania(invitacion) === false) || ((elOrganizadorEsAmigo(invitacion) === false) &&
			asistenMasAmigos(invitacion, cantidadAmigosParaComparar) )) {
			invitacion.rechazar()
		}
	}

	def noAntisocialRechazaInvitacion(Invitacion invitacion) {
		val cantidadAmigosParaComparar = 0
		if ((esDentroDelRadioDeCercania(invitacion) === false) &&
			!asistenMasAmigos(invitacion, cantidadAmigosParaComparar) && (elOrganizadorEsAmigo(invitacion) === false)) {
			invitacion.rechazar()
		}
	}

// Seteo de tipo de usuarios
	def void setUsuarioFree() {
		tipoDeUsuario = new UsuarioFree
	}

	def void setUsuarioAmateur() {
		tipoDeUsuario = new UsuarioAmateur
	}

	def void setUsuarioProfesional() {
		tipoDeUsuario = new UsuarioProfesional
	}

//interface Entidad
	override validar() { //TODO VER COMO REFACTORIZAR
		if (nombreUsuario === null || nombreApellido === null || email === null || fechaNacimiento === null ||
			coordenadas === null) {
			throw new EventoException("Faltan Datos de Usuario")
		} else {
			true
		}
	}

	override int getId() {
		return id
	}

	override void agregarId(int _nextId) {
		id = _nextId
	}

	override boolean elementoBuscado(String cadena) {
		nombreApellido.contains(cadena) || nombreUsuario.contentEquals(cadena)
	}
}

interface TipoDeUsuario {

	def boolean puedoOrganizarElEventoAbierto(Usuario unOrganizador, EventoAbierto unEventoAbierto)

	def boolean puedoOrganizarElEventoCerrado(Usuario unOrganizador, EventoCerrado unEventoCerrado)

	def boolean puedePostergarEventos()

	def boolean puedeCancelarEventos()

	def boolean sePuedeEntregarInvitacion(EventoCerrado unEvento)

}

@Accessors
class UsuarioFree implements TipoDeUsuario {

	val limiteEventosSimultaneos = 1
	val maximoPersonasPorEventoCerrado = 50
	val cantidadMaximaEventosMensuales = 3

	override boolean puedoOrganizarElEventoAbierto(Usuario unOrganizador, EventoAbierto unEventoAbierto) { false }

	override boolean puedePostergarEventos() { false }

	override boolean puedeCancelarEventos() { false }

	override boolean puedoOrganizarElEventoCerrado(Usuario unOrganizador, EventoCerrado unEventoCerrado) {
		noSuperaElLimiteDeEventosSimultaneos(unOrganizador) &&
			noSuperaCapacidadTipoUsuario(unEventoCerrado.capacidadMaxima()) &&
			noSuperaLimiteMensualDeEventos(unOrganizador, unEventoCerrado.fechaDeInicio,
				unEventoCerrado.fechaFinalizacion)
	}

	override boolean sePuedeEntregarInvitacion(EventoCerrado unEvento) {
		true
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

@Accessors
class UsuarioAmateur implements TipoDeUsuario {

	val limiteEventosSimultaneos = 5
	val maximoInvitacionesEventoCerrado = 50
	boolean puedoOrganizarElEventoAbierto = true

	override boolean puedoOrganizarElEventoAbierto(Usuario unOrganizador, EventoAbierto unEventoAbierto) {
		puedoOrganizarElEventoAbierto && noSuperaElLimiteDeEventosSimultaneos(unOrganizador)
	}

	override boolean puedePostergarEventos() { true }

	override boolean puedeCancelarEventos() { true }

	override boolean puedoOrganizarElEventoCerrado(Usuario unOrganizador, EventoCerrado unEventoCerrado) {
		noSuperaElLimiteDeEventosSimultaneos(unOrganizador)
	}

	override boolean sePuedeEntregarInvitacion(EventoCerrado unEventoCerrado) {
		unEventoCerrado.cantidadDeInvitaciones() < maximoInvitacionesEventoCerrado
	}

	def boolean noSuperaElLimiteDeEventosSimultaneos(Usuario unUsuario) {
		unUsuario.eventosOrganizados.filter[evento|evento.fechaFinalizacion > LocalDateTime.now()].size() <
			limiteEventosSimultaneos
	}
}

@Accessors
class UsuarioProfesional implements TipoDeUsuario {

	val cantidadMaximaEventosMensuales = 20

	override boolean puedoOrganizarElEventoAbierto(Usuario unOrganizador, EventoAbierto unEventoAbierto) {
		noSuperaElLimiteDeEventosMensuales(unOrganizador, unEventoAbierto.fechaDeInicio,
			unEventoAbierto.fechaFinalizacion)
	}

	override boolean puedePostergarEventos() { true }

	override boolean puedeCancelarEventos() { true }

	override boolean puedoOrganizarElEventoCerrado(Usuario unOrganizador, EventoCerrado unEventoCerrado) {
		noSuperaElLimiteDeEventosMensuales(unOrganizador, unEventoCerrado.fechaDeInicio,
			unEventoCerrado.fechaFinalizacion)
	}

	override boolean sePuedeEntregarInvitacion(EventoCerrado unEvento) {
		true
	}

	def boolean noSuperaElLimiteDeEventosMensuales(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento) {
		(noSuperaElLimite(unUsuario, unInicioEvento) && noSuperaElLimite(unUsuario, unaFinalizacionEvento))
	}

	def boolean noSuperaElLimite(Usuario unUsuario, LocalDateTime unaFecha) {
		unUsuario.eventosOrganizados.filter[evento|evento.fechaDeInicio.month == unaFecha.month].size() <
			cantidadMaximaEventosMensuales
	}

}
