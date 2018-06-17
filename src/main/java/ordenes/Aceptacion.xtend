package ordenes

import eventos.Invitacion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Aceptacion extends Orden {
	
	new(Invitacion _invitacion) {
		super(_invitacion)
	}
	
	override ejecutarse() {
		invitacion.aceptar(invitacion.cantidadDeAcompanantes)
		invitacion.getUsuario().recibirNotificacion(mensajeAceptacion())
	}
	
	def mensajeAceptacion() {
		return "Su invitacion fue aceptada."
	}
}