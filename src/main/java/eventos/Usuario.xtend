package eventos

import excepciones.EventoException
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.Period
import java.util.List
import java.util.Set
import ordenes.Aceptacion
import ordenes.Orden
import ordenes.Rechazo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.geodds.Point
import org.uqbar.commons.model.annotations.Dependencies
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.time.format.DateTimeFormatter

@Accessors
@TransactionalAndObservable
class Usuario implements Entidad {
	static String DATE_PATTERN = "dd/MM/yyyy"
	String nombreUsuario
	String nombreApellido
	String email
	LocalDate fechaNacimiento
	Point punto = new Point(0, 0)
	Boolean esAntisocial
	Set<Usuario> amigos = newHashSet
	double radioDeCercania
	double saldoCuenta = 0.0 // esto se agrego segun issue 8 entrega 1
	Set<Invitacion> invitaciones = newHashSet
	Set<String> notificaciones = newHashSet // paraInvitaciones cancelaciones postergaciones
	Set<Entrada> entradaComprada = newHashSet
	TipoDeUsuario tipoDeUsuario
	Set<Evento> eventosOrganizados = newHashSet
	int id
	Set<String> fanArtistas = newHashSet

	def List<TipoDeUsuario> getTiposDeUsuarios() {
		#[new UsuarioFree, new UsuarioAmateur, new UsuarioProfesional]
	}

	@Dependencies("ubicacion")
	def double getPuntoX(){punto.latitude}
	def setPuntoX(double unValor){	
		punto.x = unValor.doubleValue
	}
	@Dependencies("ubicacion")
	def double getPuntoY(){punto.longitude}
	def setPuntoY(double unValor){	
		punto.y = unValor.doubleValue
	}
	
	def invitacionesRecibidas() {
		invitaciones
	}

	def entradasCompradas() {
		entradaComprada
	}

	def eventosOrganizadosPor() {
		eventosOrganizados
	}

	def int eventosPorLocacion(Locacion _locacion) {
		eventosOrganizados.filter[evento|evento.locacion === _locacion].size
	}

	def esMiAmigo(Usuario _Usuario) {
		return amigos.contains(_Usuario)
	}

	def getAmigos() {
		amigos
	}

	def getEmail() {
		email

	}

	def recibirNotificacion(String textoNotificacion) {
		notificaciones.add(textoNotificacion)
	}

	def boolean fanDeUnArtista(String artista) {
		fanArtistas.exists[artistaUsuario|artistaUsuario.equals(artista)]
	}
@JsonProperty("fechaNacimiento")
	def getFechaAsString() {
		formatter.format(this.fechaNacimiento)
	}
	
	
	def asignarFecha(String fecha) {
		this.fechaNacimiento = LocalDate.parse(fecha, formatter)
	}
	
	def formatter() {
		DateTimeFormatter.ofPattern(DATE_PATTERN)
	}


//metodo recibir lista de artistas
	def boolean soyFanDeAlgunoDeLosArtistas(Set<String> artistas) {
		artistas.exists[artista|this.fanDeUnArtista(artista)]
	}

// Métodos relacionados con Invitaciones a Eventos Cerrados
	def recibirInvitacion(Invitacion invitacion) {
		invitaciones.add(invitacion)
		agregarMensaje("Fuiste invitado a" + invitacion.unEventoCerrado + ", con " + invitacion.cantidadDeAcompanantes)
	}

	def agregarMensaje(String string) {
		notificaciones.add(string)
	}

	def rechazarInvitacion(Invitacion invitacion) {
		invitacion.verificaRechazo(this)
//		if (equals(invitacion.unUsuario) && invitacion.fechaParaConfirmar())
//			invitacion.rechazar()
	}

	def aceptarInvitacion(Invitacion invitacion, int cantidadAcompanantes) {
		invitacion.verificaAceptacion(this, cantidadAcompanantes)

//		if (equals(invitacion.unUsuario) && (invitacion.cantidadDeAcompanantes >= cantidadAcompanantes) &&
//			invitacion.fechaParaConfirmar()) {
//			invitacion.aceptar(cantidadAcompanantes)
//		}
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
				unEventoAbierto.notificar()
				eventosOrganizados.add(unEventoAbierto)

			} else {
				throw new EventoException("El Usuario No puede organizar el evento")
			}
		}
	}

