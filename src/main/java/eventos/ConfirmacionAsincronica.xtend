package eventos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ConfirmacionAsincronica {//evento cerrado tiene que tener la lista de ordenes y manejarla con try catch los mensajes
	
	def ejecutar(EventoCerrado unEvento) {
		unEvento.invitados.filter[invitacion|invitacion.aceptada === null].forEach[invitacion|chequeoAsincronicoDeInvitacion(invitacion)]
	}
	
	def chequeoAsincronicoDeInvitacion(Invitacion invitacion) {
		if (invitacion.asincronico === false){
			invitacion.verificaRechazo(invitacion.unUsuario)
		} else if (invitacion.asincronico === true) {
			invitacion.verificaAceptacion(invitacion.unUsuario, invitacion.cantidadDeAcompanantesConfirmados)
		}
		
	}

	}