package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Test
import org.junit.Assert
import excepciones.EventoException
import ordenes.Aceptacion
import ordenes.Rechazo

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
}
