package eventos

import org.junit.Assert
import org.junit.Test
import excepciones.EventoException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class TestEventoCerrado extends FixtureTest {

	Invitacion invitacion
	Invitacion invitacion2

	@Test
	def cantidadPosiblesAsistentesEventoCerradoSinInvitados() {
		Assert.assertEquals(0, reunionChica.cantidadAsistentes(), 0)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoConUnInvitadoConCincoAcompanantes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		Assert.assertEquals(6, reunionChica.cantidadAsistentes(), 0)
	}

	@Test
	def hayCapacidadDisponibleParaOtroInvitadoConTresAcompanantesEsFalso() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		Assert.assertTrue(reunionChica.hayCapacidadDisponible(4))
	}

	@Test
	def hayCapacidadDisponibleParaOtroInvitadoConCuatroAcompanantesEsFalso() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		Assert.assertFalse(reunionChica.hayCapacidadDisponible(5))
	}

	@Test
	def seisInvitadosSeInvitan4MasChequeo10PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		reunionChica.crearInvitacion(usuario1, 3)
		Assert.assertEquals(10, reunionChica.cantidadAsistentes(), 0)
	}

	@Test(expected=EventoException)
	def seisInvitadosSeInvitan5MasChequeo10PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		reunionChica.crearInvitacion(usuario2, 4)
	}

	@Test
	def seisInvitadosSeInvitan4Mas_deLaPrimerInvitacionSeConfirman3AcompanantesChequeo8PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		invitacion.aceptar(3)
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		reunionChica.crearInvitacion(usuario2, 3)
		Assert.assertEquals(8, reunionChica.cantidadAsistentes(), 0)
	}

	@Test
	def seisInvitadosSeInvitan4Mas_deLaPrimerInvitacionSeConfirman3Acompanantes_laSegundaSeRechaza_Chequeo4PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		invitacion.aceptar(3)
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		invitacion.rechazar()
		Assert.assertEquals(4, reunionChica.cantidadAsistentes(), 0)
	}

	@Test
	def seInvitan6_seQuiereAceptarYNoDejaPorFechaLimite() {
		invitacion = new Invitacion(otroEvento, usuario1, 5)
		otroEvento.registrarInvitacionEnEvento(invitacion)
		usuario1.aceptarInvitacion(invitacion, 3)
		Assert.assertNull(invitacion.aceptada)
	}

	@Test
	def seInvitan6_seQuiereRechazarYNoDejaPorFechaLimite() {
		invitacion = new Invitacion(otroEvento, usuario1, 5)
		otroEvento.registrarInvitacionEnEvento(invitacion)
		usuario1.rechazarInvitacion(invitacion)
		Assert.assertNull(invitacion.aceptada)
	}

	@Test(expected=EventoException)
	def ExcepcionSeisInvitadosSeQuierenInvitarDespuesFechaLimiteSeVerificaLaExcepcion() {
		invitacion = new Invitacion(otroEvento, usuario1, 5)
		otroEvento.registrarInvitacionEnEvento(invitacion)
		otroEvento.crearInvitacion(usuario2, 3)
	}

