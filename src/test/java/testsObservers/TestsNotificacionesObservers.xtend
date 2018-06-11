package testsObservers

import eventos.FixtureTest
import notificaciones.EventoObserverAC
import notificaciones.NotificacionAAmigosObserver
import notificaciones.NotificarAQuienSoyAmigoObserver
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import org.uqbar.mailService.MailService
import repositorio.RepositorioUsuarios
import eventos.Usuario
import java.time.LocalDate
import org.uqbar.geodds.Point
import notificaciones.NotificarAContactosCercanosObserver
import java.util.List

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
			coordenadas = new Point(100, 50)
			radioDeCercania = 2
		]
		val Usuario usuario5 = new Usuario => [
			nombreUsuario = "QUintoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			coordenadas = new Point(35, 45)
			radioDeCercania = 2000
		]

		val NotificarAContactosCercanosObserver unNotificarAContactosCercanos = new NotificarAContactosCercanosObserver()
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
			coordenadas = new Point(100, 50)
			radioDeCercania = 2
		]
		val Usuario usuario5 = new Usuario => [
			nombreUsuario = "QUintoUsuario"
			email = "mail1"
			nombreApellido = "Pepe Argento"
			fechaNacimiento = LocalDate.of(2002, 05, 15)
			coordenadas = new Point(35, 45)
			radioDeCercania = 2000
		]
				usuario2.coordenadas = new Point(35.0, 47.0)
		usuario2.radioDeCercania = 2000000.0

		val NotificarAContactosCercanosObserver unNotificarAContactosCercanos = new NotificarAContactosCercanosObserver()
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

//	@Test
//	def void unEventoAbiertoSeteaObserverNotificarAContactosCercanos() {
//		// val	RepositorioUsuarios _repoUsuario = new RepositorioUsuarios
//		 val MailService _MailService = new MailService
//		val Usuario usuario4 = new Usuario => [
//			nombreUsuario = "cuartoUsuario"
//			email = "mail1"
//			nombreApellido = "Pepe Argento"
//			fechaNacimiento = LocalDate.of(2002, 05, 15)
//			coordenadas = new Point(100, 50)
//			radioDeCercania = 2
//		]
//		val Usuario usuario5 = new Usuario => [
//			nombreUsuario = "QUintoUsuario"
//			email = "mail1"
//			nombreApellido = "Pepe Argento"
//			fechaNacimiento = LocalDate.of(2002, 05, 15)
//			coordenadas = new Point(35, 45)
//			radioDeCercania = 2000
//		]
//		usuario3.nombreUsuario = "TercerUsuario"
//		usuario2.coordenadas = new Point(35.0, 47.0)
//		usuario2.radioDeCercania = 2000000.0
//		usuario3.radioDeCercania = 2000000.0
//		val NotificarAContactosCercanosObserver unNotificarAContactosCercanos = new NotificarAContactosCercanosObserver()
//		usuario1.setUsuarioProfesional()
//		usuario1.agregarAmigoALaLista(usuario2)
//		usuario1.agregarAmigoALaLista(usuario4)
//		unNotificarAContactosCercanos._repoUsuario = repoUsuario
//		reunionAbierta.agregarEventoObserver(unNotificarAContactosCercanos)
//		usuario1.agregarAmigoALaLista(usuario2)
//		usuario1.agregarAmigoALaLista(usuario4)		
//		usuario1.agregarAmigoALaLista(usuario5)		
//		usuario4.agregarAmigoALaLista(usuario1)
//		usuario3.agregarAmigoALaLista(usuario1)
//		usuario5.agregarAmigoALaLista(usuario1)
//	
//		repoUsuario.create(usuario1)
//		repoUsuario.create(usuario2)
//		repoUsuario.create(usuario3)
//		repoUsuario.create(usuario4)
//		repoUsuario.create(usuario5)
//
//		usuario1.organizarEventoAbierto(reunionAbierta)
//		Assert.assertEquals(0, usuario1.notificaciones.size(), 0)
//		Assert.assertEquals(1, usuario2.notificaciones.size(), 0)
//		Assert.assertEquals(1, usuario3.notificaciones.size(), 0)
//		Assert.assertEquals(0, usuario4.notificaciones.size(), 0)
//		Assert.assertEquals(1, usuario5.notificaciones.size(), 0)
//
//	}

}
