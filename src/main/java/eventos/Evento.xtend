package eventos

import excepciones.EventoException
import java.time.Duration
import java.time.LocalDate
import java.time.LocalDateTime
import java.util.Set
import notificaciones.EventoObserverAC
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CreditCard
import org.uqbar.geodds.Point

@Accessors
abstract class Evento {
	
	String nombre
	Usuario organizador
	LocalDateTime fechaDeInicio
	LocalDateTime fechaFinalizacion
	Locacion locacion
	LocalDate fechaLimiteConfirmacion
	Set<EventoObserverAC> eventoObservers = newHashSet
	Set<String> artistas = newHashSet
	boolean cancelado = false
	boolean postergado = false
	
	abstract def boolean esUnFracaso()

	abstract def int capacidadMaxima()

	abstract def void cancelarElEvento()

	abstract def boolean esExitoso()
	
	abstract def void ejecutarOrdenesDeInvitacion()

	abstract def int cantidadAsistentes()   //agregado para eventos abiertos entradas vendidas vigentes y cerrados posibles asistentes

	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds() / 3600.0
	}
	
	def amigosDelOrganizador(){
		organizador.getAmigos()
	}
	
	def double distancia(Point ubicacion) {
		locacion.distancia(ubicacion)
	}
	def void agregarEventoObserver(EventoObserverAC eventoObserver){
		eventoObservers.add(eventoObserver)
	}
	def void notificar(){
		eventoObservers.forEach[unObserver | unObserver.notificar(this)]
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

	def boolean validarDatosEvento(){
		( validarDatosCompletos() && validarFechas())
	}

	def boolean validarFechas(){
		if(!((fechaLimiteConfirmacion< LocalDate.from(fechaDeInicio)) && (fechaDeInicio<fechaFinalizacion))){
					throw new EventoException("Fechas del evento Inconsistentes")
			} else {
				true
		}
	}

	def boolean validarDatosCompletos(){
		if ((nombre.nullOrEmpty || fechaDeInicio===null || fechaFinalizacion===null || fechaLimiteConfirmacion === null || locacion === null
		)){
			throw new EventoException("Faltan Datos en el Evento")
		}else {true}
	}
	
	abstract def boolean usuariosCercanosAlEvento(Usuario usuario) 

	override toString() {
		nombre
	}
}


@Accessors
class EventoAbierto extends Evento {
	
	int edadMinima
	double precioEntrada
	Set<Entrada> entradas = newHashSet
	

	def void comprarEntrada(Usuario elComprador) { 
		puedeComprarEntrada(elComprador)
		generarEntrada(elComprador)
	}
	
	override  ejecutarOrdenesDeInvitacion(){
		throw new EventoException("Un EventoAbierto no puede ejecutar ordenes de Invitacion")
	}

	def puedeComprarEntrada(Usuario elComprador){
		if ( !edadValida(elComprador) || !fechaAnteriorALaLimite() || !hayEntradasDisponibles()) {    //TODO revisar agregado por pago tarjeta
			throw new EventoException("No se puede Comprar la Entrada")
		}
	}

	def edadValida(Usuario elComprador) {
		return elComprador.edad() > edadMinima
	}
	
	//Metodo usado cuando mockeamos TarjetaPagos
	def void comprarConTarjetaDeCredito(Usuario elComprador, CreditCard tarjetaCredito, TarjetaPagos tarjetaPagos){
			puedeComprarEntrada(elComprador)
		tarjetaPagos.pagarEntrada(tarjetaCredito , precioEntrada)
		generarEntrada(elComprador)
	}
	
	//Metodo usado cuando mockeamos el CreditCardService
	def void comprarConLaTarjetaDeCredito(Usuario elComprador, CreditCard tarjetaCredito, TarjetaPagos tarjetaPagos){
		puedeComprarEntrada(elComprador)
		tarjetaPagos.pagarLaEntrada(tarjetaCredito , precioEntrada)
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
		entradas.forEach[entrada | entrada.cancelacionDeEvento()]
	}

	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio){
	 	super.postergarElEvento( nuevaFechaHoraInicio)
		entradas.forall[invitacion | invitacion.mensajesPorPostergacion(fechaDeInicio,fechaFinalizacion,fechaLimiteConfirmacion)]
	}
	
	override capacidadMaxima() {
		locacion.capacidadMaxima()
	}
	
	def boolean hayEntradasDisponibles() {
		entradas.size() < capacidadMaxima()
	}

	override fechaAnteriorALaLimite() { 
		LocalDate.now() <= LocalDate.from(fechaLimiteConfirmacion)
	}
	
	override esExitoso(){
		(!cancelado  && !postergado && ventaExitosa())
		!this.cancelado  && !this.postergado && ventaExitosa()
	}
	
	def ventaExitosa(){
		entradas.filter[entradas | entradas.vigente===true].size()/entradas.size() >= 0.9
	}
	
	override esUnFracaso(){
		entradas.filter[entradas | entradas.vigente===true].size()/capacidadMaxima() < 0.5
	}
	override cantidadAsistentes(){
		entradas.filter[entradas | entradas.vigente===true].size()		
	}
	
	override usuariosCercanosAlEvento(Usuario usuario) {
		locacion.estaDentroDelRadioDeCercania(usuario)
	}

}

@Accessors
class EventoCerrado extends Evento {
	
	static val COEF_EXITO = 0.9

	Set<Invitacion> invitados = newHashSet
	int capacidadMaxima = 0
	
	def  void crearInvitacion(Usuario elInvitado, int unaCantidadDeAcompanantes) {
		if (hayCapacidadDisponible(unaCantidadDeAcompanantes + 1) && fechaAnteriorALaLimite()) {
			var nuevaInvitacion = new Invitacion(this, elInvitado, unaCantidadDeAcompanantes)
			registrarInvitacionEnEvento(nuevaInvitacion)
			registrarInvitacionEnUsuario(nuevaInvitacion, elInvitado)
		} else {
		throw new EventoException("No se puede generar la invitacion")
	}
	}
	
	def getInvitadosDelEvento() {
		invitados.map[ unUsuario ].toList
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

	override def int cantidadAsistentes() {
		invitados.fold(0)[acum, invitados|acum + invitados.posiblesAsistentes()]
	}

	def int cantidadDeInvitaciones() {
		invitados.size() // si son invitaciones totales sin generar nuevas invitaciones por rechazos
	}
	
	override cancelarElEvento(){
		cancelado = true
		notificarAInvitadosCancelacion()
	}
	
	override capacidadMaxima() {
		capacidadMaxima
	}
	
	def notificarAInvitadosCancelacion(){
		invitados.filter[invitados | invitados.aceptada != false].forall[invitacion | invitacion.notificacionDeCancelacion()]
	}
	
	override postergarElEvento(LocalDateTime nuevaFechaHoraInicio){
	 	super.postergarElEvento( nuevaFechaHoraInicio)
		invitados.forall[invitacion | invitacion.NotificacionDePostergacion(fechaDeInicio,fechaFinalizacion,fechaLimiteConfirmacion)]
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
	override ejecutarOrdenesDeInvitacion(){
		val ConfirmacionAsincronica procesamientoAsincronico = new ConfirmacionAsincronica
		procesamientoAsincronico.ejecutar(this)
	}

	override usuariosCercanosAlEvento(Usuario usuario) {
		throw new EventoException("No se puede notificar al usuario.")
	}
}
