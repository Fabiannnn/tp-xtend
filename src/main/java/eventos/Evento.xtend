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
	LocalDate today = LocalDate.now();

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

	def esExitoso() {}

	def esUnFracaso() {}

	def fechaAnteriorALaLimite() { today <= this.fechaLimiteConfirmacion }

}

@Accessors
class EventoAbierto extends Evento {
	int edadMinima
	double precioEntrada
	Set<Entrada> entradasVendidas
	Entrada nuevaEntrada

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDate unaFechaLimiteConfirmacion,
		int unaEdadMinima, double unPrecioEntrada) {
		super(unNombre, unOrganizador, unaLocacion, unaFechaLimiteConfirmacion)
		edadMinima = unaEdadMinima
		precioEntrada = unPrecioEntrada
	}

	def comprarEntrada(Usuario elComprador) { // chequea condiciones
		if ((elComprador.edad() > this.edadMinima) && this.fechaAnteriorALaLimite() && this.hayEntradasDisponibles()) {
			generarEntrada(elComprador)
		}
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

	override capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def boolean hayEntradasDisponibles() {
		entradasVendidas.size() < this.capacidadMaxima()
	}

}

@Accessors
class EventoCerrado extends Evento {
	Set<Invitacion> invitados = newHashSet // ver como pasar a Set
	Invitacion nuevaInvitacion

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
			println("...")
	// ver como mandar string al organizador que no se mando la invitacion
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