// Este cambio ya lo vio Rodrigo
	def organizarEventoCerrado(EventoCerrado unEventoCerrado) {
		if (unEventoCerrado.validarDatosEvento()) {
			if (tipoDeUsuario.puedoOrganizarElEventoCerrado(this, unEventoCerrado)) {
				unEventoCerrado.organizador = this
				unEventoCerrado.notificar()
				eventosOrganizados.add(unEventoCerrado) // TODO activar observers
			} else {
				throw new EventoException("No se puede organizar el evento")
			}
		}
	}

	def agregarAmigoALaLista(Usuario unAmigo) {
		amigos.add(unAmigo)
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
		invitacion.ubicacion().estaDentroDelRadioDeCercania(this)
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
	override esValido() { // VER COMO REFACTORIZAR  Asi???
		validarNombreUsuario()
		validarNombreApellido()
		validarEMail()
		//validarFechaNacimiento()
		validarUbicacion()
	}

	def validarUbicacion() {
		if (punto === null) {
			throw new EventoException("Falta Ubicacion")
		}
	}

	def validarFechaNacimiento() {
		if (fechaNacimiento === null) {
			throw new EventoException("Falta Fecha de Nacimiento")
		}
	}

	def validarEMail() {
		if (email.nullOrEmpty) {
			throw new EventoException("Falta e-mail")
		}
	}

	def validarNombreApellido() {
		if (nombreApellido.nullOrEmpty) {
			throw new EventoException("Falta Nombre y Apellido")
		}
	}

	def validarNombreUsuario() {
		if (nombreUsuario.nullOrEmpty) {
			throw new EventoException("Falta Nombre de Usuario")
		}

	}

	override int getId() {
		return id
	}

	override void agregarId(int _nextId) {
		id = _nextId
	}

	override boolean filtroPorTexto(String cadena) {
		nombreApellido.contains(cadena) || nombreUsuario.contentEquals(cadena)
	}
}

interface TipoDeUsuario {

	def boolean puedoOrganizarElEventoAbierto(Usuario unOrganizador, EventoAbierto unEventoAbierto)

	def boolean puedoOrganizarElEventoCerrado(Usuario unOrganizador, EventoCerrado unEventoCerrado)

	def boolean puedePostergarEventos()

	def boolean puedeCancelarEventos()

	def boolean sePuedeEntregarInvitacion(EventoCerrado unEvento)

	def void agregarOrdenAsincronica(Evento evento, Orden orden)

	def void aceptacionAsincronica(Invitacion invitacion)

	def void rechazoAsincronico(Invitacion invitacion)

	def void removerOrdenAsincronica(Invitacion invitacion)

	def String nom()

}

@Accessors
@Observable
class UsuarioFree implements TipoDeUsuario {
	val nom = "Free"
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

	override agregarOrdenAsincronica(Evento evento, Orden orden) {
		throw new EventoException("El usuario free no puede Confirmar Asincronicamente")
	}

	override aceptacionAsincronica(Invitacion invitacion) {
		throw new EventoException("Un usuario free no puede aceptar invitacion de forma asincronica")
	}

	override rechazoAsincronico(Invitacion invitacion) {
		throw new EventoException("Un usuario free no puede rechazar una invitacion de forma asincronica")
	}

	override void removerOrdenAsincronica(Invitacion invitacion) {
		throw new EventoException("Un usuario free no puede remover ordenes asincronicas")
	}

	override nom() {
		nom
	}

}

@Accessors
@Observable
class UsuarioAmateur implements TipoDeUsuario {
	val nom = "Amateur"
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

	override agregarOrdenAsincronica(Evento evento, Orden orden) {
		throw new EventoException("El usuario amateur no puede Confirmar Asincronicamente")
	}

	override aceptacionAsincronica(Invitacion invitacion) {
		throw new EventoException("Un usuario amateur no puede aceptar invitacion de forma asincronica")
	}

	override rechazoAsincronico(Invitacion invitacion) {
		throw new EventoException("Un usuario amateur no puede rechazar una invitacion de forma asincronica")
	}

	override void removerOrdenAsincronica(Invitacion invitacion) {
		throw new EventoException("Un usuario amateur no puede remover ordenes asincronicas")
	}

	override nom() {
		nom
	}
}

@Accessors
@Observable
class UsuarioProfesional implements TipoDeUsuario {
	val nom = "Profesional"
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


	override agregarOrdenAsincronica(Evento evento, Orden orden) {
		evento.recibirOrden(orden)
	}

	//
	override void aceptacionAsincronica(Invitacion invitacion) {
		val Aceptacion aceptacion = new Aceptacion(invitacion)
		invitacion.eventoCerrado.recibirOrden(aceptacion)
	}

	override void rechazoAsincronico(Invitacion invitacion) {
		val Rechazo rechazo = new Rechazo(invitacion)
		invitacion.eventoCerrado.recibirOrden(rechazo)
	}

	override void removerOrdenAsincronica(Invitacion invitacion) {
		invitacion.eventoCerrado.removerOrdenAsincronica(invitacion)
	}

	override nom() {
		nom
	}
//
}
