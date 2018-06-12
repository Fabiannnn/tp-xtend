package notificaciones

import eventos.Evento
import eventos.Usuario
import repositorio.RepositorioUsuarios

abstract class EventoObserverAC {
	//RepositorioUsuarios _repoUsuario1 = new RepositorioUsuarios

	def void notificar(Evento unEvento)
	
	def listaDeUsuariosANotificar(Usuario _Usuario, RepositorioUsuarios _repoUsuario) {
		_repoUsuario.listadoDeMisAmigos(_Usuario)
	}

	def String textoMensaje(Evento unEvento) {
		return "Invitacion Especial  al nuevo Evento " + unEvento.nombre + unEvento.fechaDeInicio
	}

	def String subjectMensaje(Evento unEvento) {
		return "Nuevo Evento " + unEvento.nombre
	}
}
