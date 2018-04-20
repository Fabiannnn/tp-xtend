package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import java.time.LocalDate
import java.time.Period
import java.time.LocalDateTime
import excepciones.EventoException

class TestEventoCerrado {
	EventoCerrado reunionChica
	EventoCerrado otroEvento
	Locacion salon_SM
	Usuario usuario1
	Usuario usuario2
	Invitacion invitacion

	@Before
	def void init() {

		salon_SM = new Locacion => [
			nombreLugar = "San Martin"
			punto = new Point(35, 45)
			superficie = 16
		]
		usuario1 = new Usuario => [
			fechaDeNacimiento = LocalDate.of(2002, 05, 15)
			coordenadasDireccion = new Point(60, 80)
		]
		usuario2 = new Usuario => [
			fechaDeNacimiento = LocalDate.of(1900, 04, 02)
			coordenadasDireccion = new Point(34, 45)
			esAntisocial=false
		]
		reunionChica = new EventoCerrado => [
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(5))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]

		otroEvento = new EventoCerrado => [
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(5))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
			capacidadMaxima = 10
		]
	}

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

//	@Test
//	def seisInvitadosSeInvitan5MasChequeo10PosiblesAsistentes() {
//		invitacion = new Invitacion(reunionChica, usuario1, 5)
//		reunionChica.registrarInvitacionEnEvento(invitacion)
//		reunionChica.crearInvitacionConAcompanantes(usuario1, 4)
//		Assert.assertEquals(6, reunionChica.cantidadPosiblesAsistentes(), 0) // por que no acepto la segunda invitacion
//	}

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

	@Test (expected=EventoException)
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
	def seInvitaAlUsuario2_con3AcompanantesUsuario1EsAmigoDelOrganizadorDebeAceptarMasivamente() {
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

//	@Test
//	def unAmigoMasyAceptaMasivamente() {
//		invitacion = new Invitacion(otroEvento, usuario2, 3)
//		otroEvento.crearInvitacionConAcompanantes(usuario2, 3)
//		usuario2.agregarAmigoALaLista(usuario1)
//		usuario2.aceptacionMasiva()
//		Assert.assertNull(invitacion.aceptada)
//	}	
//	
}
	