package notificaciones

import eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import repositorio.RepositorioUsuarios

@Accessors
class NotificarAUsuariosCercanosAlEventoObserver extends EventoObserverAC {
	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios

	override notificar(Evento unEvento) {
		listaDeUsuariosCercanos(unEvento, _repoUsuario).forEach [ usuario |
			usuario.notificaciones.add(this.textoMensaje(unEvento))
		]
	}
	
	def listaDeUsuariosCercanos(Evento unEvento, RepositorioUsuarios _repoUsuario) {
		_repoUsuario.listadoUsuariosCercanosEvento(unEvento)
	}
}