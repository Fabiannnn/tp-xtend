package notificaciones

import eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class NotificacionAAmigosObserver extends EventoObserverAC {

	override notificar(Evento unEvento) {
		unEvento.amigosDelOrganizador.forEach[usuario| usuario.recibirNotificacion(this.textoMensaje(unEvento))]
	}

}
