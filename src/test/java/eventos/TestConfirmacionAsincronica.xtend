package eventos

import ordenes.Aceptacion
import ordenes.Rechazo
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test

@Accessors
class TestConfirmacionAsincronica extends FixtureTest {
	Invitacion invitacion

	@Test
	def invitacionAceptadaAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		val Aceptacion aceptacion = new Aceptacion(invitacion)
		usuario1.tipoDeUsuario.agregarOrdenAsincronica(reunionChica, aceptacion)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def invitacionRechazadaAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		val Rechazo rechazo = new Rechazo(invitacion)
		usuario1.tipoDeUsuario.agregarOrdenAsincronica(reunionChica, rechazo)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def invitacionAceptadayLuegoseQuiereAceptarAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		val Aceptacion aceptacion = new Aceptacion(invitacion)
		usuario1.tipoDeUsuario.agregarOrdenAsincronica(reunionChica, aceptacion)
		invitacion.aceptar(invitacion.cantidadDeAcompanantes)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def invitacionRechazadayLuegoseQuiereAceptarAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		val Aceptacion aceptacion = new Aceptacion(invitacion)
		usuario1.tipoDeUsuario.agregarOrdenAsincronica(reunionChica, aceptacion)
		invitacion.rechazar()
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def invitacionAceptadayLuegoseQuiereRechazarAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		val Rechazo rechazo = new Rechazo(invitacion)
		usuario1.tipoDeUsuario.agregarOrdenAsincronica(reunionChica, rechazo)
		invitacion.aceptar(invitacion.cantidadDeAcompanantes)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def invitacionRechazadayLuegoseQuiereRechazarAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		val Rechazo rechazo = new Rechazo(invitacion)
		usuario1.tipoDeUsuario.agregarOrdenAsincronica(reunionChica, rechazo)
		invitacion.rechazar()
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	// nuevos test de aceptacion y rechazo asincronicos:
	// #################################################//
	@Test
	def aceptacionAsincronicaDeUnaInvitacionYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.aceptacionAsincronica(invitacion)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def rechazoAsincronicoDeUnaInvitacionYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.rechazoAsincronico(invitacion)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def aceptacionyLuegoAceptacionAsincronicaYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.aceptacionAsincronica(invitacion)
		invitacion.aceptar(invitacion.cantidadDeAcompanantes)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def rechazoYLuegoAceptacionAsincronicaYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.aceptacionAsincronica(invitacion)
		invitacion.rechazar()
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def aceptacionYLuegoRechazoAsincronicoYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.rechazoAsincronico(invitacion)
		invitacion.aceptar(invitacion.cantidadDeAcompanantes)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def rechazoYLuegoRechazoAsincronicoYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.rechazoAsincronico(invitacion)
		invitacion.rechazar()
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(1, usuario1.notificaciones.size(), 0)
	}

	@Test
	def aceptacionAsincronicaYRemocionOrdenAsincronicaYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.aceptacionAsincronica(invitacion)
		usuario1.tipoDeUsuario.removerOrdenAsincronica(invitacion)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(0, usuario1.notificaciones.size(), 0)
	}

	@Test
	def rechazoAsincronicoYRemocionOrdenAsincronicaYVerificarNotificacion() {
		invitacion = new Invitacion(reunionChica, usuario1, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional

		usuario1.tipoDeUsuario.rechazoAsincronico(invitacion)
		usuario1.tipoDeUsuario.removerOrdenAsincronica(invitacion)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(0, usuario1.notificaciones.size(), 0)
	}

}
