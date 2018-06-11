package notificaciones

import eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors
import eventos.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService
import java.util.List
import repositorio.RepositorioUsuarios

@Accessors
class NotificarAContactosCercanosObserver extends EventoObserverAC{
		RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
		MailService unMailServer
		Mail unMail
//		List<String>MailsReceptores = newArrayList  //Puesto para Testear
//		List<String>MailsDistribucion = newArrayList
//		new(MailService mailService) {
//		unMailServer = mailService
//		}
	override  notificar(Evento unEvento) {
	   listaDeDistribucionQueVivenCerca(unEvento , _repoUsuario).forEach [ usuario | usuario.notificaciones.add(this.textoMensaje(unEvento))]
//	   	 unMail = new Mail => [
//			from = unEvento.organizador.getEmail
//			subject = subjectMensaje(unEvento)
//			text = textoMensaje(unEvento)
//		]
//	 	 listaDeDistribucionQueVivenCerca(unEvento, _repoUsuario).forEach [ unMailAmigo |
//			unMail.to = unMailAmigo.toString
//			unMailServer.sendMail(unMail) 
//			MailsReceptores.add(unMailAmigo.toString) // Puesto para Poder Testear
//		]
	}
	
def listaDeDistribucionQueVivenCerca(Evento unEvento, RepositorioUsuarios _repoUsuario){
	//		println (listaDeDistribucion(unEvento, _repoUsuario).filter[usuario| unEvento.locacion.estaDentroDelRadioDeCercania(usuario.coordenadas, usuario.radioDeCercania)])
	return	listaDeDistribucion(unEvento, _repoUsuario).filter[usuario| unEvento.locacion.estaDentroDelRadioDeCercania(usuario.coordenadas, usuario.radioDeCercania)]
}
	
	def listaDeDistribucion(Evento unEvento, RepositorioUsuarios _repoUsuarios) {
		return listaDeUsuariosQueSoyAmigo(unEvento.organizador, _repoUsuarios )+(unEvento.organizador.amigos)
		
	}
		def cantidadMailsEnviados() {
		return MailsReceptores.size()
	}


}


//	MailService unMailServer
//	Mail unMail
//	List<String>MailsReceptores = newArrayList  //Puesto para Testear
//List<String>MailsDistribucion = newArrayList
//	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
//	new(MailService mailService) {
//		unMailServer = mailService
//	}


//	override  notificar(Evento unEvento) {
//		listaDeUsuariosQueSoyAmigo(unEvento.organizador, _repoUsuario).forEach [ usuario | usuario.notificaciones.add(this.textoMensaje(unEvento))]

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
//	}

//	def listaDeUsuariosQueSoyAmigo(Usuario _Usuario) {
//		_repoUsuario.listadoDeMisAmigos(_Usuario)
//	}

//	def String subjectMensaje(Evento unEvento) {
//		return "Nuevo Evento " + unEvento.nombre
//	}
//
//	def String textoMensaje(Evento unEvento) {
//		return "Invitacion Especial  al nuevo Evento " + unEvento.nombre + unEvento.fechaDeInicio
//	}
	
//	def cantidadMailsEnviados() {
//		return MailsReceptores.size()
//	}
//}