//Test para chequear aceptacion y rechazo masivo
	@Test
	def seInvitanAUsuario1_Usuario1haceRechazoMasivoPosiblesAsistentesEs0() {
		invitacion = new Invitacion(otroEvento, usuario1, 5)
		usuario1.radioDeCercania = 0.3
		usuario1.rechazoMasivo()
		Assert.assertEquals(0, otroEvento.cantidadAsistentes(), 0)
	}

	@Test
	def seInvitanAUsuario1_con3AcompanantesUsuario1hacerAceptacionMasivaPosiblesAsistentesEs0() {
		invitacion = new Invitacion(otroEvento, usuario1, 3)
		usuario1.radioDeCercania = 3
		usuario1.aceptacionMasiva()
		Assert.assertEquals(0, otroEvento.cantidadAsistentes(), 0)
	}

	@Test
	def seInvitanAUsuario1_con3AcompanantesUsuario1EsAmigoDelOrganizadorTrue() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		usuario2.agregarAmigoALaLista(usuario1)
		usuario2.aceptacionMasiva()
		Assert.assertTrue(usuario2.elOrganizadorEsAmigo(invitacion))
	}

	@Test
	def seInvitaAlUsuario2_con3AcompanantesUsuario1EsAmigoDelOrganizadorDebeAceptarMasivamente_seChequeaAcompConfirmados() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		usuario2.radioDeCercania = 0
		usuario2.agregarAmigoALaLista(usuario1)
		usuario2.aceptarSiCorresponde(invitacion) // AceptaPorAmigoOrganizador
		Assert.assertEquals(3, invitacion.cantidadDeAcompanantesConfirmados, 0)
	}

	@Test
	def seInvitanAUsuario2_con3AcompanantesUsuario2hacerAceptacionMasivaAcompConfirmados3() {
		invitacion = new Invitacion(otroEvento, usuario2, 3)
		usuario2.radioDeCercania = 3000000.00 // acepta por radio de cercania
		usuario2.aceptarSiCorresponde(invitacion)
		Assert.assertEquals(3, invitacion.cantidadDeAcompanantesConfirmados, 0)
	}

	@Test
	def pruebaDeAceptarInvitacionDirectaPasandoLaInvitacion() {
		invitacion = new Invitacion(otroEvento, usuario2, 3)
		invitacion.aceptar(invitacion.cantidadDeAcompanantes)
		Assert.assertEquals(3, invitacion.cantidadDeAcompanantesConfirmados, 0)
	}

	@Test // acepta por amigo organizador chequea directamente de aceptacion masiva
	def unAmigoMasyAceptaMasivamente() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		usuario2.recibirInvitacion(invitacion)
		usuario2.radioDeCercania = 0
		usuario2.agregarAmigoALaLista(usuario1)
		usuario2.aceptacionMasiva()
		Assert.assertTrue(invitacion.aceptada)
	}

	@Test // no acepta masivamente
	def noCumpleNingunaCondicionDeAceptarMasivamente() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		usuario2.recibirInvitacion(invitacion)
		usuario2.radioDeCercania = 0
		usuario2.agregarAmigoALaLista(usuario3)
		usuario2.aceptacionMasiva()
		Assert.assertNull(invitacion.aceptada)
	}

	@Test // rechazo masivo por antisocial
	def rechazoMasivoUsuarioAntisocialyFueraRadioCercania() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		usuario2.recibirInvitacion(invitacion)
		usuario2.radioDeCercania = 0
		usuario2.agregarAmigoALaLista(usuario3)
		usuario2.antisocialRechazaInvitacion(invitacion)
		Assert.assertFalse(invitacion.aceptada)
	}

	@Test // no rechazo masivo por no antisocial y un amigo
	def noRechazoMasivoUsuarioNoAntisocialyFueraRadioCercaniaPeroCon1Amigo() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		usuario2.recibirInvitacion(invitacion)
		usuario2.radioDeCercania = 0
		usuario2.agregarAmigoALaLista(usuario1)
		usuario2.noAntisocialRechazaInvitacion(invitacion)
		Assert.assertNull(invitacion.aceptada)
	}

	@Test // rechazo masivo por antisocial
	def rechazoMasivoUsuarioNoAntisocialyFueraRadioCercaniaySinAMigos() {
		invitacion2 = new Invitacion(reunionChica, usuario2, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion2)
		usuario2.recibirInvitacion(invitacion2)
		usuario2.radioDeCercania = 0
		usuario2.agregarAmigoALaLista(usuario3)
		usuario2.noAntisocialRechazaInvitacion(invitacion2)
		Assert.assertFalse(invitacion2.aceptada)
	}

	@Test
	def noRechazoMasivoUsuarioNoAntisocialyFueraRadioCercaniay1AMigos() {
		invitacion2 = new Invitacion(reunionChica, usuario2, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion2)
		usuario2.recibirInvitacion(invitacion2)
		usuario2.radioDeCercania = 0
		usuario2.agregarAmigoALaLista(usuario1)
		usuario2.noAntisocialRechazaInvitacion(invitacion2)
		Assert.assertNull(invitacion2.aceptada)
	}
}
