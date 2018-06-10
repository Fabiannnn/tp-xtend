package testsObservers

import eventos.FixtureTest
import notificaciones.NotificacionAAmigosObserver
import notificaciones.NotificarAQuienSoyAmigoObserver
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import org.uqbar.mailService.MailService

@Accessors
class TestsNotificacionesObservers extends FixtureTest {
	
	// testeo de org evento Abierto observer lista a amigos El mailservice esta comentado tira un println
	@Test
	def void unEventoAbiertoSeteaObserverDeAmigos() {
//		val MailService _MailService = new MailService
		val NotificacionAAmigosObserver unNotificarAAmigos = new NotificacionAAmigosObserver()
		usuario1.setUsuarioProfesional()
		usuario1.agregarAmigoALaLista(usuario2)
		reunionAbierta.agregarEventoObserver(unNotificarAAmigos)
		usuario1.organizarEventoAbierto(reunionAbierta)
		Assert.assertEquals(1, usuario2.notificaciones.size(), 0)
	}
	

	@Test
	def void unEventoAbiertoSeteaObserverNotificarAQuienSoyAmigoObserver() {
		//val MailService _MailService = new MailService
		val NotificarAQuienSoyAmigoObserver unNotificarAQuienMeTieneDeAmigo = new NotificarAQuienSoyAmigoObserver()
		usuario1.setUsuarioProfesional()
		usuario1.agregarAmigoALaLista(usuario2)
		unNotificarAQuienMeTieneDeAmigo._repoUsuario = repoUsuario
		reunionAbierta.agregarEventoObserver(unNotificarAQuienMeTieneDeAmigo)
		usuario2.agregarAmigoALaLista(usuario1)
		usuario3.agregarAmigoALaLista(usuario2)
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		usuario3.nombreUsuario = "TercerUsuario"
		repoUsuario.create(usuario3)
		usuario1.organizarEventoAbierto(reunionAbierta)
		Assert.assertEquals(1, usuario2.notificaciones.size(), 0)
		Assert.assertEquals(0, usuario3.notificaciones.size(), 0)
	}

}
