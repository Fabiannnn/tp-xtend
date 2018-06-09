package notificaciones

import eventos.Evento
import eventos.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService

@Accessors
class NotificacionAAmigosObserver implements EventoObserver {
	MailService unMailServer
	Mail unMail

	new(MailService mailService) {
		unMailServer = mailService
	}

	override notificar(Evento unEvento) {
		unMail = new Mail => [
			from = unEvento.organizador.getEmail
			subject = subjectMensaje(unEvento)
			text = textoMensaje(unEvento)
		]

		listaDeAmigosMails(unEvento.organizador).forEach [ unMailAmigo |
			unMail.to = unMailAmigo
	//		unMailServer.sendMail(unMail)   TODO  habilitar sacar el println y mockear en el test el envio de mail
		println (unMailAmigo)
		]
	}

	def listaDeAmigosMails(Usuario unUsuario) {
		unUsuario.getAmigos.map[amigo|amigo.getEmail()]
	}

	def String subjectMensaje(Evento unEvento) {
		return "Nuevo Evento " + unEvento.nombre

	}

	def String textoMensaje(Evento unEvento) {
		return "Invitacion Especial para mis Amigos al nuevo Evento " + unEvento.nombre + unEvento.fechaDeInicio

	}

}
