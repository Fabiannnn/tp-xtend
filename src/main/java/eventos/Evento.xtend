package eventos

import excepciones.EventoException
import java.time.Duration
import java.time.LocalDate
import java.time.LocalDateTime
import java.util.Set
import notificaciones.EventoObserverAC
import ordenes.Orden
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CreditCard
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.geodds.Point
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.time.format.DateTimeFormatter
import java.time.Period

@Accessors
@Observable
abstract class Evento {
	static String DATE_PATTERN = "dd/MM/yyyy"
	static String TIME_DATE_PATTERN = "dd/MM/yyyy HH:mm"
	String nombre
	@JsonIgnore Usuario organizador
	@JsonIgnore LocalDateTime fechaDeInicio
	@JsonIgnore LocalDateTime fechaFinalizacion
	@JsonIgnore Locacion locacion
	@JsonIgnore LocalDate fechaLimiteConfirmacion
	@JsonIgnore Set<EventoObserverAC> eventoObservers = newHashSet
	@JsonIgnore Set<String> artistas = newHashSet
	@JsonIgnore boolean cancelado = false
	@JsonIgnore boolean postergado = false
	@JsonIgnore Set<Orden> ordenes = newHashSet

	abstract def boolean esUnFracaso()

	abstract def int capacidadMaxima()

	abstract def void cancelarElEvento()

	abstract def boolean esExitoso()

	abstract def void ejecutarOrdenesDeInvitacion()

	abstract def int cantidadAsistentes() // agregado para eventos abiertos entradas vendidas vigentes y cerrados posibles asistentes

	@JsonProperty("usuarioOrganizador")
	def String getOrganizadoPor() {

		organizador.nombreApellido
	}

	@JsonProperty("locacionNombre")
	def String getLocacionNombre() {
		locacion.nombre
	}

	@JsonProperty("fechaDeInicio")
	def getTiempoFechaAsString() {
		formatterTiempo.format(this.fechaDeInicio)
	}

	@JsonProperty("fechaLimiteConfirmacion")
	def getFechaAsString() {
		formatter.format(this.fechaLimiteConfirmacion)
	}
	def formatterTiempo() {
		DateTimeFormatter.ofPattern(TIME_DATE_PATTERN)
	}
	def formatter() {
		DateTimeFormatter.ofPattern(DATE_PATTERN)
	}



	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds() / 3600.0
	}

	def amigosDelOrganizador() {
		organizador.getAmigos()
	}

	def double distancia(Point ubicacion) {
		locacion.distancia(ubicacion)
	}

	def void agregarEventoObserver(EventoObserverAC eventoObserver) {
		eventoObservers.add(eventoObserver)
	}

	def void notificar() {
		eventoObservers.forEach[unObserver|unObserver.notificar(this)]
	}

	def fechaAnteriorALaLimite() {
		LocalDate.now() <= LocalDate.from(this.fechaLimiteConfirmacion)
	}

	def void postergarElEvento(LocalDateTime nuevaFechaHoraInicio) {
		postergado = true
		cambiarFechasEvento(nuevaFechaHoraInicio)
	}

	def cambiarFechasEvento(LocalDateTime nuevaFechaHoraInicio) {
		val difTiempo = calcularDiferenciaTiempo(nuevaFechaHoraInicio)
		fechaDeInicio.plusHours(difTiempo)
		fechaFinalizacion.plusHours(difTiempo)
		fechaLimiteConfirmacion.plusDays((difTiempo / 24) as int)
	}

	def calcularDiferenciaTiempo(LocalDateTime nuevaFechaHoraInicio) {
		Duration.between(fechaDeInicio, nuevaFechaHoraInicio).toHours()
	}

	def boolean validarDatosEvento() {
		( validarDatosCompletos() && validarFechas())
	}

	def boolean validarFechas() {
		if (!((fechaLimiteConfirmacion < LocalDate.from(fechaDeInicio)) && (fechaDeInicio < fechaFinalizacion))) {
			throw new EventoException("Fechas del evento Inconsistentes")
		} else {
			true
		}
	}

	def boolean validarDatosCompletos() {
		if ((nombre.nullOrEmpty || fechaDeInicio === null || fechaFinalizacion === null ||
			fechaLimiteConfirmacion === null || locacion === null
		)) {
			throw new EventoException("Faltan Datos en el Evento")
		} else {
			true
		}
	}

	abstract def boolean usuariosCercanosAlEvento(Usuario usuario)

	override toString() {
		nombre
	}

	def recibirOrden(Orden orden) {
		ordenes.add(orden)
	}

}

