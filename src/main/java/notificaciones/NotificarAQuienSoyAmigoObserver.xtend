package notificaciones

import eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import repositorio.RepositorioUsuarios

@Accessors
class NotificarAQuienSoyAmigoObserver extends EventoObserverAC {
//	MailService unMailServer
//	Mail unMail
//	List<String>MailsReceptores = newArrayList  //Puesto para Testear
//List<String>MailsDistribucion = newArrayList
	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios

//	new(MailService mailService) {
//		unMailServer = mailService
//	}
	override notificar(Evento unEvento) {
		listaDeUsuariosANotificar(unEvento.organizador, _repoUsuario).forEach [ usuario |
			usuario.notificaciones.add(this.textoMensaje(unEvento))
		]

//	 unMail = new Mail => [
//			from = unEvento.organizador.getEmail
//			subject = subjectMensaje(unEvento)
//			text = textoMensaje(unEvento)
//		]
//		listaDeMails( unEvento.organizador).forEach [ unMailAmigo |		
//			unMail.to = unMailAmigo
//			unMailServer.sendMail(unMail) //  TODO  habilitar sacar el println  en el test el envio de mai
//
//			MailsReceptores.add(unMailAmigo) // Puesto para Poder Testear
//			
//		]
	}

//	def listaDeUsuariosANotificar(Usuario _Usuario) {
//		_repoUsuario.listadoDeMisAmigos(_Usuario)
//	}
//	def String subjectMensaje(Evento unEvento) {
//		return "Nuevo Evento " + unEvento.nombre
//	}
//	def String textoMensaje(Evento unEvento) {
//		return "Invitacion Especial  al nuevo Evento " + unEvento.nombre + unEvento.fechaDeInicio
//	}
//	
//	def cantidadMailsEnviados() {
//		return MailsReceptores.size()
//	}
}
