package eventos

import java.time.Duration

import java.time.LocalDate
import java.time.LocalDateTime
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import excepciones.NoSePuedeInvitarException

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
	
	abstract def boolean esUnFracaso()
	abstract def int capacidadMaxima()
	abstract def void cancelarElEvento()
	abstract def boolean esExitoso()
	
	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds() / 3600.0
	}

	def double distancia(Point ubicacion) {
		locacion.distancia(ubicacion)
	}

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
		if ((elComprador.edad() > edadMinima) && fechaAnteriorALaLimite() && hayEntradasDisponibles()) {
			generarEntrada(elComprador)
		} 
		//si no se cumple tira una excepcion ver test
//		 else {
//			elComprador.recibirMensaje("No se  cumplen las condiciones de compra de la entrada ")
//		}

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
		entradasVendidas.forEach[entrada | entrada.cancelacionDeEvento()]
	}

	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio){
	 	super.postergarElEvento( nuevaFechaHoraInicio)
		entradasVendidas.forall[invitacion | invitacion.mensajesPorPostergacion(fechaDeInicio,fechaFinalizacion,fechaLimiteConfirmacion)]
	}
	
	override capacidadMaxima() {
		locacion.capacidadMaxima()
	}
	
	def boolean hayEntradasDisponibles() {
		entradasVendidas.size() < capacidadMaxima()
	}

	override fechaAnteriorALaLimite() { 
		LocalDate.now() <= LocalDate.from(fechaDeInicio)
	}
	
	override esExitoso(){
		(!cancelado  && !postergado && ventaExitosa())
		!this.cancelado  && !this.postergado && ventaExitosa()
	}
	
	def ventaExitosa(){
		val coefExito=0.9 //RAG: es necesaria esta variable?  NO decidimos separarla del cálculo bajo la premisa de que queda más visible al igual que se habían puesto los booleanos en los tipo de usuario
		entradasVendidas.filter[entradas | entradas.vigente===true].size()/entradasVendidas.size() >= coefExito
	}
	
	override esUnFracaso(){
		val coefFracaso=0.5 //RAG: es necesaria esta variable? 
		entradasVendidas.filter[entradas | entradas.vigente===true].size()/capacidadMaxima() < coefFracaso
	}

}

@Accessors
class EventoCerrado extends Evento {
	
	static val COEF_EXITO = 0.9

	Set<Invitacion> invitados = newHashSet
	int capacidadMaxima = 0
	
	//RAG: no es necesario aclarar que es con acompanantes. Podría llamarse crearInvitacion() o invitar()
	def  void crearInvitacionConAcompanantes(Usuario elInvitado, int unaCantidadDeAcompanantes) {
		if (hayCapacidadDisponible(unaCantidadDeAcompanantes + 1) && fechaAnteriorALaLimite()) {
			var nuevaInvitacion = new Invitacion(this, elInvitado, unaCantidadDeAcompanantes)
			registrarInvitacionEnEvento(nuevaInvitacion)
			registrarInvitacionEnUsuario(nuevaInvitacion, elInvitado)
		} else {
		throw new NoSePuedeInvitarException("No se puede generar la invitacion")
	}
	}
	
	def getInvitadosDelEvento() {
		invitados.map[ unUsuario ].toList
	}

	def boolean hayCapacidadDisponible(int unaCantidadTotal) {
		unaCantidadTotal <= (capacidadMaxima() - cantidadPosiblesAsistentes())
	}

	def registrarInvitacionEnEvento(Invitacion nuevaInvitacion) {
		invitados.add(nuevaInvitacion)
	}
	
	def registrarInvitacionEnUsuario(Invitacion nuevaInvitacion, Usuario elInvitado) {
		elInvitado.recibirInvitacion(nuevaInvitacion)
		elInvitado.agregarMensaje("Fuiste invitado a" + this.nombre + ", con " + nuevaInvitacion.cantidadDeAcompanantes) 
		//RAG: esta última línea debería estar dentro de recibirInvitacion() en Usuario
	}

	def int cantidadPosiblesAsistentes() {
		invitados.fold(0)[acum, invitados|acum + invitados.posiblesAsistentes()]
	}

	def int cantidadDeInvitacionesDadas() {
		invitados.size() // si son invitaciones totales sin generar nuevas invitaciones por rechazos
	}
	
	override cancelarElEvento(){
		cancelado = true
		notificarAInvitadosQueNoRechazaron()
	}
	
	override capacidadMaxima() {
		capacidadMaxima
	}
	
	//RAG: por qué con mayúscula?
	def notificarAInvitadosQueNoRechazaron(){
		invitados.filter[invitados | invitados.aceptada != false].forall[invitacion | invitacion.notificacionAInvitadosDeCancelacion()]
	}
	
	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio){
	 	super.postergarElEvento( nuevaFechaHoraInicio)
		invitados.forall[invitacion | invitacion.NotificacionAInvitadosDePostergacion(fechaDeInicio,fechaFinalizacion,fechaLimiteConfirmacion)]
	}

	override esExitoso(){
		!cancelado  && asistenciaExitosa()
	}

	def asistenciaExitosa(){
		invitados.filter[invitacion | invitacion.aceptada===true].size()/ invitados.size() >= COEF_EXITO
	}

	override esUnFracaso(){
		!cancelado  && LocalDateTime.now().isAfter(fechaFinalizacion) && asistenciaFracaso()
	}

	def asistenciaFracaso(){
		val coefFracaso =0.5
		invitados.filter[invitacion | invitacion.aceptada!==false].size()/ invitados.size()< coefFracaso
	}

}
