package notificaciones

import eventos.Evento
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class NotificacionAAmigosObserver extends EventoObserverAC {
//	MailService unMailServer
//	Mail unMail
//	List<String>MailsReceptores = newArrayList  //Puesto para Testear
//
//	new(MailService mailService) {
//		unMailServer = mailService
//	}
	override notificar(Evento unEvento) {
		unEvento.organizador.amigos.forEach[usuario|usuario.notificaciones.add(this.textoMensaje(unEvento))]

//		unMail = new Mail => [
//			from = unEvento.organizador.getEmail
//			subject = subjectMensaje(unEvento)
//			text = textoMensaje(unEvento)
//		]
//		listaDeAmigosMails(unEvento.organizador).forEach [ unMailAmigo |
//			unMail.to = unMailAmigo
//			unMailServer.sendMail(unMail) //  TODO  habilitar sacar el println  en el test el envio de mail
	// MailsReceptores.add(unMailAmigo) // Puesto para Poder Testear
	}

//	def listaDeAmigosMails(Usuario unUsuario) {
//		unUsuario.getAmigos.map[amigo|amigo.getEmail()]
//	}
//
//	def String subjectMensaje(Evento unEvento) {
//		return "Nuevo Evento " + unEvento.nombre
//	}
//
//	def String textoMensaje(Evento unEvento) {
//		return "Invitacion Especial para mis Amigos al nuevo Evento " + unEvento.nombre + unEvento.fechaDeInicio
//	}
//	
//	def cantidadMailsEnviados() {
//		return MailsReceptores.size()
//	}
}
