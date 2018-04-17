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
	Point coordenadasDireccion
	boolean esAntisocial
	Set<Usuario> amigos = newHashSet
	double radioDeCercania
	double saldoCuenta = 0.0 //esto se agrego segun issue 8
	Set<Invitacion> invitaciones = newHashSet
	Set<String> mensajesGenerales = newHashSet // paraInvitaciones cancelaciones postergaciones | RAG: Por qué no notificaciones?
	Set<Entrada> entradaComprada = newHashSet
	TipoDeUsuario tipoDeUsuario
	Set<Evento> eventosOrganizados = newHashSet

	Set<Usuario> amigosEnComun = newHashSet

	// Métodos relacionados con Invitaciones a Eventos Cerrados
	def recibirInvitacion(Invitacion invitacion) {
		invitaciones.add(invitacion)
	}

	def recibirMensaje(String string) {
		mensajesGenerales.add(string)
	}

	//RAG: faltaría una abstracción en invitación para no tener que hacer "invitacion.unEventoCerrado.fechaAnteriorALaLimite()"
	def rechazarInvitacion(Invitacion invitacion) {
		if (equals(invitacion.unUsuario) && invitacion.unEventoCerrado.fechaAnteriorALaLimite())
			invitacion.rechazar()
	}

	def aceptarInvitacion(Invitacion invitacion, int cantidadAcompañantes) {
		if (equals(invitacion.unUsuario) && (invitacion.cantidadDeAcompañantes >= cantidadAcompañantes) &&
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
		Period.between(fechaDeNacimiento, LocalDate.now()).getYears
	}

	def comprarEntradaAUnEventoAbierto(EventoAbierto unEventoAbierto) {
		unEventoAbierto.comprarEntrada(this)
	}

	def devolverEntrada(Entrada entrada) {
		if (entrada.unEventoAbierto.fechaAnteriorALaLimite()) {
			entrada.devolucionEntrada()
		}
	}

	// Métodos relacionados  organizacion de eventos
	def organizarEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		if (tipoDeUsuario.puedoOrganizarElEventoAbierto(unNombre, unOrganizador, unaLocacion, unaFechaInicio,
			unaFechaFinalizacion, unaFechaLimiteConfirmacion, unaEdadMinima, unPrecioEntrada)) {
			eventosOrganizados.add(
				new EventoAbierto =>[
					nombre = unNombre
					organizador = unOrganizador
					locacion = unaLocacion
					fechaDeInicio = unaFechaInicio
					fechaFinalizacion = unaFechaFinalizacion
					fechaLimiteConfirmacion = unaFechaLimiteConfirmacion
					edadMinima = unaEdadMinima
					precioEntrada = unPrecioEntrada
				]
			) 
		}
	}

	def organizarEventoCerrado(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaCapacidadMaxima) {
		if (tipoDeUsuario.puedoOrganizarElEventoCerrado(unOrganizador, unaFechaInicio, unaFechaFinalizacion,
			unaCapacidadMaxima)) {
			eventosOrganizados.add(
				new EventoCerrado=>[
					nombre = unNombre
					organizador = unOrganizador
					locacion = unaLocacion
					fechaDeInicio = unaFechaInicio
					fechaFinalizacion = unaFechaFinalizacion
					fechaLimiteConfirmacion = unaFechaLimiteConfirmacion
					capacidadMaxima = unaCapacidadMaxima
					]
					)
		}
	}
	
	def agregarAmigoALaLista( Usuario unAmigo) {
		amigos.add(unAmigo)
	}
	
	//RAG: Este método no se usa
	def agregarEventoCerrado(EventoCerrado unEventoCerrado) {
		if (tipoDeUsuario.puedoOrganizarElEventoCerrado(unEventoCerrado.getOrganizador(), unEventoCerrado.fechaDeInicio, unEventoCerrado.fechaFinalizacion, unEventoCerrado.getCapacidadMaxima)
		) {eventosOrganizados.add(unEventoCerrado)}
	}
	
	def cancelarUnEvento(Evento unEvento) {
		if (tipoDeUsuario.puedeCancelarEventos()) {
			unEvento.cancelarElEvento()
		}
	}

	def postergarUnEvento(Evento unEvento, LocalDateTime nuevaFechaHoraInicio) {
		if (tipoDeUsuario.puedePostergarEventos()) {
			unEvento.postergarElEvento(nuevaFechaHoraInicio)
		}

	}
	
	// Métodos relacionados con Aceptacion y rechazo masivos
	def aceptacionMasiva() {
		invitaciones.filter(invitacion | invitacion.aceptada===null).forEach[invitacion|this.voyAAceptarla(invitacion)]
	}
	
	//RAG: nombre raro. Podría ser aceptarSiCorresponde()
	def voyAAceptarla(Invitacion invitacion) {
		val cantidadAmigosParaComparar = 4
		if (elOrganizadorEsAmigo(invitacion) || esDentroDelRadioDeCercania(invitacion) ||
			asistenMasDeCantidadDeterminadaDeAmigos(invitacion, cantidadAmigosParaComparar)) {
			invitacion.aceptar(invitacion.cantidadDeAcompañantes)
		}
	} 
	
	def elOrganizadorEsAmigo(Invitacion invitacion) {
		amigos.contains(invitacion.unEventoCerrado.organizador)
	}

	def asistenMasDeCantidadDeterminadaDeAmigos(Invitacion invitacion, int cantidadAmigosParaComparar) {
		cantidadDeAmigosInvitados(invitacion) > cantidadAmigosParaComparar
	}

	def cantidadDeAmigosInvitados(Invitacion invitacion) {
		amigosEnComun = amigos
		amigosEnComun.retainAll(invitacion.unEventoCerrado.invitadosDelEvento)
		amigosEnComun.size()
	}
	
	//RAG: Demasiadas indirecciones, faltan abstracciones en el medio
	def esDentroDelRadioDeCercania(Invitacion invitacion) {
		invitacion.unEventoCerrado.locacion.estaDentroDelRadioDeCercania(coordenadasDireccion, radioDeCercania)
	}
	
	def rechazoMasivo(){
		invitaciones.filter(invitacion | invitacion.aceptada===null).forEach[
			invitacion | this.voyARechazarla(invitacion)
		]
	}
	
	def voyARechazarla(Invitacion invitacion) {
		if(esAntisocial) {
			antisocialRechazaInvitacion(invitacion)
		} else {
			noAntisocialRechazaInvitacion(invitacion)
		}
	}
	
	def antisocialRechazaInvitacion(Invitacion invitacion){
		val cantidadAmigosParaComparar = 1
			if(!esDentroDelRadioDeCercania(invitacion) || (!elOrganizadorEsAmigo(invitacion) && asistenMasDeCantidadDeterminadaDeAmigos( invitacion,  cantidadAmigosParaComparar) )){
				invitacion.rechazar( )
			}
	}
	
	def noAntisocialRechazaInvitacion(Invitacion invitacion){
		val cantidadAmigosParaComparar = 0
		if (!esDentroDelRadioDeCercania(invitacion) && asistenMasDeCantidadDeterminadaDeAmigos( invitacion,  cantidadAmigosParaComparar) ){
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

}

interface TipoDeUsuario {

	def boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada)

	def boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal)

	def boolean puedePostergarEventos()

	def boolean puedeCancelarEventos()

	def boolean sePuedeEntregarInvitacion(EventoCerrado unEvento)

}

