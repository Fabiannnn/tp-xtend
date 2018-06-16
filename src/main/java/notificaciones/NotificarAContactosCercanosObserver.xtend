package notificaciones

import eventos.Evento
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService
import repositorio.RepositorioUsuarios

@Accessors
class NotificarAContactosCercanosObserver extends EventoObserverAC {
	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
	MailService unMailServer
	Mail unMail
	Set<String> MailsDistribucion = newHashSet

	new(MailService mailService) {
		unMailServer = mailService
	}

	override notificar(Evento unEvento) {
		mandarNotificacion(unEvento)
		mandarMail(unEvento)
	}

	def void mandarNotificacion(Evento unEvento) {
		listaDeDistribucionQueVivenCerca(unEvento, _repoUsuario).forEach [ usuario |
			usuario.recibirNotificacion(this.textoMensaje(unEvento))
		]
	}

	def void mandarMail(Evento unEvento) {
		unMail = new Mail => [
			from = unEvento.organizador.getEmail
			subject = subjectMensaje(unEvento)
			text = textoMensaje(unEvento)
		]
		listaDeDistribucionQueVivenCerca(unEvento, _repoUsuario).forEach [ unUsuario |
			unMail.to = unUsuario.getEmail().toString
			unMailServer.sendMail(unMail)
		]
	}

	def listaDeDistribucionQueVivenCerca(Evento unEvento, RepositorioUsuarios _repoUsuario) {
		return listaDeDistribucion(unEvento, _repoUsuario).filter[usuario|unEvento.usuariosCercanosAlEvento(usuario)]
	}

	def listaDeDistribucion(Evento unEvento, RepositorioUsuarios _repoUsuarios) {
		listaDeUsuariosANotificar(unEvento.organizador, _repoUsuarios) + (unEvento.amigosDelOrganizador) // TODO mandar la responsabilidad del repo
	}
}
