package testsObservers

import eventos.FixtureTest
import eventos.Usuario
import java.time.LocalDate
import notificaciones.NotificacionAAmigosObserver
import notificaciones.NotificarAContactosCercanosObserver
import notificaciones.NotificarAQuienSoyAmigoObserver
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.mailService.MailService
import notificaciones.NotificarAUsuariosCercanosAlEventoObserver
import notificaciones.NotificarAUsuariosFansDeUnArtista

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
		// val	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
		// val MailService _MailService = new MailService
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
		usuario3.agregarAmigoALaLista(usuario1)
		usuario1.organizarEventoAbierto(reunionAbierta)
		Assert.assertEquals(1, usuario2.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario3.notificaciones.size(), 0)
	}

	@Test
	def void unEventoAbiertoSeteaObserverNotificarAContactosCercanos_1AmigoCerca_1ContLejano() {
		// val	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
		val Usuario usuario4 = new Usuario => [
			nombreUsuario = "cuartoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(100, 50)
			radioDeCercania = 2
		]
		val Usuario usuario5 = new Usuario => [
			nombreUsuario = "QUintoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(35, 45)
			radioDeCercania = 2000
		]

		val MailService _MailService = new MailService
		val NotificarAContactosCercanosObserver unNotificarAContactosCercanos = new NotificarAContactosCercanosObserver(
			_MailService)
		unNotificarAContactosCercanos._repoUsuario = repoUsuario
		reunionAbierta.agregarEventoObserver(unNotificarAContactosCercanos)

		usuario1.setUsuarioProfesional()
		usuario1.agregarAmigoALaLista(usuario5)
		usuario4.agregarAmigoALaLista(usuario1)

		repoUsuario.create(usuario1)
		repoUsuario.create(usuario4)
		repoUsuario.create(usuario5)

		usuario1.organizarEventoAbierto(reunionAbierta)
		Assert.assertEquals(0, usuario1.notificaciones.size(), 0)
		Assert.assertEquals(0, usuario4.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario5.notificaciones.size(), 0)

	}

	@Test
	def void unEventoAbiertoSeteaObserverNotificarAContactosCercanos_1Amigolejos_1ContCerca() {
		// val	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
		val Usuario usuario4 = new Usuario => [
			nombreUsuario = "cuartoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(100, 50)
			radioDeCercania = 2
		]
//		val Usuario usuario5 = new Usuario => [
//			nombreUsuario = "QUintoUsuario"
//			email = "mail1"
//			nombreApellido = "Pepe Argento"
//			fechaNacimiento = LocalDate.of(2002, 05, 15)
//			coordenadas = new Point(35, 45)
//			radioDeCercania = 2000
//		]
		usuario2.punto = new Point(35.0, 47.0)
		usuario2.radioDeCercania = 2000000.0

		val MailService _MailService = new MailService
		val NotificarAContactosCercanosObserver unNotificarAContactosCercanos = new NotificarAContactosCercanosObserver(
			_MailService)
		unNotificarAContactosCercanos._repoUsuario = repoUsuario
		reunionAbierta.agregarEventoObserver(unNotificarAContactosCercanos)

		usuario1.setUsuarioProfesional()
		usuario1.agregarAmigoALaLista(usuario4)
		usuario2.agregarAmigoALaLista(usuario1)

		repoUsuario.create(usuario1)
		repoUsuario.create(usuario4)
		repoUsuario.create(usuario2)

		usuario1.organizarEventoAbierto(reunionAbierta)
		Assert.assertEquals(0, usuario1.notificaciones.size(), 0)
		Assert.assertEquals(0, usuario4.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario2.notificaciones.size(), 0)

	}

	@Test
	def void unEventoAbiertoSeteaObserverNotificarAContactosCercanos() {
		// val	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
		val MailService _MailService = new MailService
		val Usuario usuario4 = new Usuario => [
			nombreUsuario = "cuartoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(100, 50)
			radioDeCercania = 2
		]
		val Usuario usuario5 = new Usuario => [
			nombreUsuario = "QUintoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(35, 45)
			radioDeCercania = 2000
		]
		usuario3.nombreUsuario = "TercerUsuario"
		usuario2.punto = new Point(35.0, 47.0)
		usuario2.radioDeCercania = 2000000.0
		usuario3.radioDeCercania = 2000000.0

		val NotificarAContactosCercanosObserver unNotificarAContactosCercanos = new NotificarAContactosCercanosObserver(
			_MailService)
		usuario1.setUsuarioProfesional()
		unNotificarAContactosCercanos._repoUsuario = repoUsuario
		reunionAbierta.agregarEventoObserver(unNotificarAContactosCercanos)
		usuario1.agregarAmigoALaLista(usuario2)
		usuario1.agregarAmigoALaLista(usuario4)
		usuario1.agregarAmigoALaLista(usuario5)
		usuario4.agregarAmigoALaLista(usuario1)
		usuario3.agregarAmigoALaLista(usuario1)
		usuario5.agregarAmigoALaLista(usuario1)

		repoUsuario.create(usuario1)
		repoUsuario.create(usuario2)
		repoUsuario.create(usuario3)
		repoUsuario.create(usuario4)
		repoUsuario.create(usuario5)

		usuario1.organizarEventoAbierto(reunionAbierta)

		Assert.assertEquals(0, usuario1.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario2.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario3.notificaciones.size(), 0)
		Assert.assertEquals(0, usuario4.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario5.notificaciones.size(), 0)

	}

	@Test
	def void unEventoAbiertoSeteaObserverNotificarAUsuariosCercanosAlEvento_1UsuarioCercano() {
		val Usuario usuario4 = new Usuario => [
			nombreUsuario = "cuartoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(100, 50)
			radioDeCercania = 2
		]
		val Usuario usuario5 = new Usuario => [
			nombreUsuario = "QUintoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(35, 45)
			radioDeCercania = 2000
		]

		val NotificarAUsuariosCercanosAlEventoObserver NotificarUsuariosCercanos = new NotificarAUsuariosCercanosAlEventoObserver()

		usuario1.setUsuarioProfesional()
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario4)
		repoUsuario.create(usuario5)
		NotificarUsuariosCercanos._repoUsuario = repoUsuario
		reunionAbierta.agregarEventoObserver(NotificarUsuariosCercanos)
		usuario1.organizarEventoAbierto(reunionAbierta)
		Assert.assertEquals(0, usuario1.notificaciones.size(), 0)
		Assert.assertEquals(0, usuario4.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario5.notificaciones.size(), 0)

	}

	@Test
	def void unEventoAbiertoSeteaObserverFans2artistas3usuario2esfansotrono() {
		val Usuario usuario4 = new Usuario => [
			nombreUsuario = "cuartoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(100, 50)
			radioDeCercania = 2
		]
		val Usuario usuario5 = new Usuario => [
			nombreUsuario = "QUintoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			punto = new Point(35, 45)
			radioDeCercania = 2000
		]
		reunionAbierta.artistas.add("Madonna")
		reunionAbierta.artistas.add("Lennon")
		usuario4.fanArtistas.add("Madonna")
		usuario5.fanArtistas.add("Messi")
		usuario2.fanArtistas.add("Lennon")
		val MailService _MailService = new MailService
		val NotificarAUsuariosFansDeUnArtista NotificarAUsuariosFans = new NotificarAUsuariosFansDeUnArtista(
			_MailService)
		usuario1.setUsuarioProfesional()
		repoUsuario.create(usuario1)
		repoUsuario.create(usuario4)
		repoUsuario.create(usuario5)
		repoUsuario.create(usuario2)
		NotificarAUsuariosFans._repoUsuario = repoUsuario
		reunionAbierta.agregarEventoObserver(NotificarAUsuariosFans)
		usuario1.organizarEventoAbierto(reunionAbierta)

		Assert.assertEquals(1, usuario2.notificaciones.size(), 0)
		Assert.assertEquals(1, usuario4.notificaciones.size(), 0)
		Assert.assertEquals(0, usuario5.notificaciones.size(), 0)
	}
}
