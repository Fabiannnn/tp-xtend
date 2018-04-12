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
	LocalDate fechaLimiteConfirmacion
	boolean cancelado = false
	boolean postergado = false
	
	abstract def int capacidadMaxima()
	
	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds() / 3600.0
	}

	abstract def void cancelarElEvento()

	def double distancia(Point ubicacion) {
		locacion.distancia(ubicacion)
	}

	abstract def boolean esExitoso()

	abstract def boolean esUnFracaso()

	def fechaAnteriorALaLimite() { 
		LocalDate.now() <= LocalDate.from(this.fechaLimiteConfirmacion)
	}

	def  void postergarElEvento(LocalDateTime nuevaFechaHoraInicio) {
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
}


@Accessors
class EventoAbierto extends Evento {
	int edadMinima
	double precioEntrada
	Set<Entrada> entradasVendidas

	def void comprarEntrada(Usuario elComprador) { // chequea condiciones
		if ((elComprador.edad() > this.edadMinima) && this.fechaAnteriorALaLimite() && this.hayEntradasDisponibles()) {
			generarEntrada(elComprador)
		} else elComprador.recibirMensaje("No se  cumplen las condiciones de compra de la entrada ")
	}

	def generarEntrada(Usuario elComprador) { // llega aca si las condiciones de compra se cumplen
		val nuevaEntrada = new Entrada(this, elComprador)
		registrarCompraEnEvento(nuevaEntrada)
		registrarCompraEnUsuario(nuevaEntrada, elComprador)
	}

	def registrarCompraEnEvento(Entrada nuevaEntrada) {
		entradasVendidas.add(nuevaEntrada)
	}

	def registrarCompraEnUsuario(Entrada nuevaEntrada, Usuario elComprador) {
		elComprador.entradaComprada.add(nuevaEntrada)
	}

	// el organizador manda la orden a determinado evento si esta autorizado a cancelarla
	override void cancelarElEvento() {
		cancelado = true
		entradasVendidas.forEach[entrada | entrada.mensajesYDevolucionEntradasPorCancelacion()]
	}

	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio){
	 	super.postergarElEvento( nuevaFechaHoraInicio)
		entradasVendidas.forall[invitacion | invitacion.mensajesPorPostergacion(fechaDeInicio,fechaFinalizacion,fechaLimiteConfirmacion)]
	}
	
	override capacidadMaxima() {
		locacion.capacidadMaxima()
	}
	
	def boolean hayEntradasDisponibles() {
		entradasVendidas.size() < this.capacidadMaxima()
	}

	override fechaAnteriorALaLimite() { LocalDate.now() <= LocalDate.from(fechaDeInicio) }
	
	override esExitoso(){
		(!this.cancelado  && !this.postergado && ventaExitosa())
	}
	
	def ventaExitosa(){
		val coefExito=0.9
		entradasVendidas.filter[entradas | entradas.vigente===true].size()/entradasVendidas.size() >= coefExito
	}
	
	override esUnFracaso(){
		val coefFracaso=0.5
		entradasVendidas.filter[entradas | entradas.vigente===true].size()/capacidadMaxima() < coefFracaso
	}

}

@Accessors
class EventoCerrado extends Evento {

	Set<Invitacion> invitados = newHashSet
	Set<Usuario> invitadosDelEvento = newHashSet
	int capacidadMaxima = 0

	def crearInvitacionConAcompañantes(Usuario elInvitado, int unaCantidadDeAcompañantes) {
		if (hayCapacidadDisponible(unaCantidadDeAcompañantes + 1) && fechaAnteriorALaLimite()) {
			var nuevaInvitacion = new Invitacion(this, elInvitado, unaCantidadDeAcompañantes)
			registrarInvitacionEnEvento(nuevaInvitacion)
			actualizarListadeUsuariosInvitados(nuevaInvitacion)
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

	def int cantidadDeInvitacionesDadas() {
		invitados.size() // si son invitaciones totales sin generar nuevas invitaciones por rechazos
	}
	
	override cancelarElEvento(){
		cancelado = true
		NotificarAInvitadosQueNoRechazaron()
	}
	
	def actualizarListadeUsuariosInvitados(Invitacion invitacion){
		invitadosDelEvento.add(invitacion.unUsuario)
	}
	
	override capacidadMaxima() {
		capacidadMaxima
	}
	
	def NotificarAInvitadosQueNoRechazaron(){
		invitados.filter[invitados | invitados.aceptada != false].forall[invitacion | invitacion.notificacionAInvitadosDeCancelacion()]
	}
	
	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio){
	 super.postergarElEvento( nuevaFechaHoraInicio)
	invitados.forall[invitacion | invitacion.NotificacionAInvitadosDePostergacion(fechaDeInicio,fechaFinalizacion,fechaLimiteConfirmacion)]
	}

	override esExitoso(){
		!this.cancelado  && asistenciaExitosa()
	}

	def asistenciaExitosa(){
	val coefExito=0.8 
	invitados.filter[invitacion | invitacion.aceptada===true].size()/ invitados.size() >= coefExito
	}

	override esUnFracaso(){
		!this.cancelado  && LocalDateTime.now().isAfter(fechaFinalizacion) && asistenciaFracaso()
	}

	def asistenciaFracaso(){
	val coefFracaso =0.5
	invitados.filter[invitacion | invitacion.aceptada!==false].size()/ invitados.size()< coefFracaso
	}

}
