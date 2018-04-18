package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.LocalDateTime

@Accessors
class Invitacion {
	
	EventoCerrado unEventoCerrado
	Usuario unUsuario
	int cantidadDeAcompanantes
	Boolean aceptada = null
	int cantidadDeAcompanantesConfirmados = 0

	new(EventoCerrado elEventoCerrado, Usuario elUsuario, int laCantidadDeAcompanantes) {
		unEventoCerrado = elEventoCerrado
		unUsuario = elUsuario
		cantidadDeAcompanantes = laCantidadDeAcompanantes
	}

	def rechazar() {
		this.aceptada = false
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

	def ubicacion(){
			unEventoCerrado.locacion
	}

	// Metodos de notificacion de cancelacion y postergacion de eventos
	//RAG: el .add debe estar encapsulado en Usuario			PREGUNTAR
	
	def boolean notificacionAInvitadosDeCancelacion() {
		unUsuario.agregarMensaje("El Evento " + this.unEventoCerrado + " fue cancelado")
		//this.unUsuario.mensajesGenerales.add("El Evento " + this.unEventoCerrado + " fue cancelado")
		aceptada = false
	}
	
	//RAG: el .add debe estar encapsulado en Usuario. Por qué en mayúscula?
	def NotificacionAInvitadosDePostergacion(LocalDateTime nuevaFechaInicio, LocalDateTime nuevaFechaFinalizacion,
		LocalDate NuevaFechaLimiteConfirmacion) {
		this.unUsuario.mensajesGenerales.add(
			"El Evento " + this.unEventoCerrado + " fue Postergado.  Las nueva fechas son, Inicio " + nuevaFechaInicio +
				" Finalizacion: " + nuevaFechaFinalizacion + ", Confirmacion: " + NuevaFechaLimiteConfirmacion)
	}

}
