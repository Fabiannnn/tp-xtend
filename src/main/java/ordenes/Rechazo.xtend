package ordenes

import eventos.Invitacion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Rechazo extends Orden {

	new(Invitacion _invitacion) {
		super(_invitacion)
	}

	override ejecutarse() {
		invitacion.rechazar()
		invitacion.getUsuario().recibirNotificacion(mensajeRechazo())
	}
	
	def mensajeRechazo() {
		return "Su invitacion fue rechazada."
	}

}