@Accessors
@Observable
class EventoAbierto extends Evento {

	int edadMinima
	double precioEntrada
	@JsonIgnore Set<Entrada> entradas = newHashSet

	def void comprarEntrada(Usuario elComprador) {
		puedeComprarEntrada(elComprador)
		generarEntrada(elComprador)
	}

	override ejecutarOrdenesDeInvitacion() {
		throw new EventoException("Un EventoAbierto no puede ejecutar ordenes de Invitacion")
	}

	def puedeComprarEntrada(Usuario elComprador) {
		if (!edadValida(elComprador) || !fechaAnteriorALaLimite() || !hayEntradasDisponibles()) { // TODO revisar agregado por pago tarjeta
			throw new EventoException("No se puede Comprar la Entrada")
		}
	}

	def edadValida(Usuario elComprador) {
		return elComprador.edad() > edadMinima
	}

	// Metodo usado cuando mockeamos TarjetaPagos
	def void comprarConTarjetaDeCredito(Usuario elComprador, CreditCard tarjetaCredito, TarjetaPagos tarjetaPagos) {
		puedeComprarEntrada(elComprador)
		tarjetaPagos.pagarEntrada(tarjetaCredito, precioEntrada)
		generarEntrada(elComprador)
	}

	// Metodo usado cuando mockeamos el CreditCardService
	def void comprarConLaTarjetaDeCredito(Usuario elComprador, CreditCard tarjetaCredito, TarjetaPagos tarjetaPagos) {
		puedeComprarEntrada(elComprador)
		tarjetaPagos.pagarLaEntrada(tarjetaCredito, precioEntrada)
		generarEntrada(elComprador)
	}

	def generarEntrada(Usuario elComprador) { // llega aca si las condiciones de compra se cumplen
		val nuevaEntrada = new Entrada(this, elComprador)
		registrarCompraEnEvento(nuevaEntrada)
		registrarCompraEnUsuario(nuevaEntrada, elComprador)
	}

	def registrarCompraEnEvento(Entrada nuevaEntrada) {
		entradas.add(nuevaEntrada)
	}

	def registrarCompraEnUsuario(Entrada nuevaEntrada, Usuario elComprador) {
		elComprador.entradaComprada.add(nuevaEntrada)
	}

	// el organizador manda la orden a determinado evento si esta autorizado a cancelarla
	override void cancelarElEvento() {
		cancelado = true
		entradas.forEach[entrada|entrada.cancelacionDeEvento()]
	}

	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio) {
		super.postergarElEvento(nuevaFechaHoraInicio)
		entradas.forall [ invitacion |
			invitacion.mensajesPorPostergacion(fechaDeInicio, fechaFinalizacion, fechaLimiteConfirmacion)
		]
	}

	override capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def boolean hayEntradasDisponibles() {
		entradas.size() < capacidadMaxima()
	}

	override fechaAnteriorALaLimite() {
		LocalDate.now().plus(Period.ofDays(-2)) <= LocalDate.from(fechaLimiteConfirmacion)
	}

	override esExitoso() {
		(!cancelado && !postergado && ventaExitosa())

	}

	def boolean ventaExitosa() { // TODO
		if (!(entradas.size() == 0)) {
			((cantidadAsistentes() * 100) / entradas.size() ) >= 90
		} else {
			false
		}

	}

	override esUnFracaso() { // FUNCIONA     
		cantidadAsistentes() / capacidadMaxima() < 0.5
	}

	override cantidadAsistentes() {
		entradas.filter[entradas|entradas.vigente === true].size()
	}

	override usuariosCercanosAlEvento(Usuario usuario) {
		locacion.estaDentroDelRadioDeCercania(usuario)
	}

}

