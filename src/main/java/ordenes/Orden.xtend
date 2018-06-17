package ordenes

import eventos.Evento
import eventos.Invitacion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Orden {
	Invitacion invitacion

	new(Invitacion _invitacion) {
		this.invitacion = _invitacion
	}

	def void ejecutarOrden(Evento evento) {
		if (validar(evento)) {
			ejecutarse()
		} else {
			invitacion.enviarNotificacionAlUsuario("Orden invalida")
		}
	}

	def boolean validar(Evento evento) {
		return esElEventoCorrecto(evento) && estaPendiente()
	}

	def boolean esElEventoCorrecto(Evento evento) {
		evento == this.invitacion.getEventoCerrado()
	}

	def boolean estaPendiente() {
		invitacion.estaPendiente()
	}

	abstract def void ejecutarse()
}
