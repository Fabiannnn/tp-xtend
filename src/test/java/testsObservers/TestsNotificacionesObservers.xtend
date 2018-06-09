package testsObservers

import notificaciones.NotificacionAAmigosObserver
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Test
import excepciones.EventoException
import eventos.FixtureTest
import org.uqbar.mailService.MailService

@Accessors
class TestsNotificacionesObservers  extends FixtureTest {
	// testeo de org evento Abierto observer lista a amigos
	@Test
	def void unEventoAbiertoSeteaObserverDeAmigos() {
		val MailService _MailService = new MailService
		val NotificacionAAmigosObserver unNotificarAAmigos = new NotificacionAAmigosObserver(_MailService)
		usuario1.setUsuarioProfesional()
		usuario1.agregarAmigoALaLista(usuario2)
		reunionAbierta.agregarEventoObserver(unNotificarAAmigos)
		usuario1.organizarEventoAbierto(reunionAbierta)
	}

}