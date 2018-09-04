package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.LocalDateTime
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Invitacion {

	EventoCerrado unEventoCerrado
	Usuario unUsuario
	int cantidadDeAcompanantes
	Boolean aceptada = null
	int cantidadDeAcompanantesConfirmados = 0
	Boolean asincronico = null

	new(EventoCerrado elEventoCerrado, Usuario elUsuario, int laCantidadDeAcompanantes) { // clase de ordenes para aceptar y rechazar 
		unEventoCerrado = elEventoCerrado
		unUsuario = elUsuario
		cantidadDeAcompanantes = laCantidadDeAcompanantes
	}
	def  estaAceptada(){
		aceptada
	}

	def verificaRechazo(Usuario _usuario) {
		if (this.unUsuario == _usuario && fechaParaConfirmar()) {
			rechazar()
		}
	}

	def rechazar() {
		aceptada = false
	}

	def getUsuario() {
		unUsuario
	}

	def getEventoCerrado() {
		return unEventoCerrado
	}

	def estaPendiente() {
		return aceptada === null
	}

	def aceptarseCompleto() {
		aceptada = true
		cantidadDeAcompanantesConfirmados = cantidadDeAcompanantes
	}

	def enviarNotificacionAlUsuario(String textoNotificacion) {
		this.usuario.recibirNotificacion(textoNotificacion)
	}

	def boolean fechaParaConfirmar() {
		unEventoCerrado.fechaAnteriorALaLimite()
	}

	def verificaAceptacion(Usuario _usuario, int _cantidadAcompanantes) {
		if (this.unUsuario == _usuario && (this.cantidadDeAcompanantes >= _cantidadAcompanantes) &&
			this.fechaParaConfirmar()) {
			aceptar(_cantidadAcompanantes)
		}
	}

	def aceptar(int unaCantidadDeAcompanantes) {
		this.aceptada = true
		cantidadDeAcompanantesConfirmados = unaCantidadDeAcompanantes
	}

	def posiblesAsistentes() {
		if (aceptada === true) {
			(cantidadDeAcompanantesConfirmados + 1)
		} else if (aceptada === false) {
			0
		} else if (aceptada === null) {
			(cantidadDeAcompanantes + 1)
		}
	}

	def ubicacion() {
		unEventoCerrado.locacion
	}

// Metodos de notificacion de cancelacion y postergacion de eventos
	def boolean notificacionDeCancelacion() {
		unUsuario.agregarMensaje("El Evento " + this.unEventoCerrado + " fue cancelado")
		aceptada = false
	}

	def NotificacionDePostergacion(LocalDateTime nuevaFechaInicio, LocalDateTime nuevaFechaFinalizacion,
		LocalDate NuevaFechaLimiteConfirmacion) {
		unUsuario.agregarMensaje(
			"El Evento " + unEventoCerrado + " fue Postergado.  Las nueva fechas son, Inicio " + nuevaFechaInicio +
				" Finalizacion: " + nuevaFechaFinalizacion + ", Confirmacion: " + NuevaFechaLimiteConfirmacion)
	}
}
