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
	LocalDate today = LocalDate.now()
	boolean cancelado=false
	boolean postergado =false
	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion,LocalDateTime unaFechaInicio,LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion) {
		this.nombre = unNombre
		organizador = unOrganizador
		locacion = unaLocacion
		fechaDeInicio= unaFechaInicio
		fechaFinalizacion= unaFechaFinalizacion
		fechaLimiteConfirmacion = unaFechaLimiteConfirmacion
	}

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDate unaFechaLimiteConfirmacion) {
		this.nombre = unNombre
		organizador = unOrganizador
		locacion = unaLocacion
		fechaLimiteConfirmacion = unaFechaLimiteConfirmacion
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
	def cancelarEvento(){}
	def esExitoso() {}

	def esUnFracaso() {}

	def fechaAnteriorALaLimite() { today <= LocalDate.from(this.fechaLimiteConfirmacion) }

}

@Accessors
class EventoAbierto extends Evento {
	int edadMinima
	double precioEntrada
	Set<Entrada> entradasVendidas
	Entrada nuevaEntrada

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDateTime unaFechaInicio,LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		super(unNombre, unOrganizador, unaLocacion, unaFechaLimiteConfirmacion)
		edadMinima = unaEdadMinima
		precioEntrada = unPrecioEntrada
	}
	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion,  LocalDate unaFechaLimiteConfirmacion, int unaEdadMinima, double unPrecioEntrada) {
		super(unNombre, unOrganizador, unaLocacion, unaFechaLimiteConfirmacion)
		edadMinima = unaEdadMinima
		precioEntrada = unPrecioEntrada
	}
	def comprarEntrada(Usuario elComprador) { // chequea condiciones
		if ((elComprador.edad() > this.edadMinima) && this.fechaAnteriorALaLimite() && this.hayEntradasDisponibles()) {
			generarEntrada(elComprador)
		} else
			elComprador.recibirMensaje("No se  cumplen las condiciones de compra de la entrada ")

	}

	def generarEntrada(Usuario elComprador) { // llega aca si las condiciones de compra se cumplen
		nuevaEntrada = new Entrada(this, elComprador)
		registrarCompraEnEvento(nuevaEntrada)
		registrarCompraEnUsuario(nuevaEntrada, elComprador)

	}

	def registrarCompraEnEvento(Entrada nuevaEntrada) {
		entradasVendidas.add(nuevaEntrada)

	}

	def registrarCompraEnUsuario(Entrada nuevaEntrada, Usuario elComprador) {
		elComprador.entradaComprada.add(nuevaEntrada)

	}
	//el organizador manda la orden a determinado evento si esta autorizado a cancelarla
	override cancelarEvento(){
		entradasVendidas.forall[ mensajesYDevolucionEntradasPorCancelacion() ]
		
	}

	override capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def boolean hayEntradasDisponibles() {
		entradasVendidas.size() < this.capacidadMaxima()
	}

	override fechaAnteriorALaLimite() { today <= LocalDate.from(fechaDeInicio) }

}

@Accessors
class EventoCerrado extends Evento {
	Set<Invitacion> invitados = newHashSet
	Invitacion nuevaInvitacion

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion,LocalDateTime unaFechaInicio,LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion,
		int unaCapacidadMaxima) {
		super(unNombre, unOrganizador, unaLocacion, unaFechaLimiteConfirmacion)
		this.capacidadMaxima = unaCapacidadMaxima
	}
		new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDate unaFechaLimiteConfirmacion,
		int unaCapacidadMaxima) {
		super(unNombre, unOrganizador, unaLocacion, unaFechaLimiteConfirmacion)
		this.capacidadMaxima = unaCapacidadMaxima
	}
	def crearInvitacionConAcompañantes(Usuario elInvitado, int unaCantidadDeAcompañantes) {
		if (hayCapacidadDisponible(unaCantidadDeAcompañantes + 1) && fechaAnteriorALaLimite()) {

			nuevaInvitacion = new Invitacion(this, elInvitado, unaCantidadDeAcompañantes)
			registrarInvitacionEnEvento(nuevaInvitacion)
			registrarInvitacionEnUsuario(nuevaInvitacion, elInvitado)

		} else
			this.organizador.recibirMensaje(
				"No se  pudo generar la invitacion del evento " + this.nombre + "para el invitado " + elInvitado +
					" con " + unaCantidadDeAcompañantes + " de acompañantes ")

	}

	def boolean hayCapacidadDisponible(int unaCantidadTotal) {
		unaCantidadTotal <= (capacidadMaxima() - cantidadPosiblesAsistentes())

	}

	def registrarInvitacionEnEvento(Invitacion nuevaInvitacion) {
		invitados.add(nuevaInvitacion)

	}

	def registrarInvitacionEnUsuario(Invitacion nuevaInvitacion, Usuario elInvitado) {
		elInvitado.recibirInvitacion(nuevaInvitacion)
		elInvitado.recibirMensaje("Fuiste invitado a" + this.nombre + ", con " + nuevaInvitacion.cantidadDeAcompañantes)

	}

	def int cantidadPosiblesAsistentes() {
		invitados.fold(0)[acum, invitados|acum + invitados.posiblesAsistentes()]
	}

}
