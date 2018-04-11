package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime
import java.time.Duration
import org.uqbar.geodds.Point
import java.time.LocalDate
import java.util.Set
import java.time.Period

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
	
	LocalDate today = LocalDate.now()

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDateTime unaFechaInicio,
		LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion) {
		this.nombre = unNombre
		organizador = unOrganizador
		locacion = unaLocacion
		fechaDeInicio = unaFechaInicio
		fechaFinalizacion = unaFechaFinalizacion
		fechaLimiteConfirmacion = unaFechaLimiteConfirmacion
	}

	/*	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDate unaFechaLimiteConfirmacion) {
	 * 		this.nombre = unNombre
	 * 		organizador = unOrganizador
	 * 		locacion = unaLocacion
	 * 		fechaLimiteConfirmacion = unaFechaLimiteConfirmacion
	 }*/
	abstract def int capacidadMaxima()

	def double duracion() {
		Duration.between(fechaDeInicio, fechaFinalizacion).getSeconds() / 3600.0
	}

	abstract def void cancelarElEvento()

	def double distancia(Point ubicacion) {
		locacion.distancia(ubicacion)
	}


	def esExitoso() {}

	def esUnFracaso() {}

	def fechaAnteriorALaLimite() { 
		today <= LocalDate.from(this.fechaLimiteConfirmacion)
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

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDateTime unaFechaInicio,
		LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion, int unaEdadMinima,
		double unPrecioEntrada) {
		super(unNombre, unOrganizador, unaLocacion, unaFechaInicio, unaFechaFinalizacion, unaFechaLimiteConfirmacion)
		edadMinima = unaEdadMinima
		precioEntrada = unPrecioEntrada
	}

	/*new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDate unaFechaLimiteConfirmacion,
	 * 	int unaEdadMinima, double unPrecioEntrada) {
	 * 	super(unNombre, unOrganizador, unaLocacion, unaFechaLimiteConfirmacion)
	 * 	edadMinima = unaEdadMinima
	 * 	precioEntrada = unPrecioEntrada
	 * }
	 */
	def void comprarEntrada(Usuario elComprador) { // chequea condiciones
		if ((elComprador.edad() > this.edadMinima) && this.fechaAnteriorALaLimite() && this.hayEntradasDisponibles()) {
			generarEntrada(elComprador)
		} else
			elComprador.recibirMensaje("No se  cumplen las condiciones de compra de la entrada ")

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

	override fechaAnteriorALaLimite() { today <= LocalDate.from(fechaDeInicio) }
	
	override esExitoso(){
		(!this.cancelado  && !this.postergado && vendidasMasDel90())
	}
	
	def vendidasMasDel90(){
		entradasVendidas.filter[entradas | entradas.vigente===true].size()/entradasVendidas.size() >=0.9
	}
	override esUnFracaso(){
		entradasVendidas.filter[entradas | entradas.vigente===true].size()/capacidadMaxima() <0.5
	}

}

@Accessors
class EventoCerrado extends Evento {
	
	Set<Invitacion> invitados = newHashSet
	Set<Usuario> invitadosDelEvento = newHashSet
	int capacidadMaxima = 0
	

	new(String unNombre, Usuario unOrganizador, Locacion unaLocacion, LocalDateTime unaFechaInicio,
		LocalDateTime unaFechaFinalizacion, LocalDate unaFechaLimiteConfirmacion, int unaCapacidadMaxima) {
		super(unNombre, unOrganizador, unaLocacion, unaFechaInicio, unaFechaFinalizacion, unaFechaLimiteConfirmacion)
		this.capacidadMaxima = unaCapacidadMaxima
	}

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
		!this.cancelado  && alMenos80Aceptadas()
	}
def alMenos80Aceptadas(){
	invitados.filter[invitacion | invitacion.aceptada===true].size()/ invitados.size() >= 0.8
}
override esUnFracaso(){
		!this.cancelado  && LocalDateTime.now().isAfter(fechaFinalizacion) && menosDe50Aceptadas()
	}
def menosDe50Aceptadas(){
	invitados.filter[invitacion | invitacion.aceptada!==false].size()/ invitados.size()< 0.5
}
}
