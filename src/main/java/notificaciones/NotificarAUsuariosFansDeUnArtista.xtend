package notificaciones

import eventos.Evento
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService
import repositorio.RepositorioUsuarios

@Accessors
class NotificarAUsuariosFansDeUnArtista extends EventoObserverAC {
	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
	MailService unMailServer
	Mail unMail

	List<String> Mails = newArrayList
		
	new(MailService mailService) {
	unMailServer = mailService
	}
	
	override  notificar(Evento unEvento) {	
	   	 unMail = new Mail => [
			from = unEvento.organizador.getEmail
			subject = subjectMensaje(unEvento)
			text = textoMensaje(unEvento)
		]
		
		listarUsuariosFansDeUnArtistaDelEvento(unEvento.artistas).forEach [ usuario |
			unMail.to = usuario.getEmail().toString
			unMailServer.sendMail(unMail) 
				usuario.recibirNotificacion(this.textoMensaje(unEvento))
		]
			
	}
	
	def listarUsuariosFansDeUnArtistaDelEvento(Set<String> artistas) {
		return _repoUsuario.listadoUsuariosFansDeArtistasDeUnEvento(artistas)
	}
	
}