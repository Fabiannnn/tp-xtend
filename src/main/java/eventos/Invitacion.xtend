package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.LocalDateTime

@Accessors
class Invitacion {
	EventoCerrado unEventoCerrado
	Usuario unUsuario
	int cantidadDeAcompañantes
	Boolean aceptada = null
	int cantidadDeAcompañantesConfirmados = 0
	LocalDate today = LocalDate.now();

	new(EventoCerrado elEventoCerrado, Usuario elUsuario, int laCantidadDeAcompañantes) {
		unEventoCerrado = elEventoCerrado
		unUsuario = elUsuario
		cantidadDeAcompañantes = laCantidadDeAcompañantes
	}

	def rechazar() {
		this.aceptada = false
	}

	def aceptar(int unaCantidadDeAcompañantes) {
		this.aceptada = true
		cantidadDeAcompañantesConfirmados = unaCantidadDeAcompañantes
	}

//	def aceptarMasivamente() {
//		this.aceptada = true
//		cantidadDeAcompañantesConfirmados = cantidadDeAcompañantes
//	}

	def posiblesAsistentes() {
		if (aceptada === true) {
			(cantidadDeAcompañantesConfirmados + 1)
		} else if (aceptada === false) {
			0
		} else if (aceptada === null) {
			(cantidadDeAcompañantes + 1)
		}

	}

	// Metodos de notificacion de cancelacion y postergacion de eventos
	def notificacionAInvitadosDeCancelacion() {
		this.unUsuario.mensajesGenerales.add("El Evento " + this.unEventoCerrado + " fue cancelado")
		aceptada = false
	}

	def NotificacionAInvitadosDePostergacion(LocalDateTime nuevaFechaInicio, LocalDateTime nuevaFechaFinalizacion,
		LocalDate NuevaFechaLimiteConfirmacion) {
		this.unUsuario.mensajesGenerales.add(
			"El Evento " + this.unEventoCerrado + " fue Postergado.  Las nueva fechas son, Inicio " + nuevaFechaInicio +
				" Finalizacion: " + nuevaFechaFinalizacion + ", Confirmacion: " + NuevaFechaLimiteConfirmacion)

	}

}
