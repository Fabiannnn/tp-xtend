package notificaciones

import eventos.Evento
import java.util.List
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService
import repositorio.RepositorioUsuarios
import org.eclipse.xtend.lib.annotations.Accessors
import eventos.Usuario

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
		
		listarUsuariosFansDeUnArtistaDelEvento(unEvento.artistas).forEach [ unMailAmigo |
			unMail.to = unMailAmigo.toString
			unMailServer.sendMail(unMail) 
		]
			
	}
	
	def listarUsuariosFansDeUnArtistaDelEvento(List<Usuario> artistas) {
		return _repoUsuario.listadoUsuariosFansDeArtistasDeUnEvento(artistas)
	}
	
}