@Accessors
@Observable
class EventoCerrado extends Evento {

	// static val COEF_EXITO = 0.9
	@JsonIgnore Set<Invitacion> invitados = newHashSet

	int capacidadMaxima = 0

	def void crearInvitacion(Usuario elInvitado, int unaCantidadDeAcompanantes) {
		if (hayCapacidadDisponible(unaCantidadDeAcompanantes + 1) && fechaAnteriorALaLimite()) {
			var nuevaInvitacion = new Invitacion(this, elInvitado, unaCantidadDeAcompanantes)
			registrarInvitacionEnEvento(nuevaInvitacion)
			registrarInvitacionEnUsuario(nuevaInvitacion, elInvitado)
		} else {
			throw new EventoException("No se puede generar la invitacion")
		}
	}

	def getInvitadosDelEvento() {
		invitados.map[unUsuario].toList
	}

	def boolean hayCapacidadDisponible(int unaCantidadTotal) {
		unaCantidadTotal <= (capacidadMaxima() - cantidadAsistentes())
	}

	def registrarInvitacionEnEvento(Invitacion nuevaInvitacion) {
		invitados.add(nuevaInvitacion)
	}

	def registrarInvitacionEnUsuario(Invitacion nuevaInvitacion, Usuario elInvitado) {
		elInvitado.recibirInvitacion(nuevaInvitacion)
	}

	override int cantidadAsistentes() {
		invitados.fold(0)[acum, invitados|acum + invitados.posiblesAsistentes()]
	}

	def int cantidadDeInvitaciones() {
		invitados.size() // si son invitaciones totales sin generar nuevas invitaciones por rechazos
	}

	override cancelarElEvento() {
		cancelado = true
		notificarAInvitadosCancelacion()
	}

	override capacidadMaxima() {
		capacidadMaxima
	}

	def notificarAInvitadosCancelacion() {
		invitados.filter[invitados|invitados.aceptada != false].forall [ invitacion |
			invitacion.notificacionDeCancelacion()
		]
	}

	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio) {
		super.postergarElEvento(nuevaFechaHoraInicio)
		invitados.forall [ invitacion |
			invitacion.NotificacionDePostergacion(fechaDeInicio, fechaFinalizacion, fechaLimiteConfirmacion)
		]
	}

	override boolean esExitoso() {
		(!cancelado && asistenciaExitosa())
	}

	def boolean asistenciaExitosa() {
		if (! (invitados.size() == 0)) {
			(((invitacionesAceptadas() * 100) / invitados.size()	) >= 90)
		} else {
			false
		}
	}

	def int invitacionesAceptadas() {
		invitados.filter[invitacion|invitacion.aceptada === true].size()
	}

	override esUnFracaso() {
		!cancelado && LocalDateTime.now().isAfter(fechaFinalizacion) && asistenciaFracaso()
	}

	def asistenciaFracaso() {
		if (!(invitados.size() == 0)) {
			invitados.filter[invitacion|invitacion.aceptada !== false].size() / invitados.size() < 0.5
		} else {
			false
		}
	}

	override ejecutarOrdenesDeInvitacion() {
		if (fechaAnteriorALaLimite()) {
			ordenes.forEach[orden|orden.ejecutarOrden(this)]
			ordenes.clear
		} else {
			throw new EventoException("Las ordenes no se pueden ejecutar por que el evento expiro")
		}

	}

	override usuariosCercanosAlEvento(Usuario usuario) {
		throw new EventoException("No se puede notificar al usuario.")
	}

	def removerOrdenAsincronica(Invitacion unaInvitacion) {
		val invitacion = invitados.findFirst[invitacion|invitacion.unUsuario === unaInvitacion.unUsuario]
		invitados.remove(invitacion)
		val orden = ordenes.findFirst[orden|orden.invitacion.unUsuario === unaInvitacion.unUsuario]
		ordenes.remove(orden)
	}

}
