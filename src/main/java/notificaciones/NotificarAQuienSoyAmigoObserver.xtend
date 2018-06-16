package notificaciones

import eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import repositorio.RepositorioUsuarios

@Accessors
class NotificarAQuienSoyAmigoObserver extends EventoObserverAC {
	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios

	override notificar(Evento unEvento) {
		listaDeUsuariosANotificar(unEvento.organizador, _repoUsuario).forEach [ usuario |
			usuario.recibirNotificacion(this.textoMensaje(unEvento))
		]
	}
}