@Accessors
class UsuarioFree implements TipoDeUsuario {

	val limiteEventosSimultaneos = 1
	val maximoPersonasPorEventoCerrado = 50
	val cantidadMaximaEventosMensuales = 3

	override boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) { false }

	override boolean puedePostergarEventos() { false }

	override boolean puedeCancelarEventos() { false }

	override boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
		noSuperaElLimiteDeEventosSimultaneos(unUsuario) && noSuperaCapacidadTipoUsuario(unaCapacidadTotal) &&
			noSuperaLimiteMensualDeEventos(unUsuario, unInicioEvento, unaFinalizacionEvento)
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

	override boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		puedoOrganizarElEventoAbierto && noSuperaElLimiteDeEventosSimultaneos(unOrganizador)
	}

	override boolean puedePostergarEventos() { true }

	override boolean puedeCancelarEventos() { true }

	override boolean puedoOrganizarElEventoCerrado(Usuario unUsuario, LocalDateTime unInicioEvento,
		LocalDateTime unaFinalizacionEvento, int unaCapacidadTotal) {
		noSuperaElLimiteDeEventosSimultaneos(unUsuario)
	}

	override boolean sePuedeEntregarInvitacion(EventoCerrado unEventoCerrado) {
		unEventoCerrado.cantidadDeInvitacionesDadas() < maximoInvitacionesEventoCerrado
	}

	def boolean noSuperaElLimiteDeEventosSimultaneos(Usuario unUsuario) {
		unUsuario.eventosOrganizados.filter[evento|evento.fechaFinalizacion > LocalDateTime.now()].size() <
			limiteEventosSimultaneos
	}
}

@Accessors
class UsuarioProfesional implements TipoDeUsuario {

	val cantidadMaximaEventosMensuales = 20

	override boolean puedoOrganizarElEventoAbierto(String unNombre, Usuario unOrganizador, Locacion unaLocacion,
		LocalDateTime unaFechaInicio, LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		noSuperaElLimiteDeEventosMensuales(unOrganizador, unaFechaInicio, unaFechaFinalizacion)
	}

	override boolean puedePostergarEventos() { true }
	
	override boolean puedeCancelarEventos() { true }

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
		unUsuario.eventosOrganizados.filter[evento|evento.fechaDeInicio.month == unaFecha.month].size() <
			cantidadMaximaEventosMensuales
	}

}
