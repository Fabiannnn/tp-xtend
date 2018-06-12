package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Test
import org.junit.Assert
import excepciones.EventoException

@Accessors
class TestConfirmacionAsincronica extends FixtureTest {
	Invitacion invitacion

	@Test
	def cantidadPosiblesAsistentesEventoCerradoConUnInvitadoConCincoAcompanantesElInvitadoRechazaAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		usuario1.definirRechazoAsincronico(invitacion)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoConUnInvitadoConCincoAcompanantesElInvitadocAceptaAsincronicamenteCon3Acompanantes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		usuario1.definirAceptacionAsincronica(invitacion, 3)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
		Assert.assertEquals(3, invitacion.cantidadDeAcompanantesConfirmados, 0)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoConUnInvitadoConCincoAcompanantesElInvitadocAceptaAsincronicamenteCon3AcompanantesYAnula() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioProfesional
		usuario1.definirAceptacionAsincronica(invitacion, 3)
		usuario1.anularOrdenAsincronica(invitacion)
		reunionChica.ejecutarOrdenesDeInvitacion()
		Assert.assertEquals(0, invitacion.cantidadDeAcompanantesConfirmados, 0)

	}

	@Test(expected=EventoException)
	def unUsuarioAmateurQuiereRechazarAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioAmateur
		usuario1.definirAceptacionAsincronica(invitacion, 3)
	}
@Test(expected=EventoException)
	def unUsuarioFreeQuiereRechazarAsincronicamente() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario1.setUsuarioFree
		usuario1.definirAceptacionAsincronica(invitacion, 3)
	}

}
