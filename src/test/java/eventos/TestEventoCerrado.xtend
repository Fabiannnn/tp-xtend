package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import java.time.LocalDate
import java.time.Period
import java.time.LocalDateTime

class TestEventoCerrado {
	EventoCerrado reunionChica
	EventoCerrado otroEvento
	Locacion salon_SM
	Usuario usuario1
	Usuario usuario2
	Invitacion invitacion
	LocalDate today = LocalDate.now()
	LocalDate hoyMasTresDias = today.plus(Period.ofDays(3))
	LocalDate fechaVencida = today.plus(Period.ofDays(-1))
	LocalDateTime hoyMasTres = LocalDateTime.now().plus(Period.ofDays(3))
	LocalDateTime hoyMasCinco = LocalDateTime.now().plus(Period.ofDays(5))

	@Before
	def void init() {

		salon_SM = new Locacion("San Martin", new Point(35, 45), 16)
		usuario1 = new Usuario("PrimerUsuario", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(60, 80))
		usuario2 = new Usuario("SegundoUsuario", "xx", LocalDate.of(1900, 04, 02), "donde vive", new Point(34, 45))
		reunionChica = new EventoCerrado("Reunion proyecto", usuario1, salon_SM, hoyMasTres, hoyMasCinco,
			hoyMasTresDias, 10)
		otroEvento = new EventoCerrado("Otra Reunion ", usuario1, salon_SM, hoyMasTres, hoyMasCinco, fechaVencida, 10)

	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoSinInvitados() {
		Assert.assertEquals(0, reunionChica.cantidadPosiblesAsistentes(), 0)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoConUnInvitadoConCincoAcompañantes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		Assert.assertEquals(6, reunionChica.cantidadPosiblesAsistentes(), 0)
	}

	@Test
	def hayCapacidadDisponibleParaOtroInvitadoConTresAcompañantesEsFalso() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)

		Assert.assertTrue(reunionChica.hayCapacidadDisponible(4))
	}

	@Test
	def hayCapacidadDisponibleParaOtroInvitadoConCuatroAcompañantesEsFalso() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)

		Assert.assertFalse(reunionChica.hayCapacidadDisponible(5))
	}

	@Test
	def seisInvitadosSeInvitan4MasChequeo10PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		reunionChica.crearInvitacionConAcompañantes(usuario1, 3)
		Assert.assertEquals(10, reunionChica.cantidadPosiblesAsistentes(), 0)
	}

	@Test
	def seisInvitadosSeInvitan5MasChequeo10PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		reunionChica.crearInvitacionConAcompañantes(usuario1, 4)
		Assert.assertEquals(6, reunionChica.cantidadPosiblesAsistentes(), 0) // por que no acepto la segunda invitacion
	}

	@Test
	def seisInvitadosSeInvitan4Mas_deLaPrimerInvitacionSeConfirman3AcompañantesChequeo8PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		invitacion.aceptar(3)
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		reunionChica.crearInvitacionConAcompañantes(usuario2, 3)
		Assert.assertEquals(8, reunionChica.cantidadPosiblesAsistentes(), 0)
	}

	@Test
	def seisInvitadosSeInvitan4Mas_deLaPrimerInvitacionSeConfirman3Acompañantes_laSegundaSeRechaza_Chequeo4PosiblesAsistentes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		invitacion.aceptar(3)
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		reunionChica.registrarInvitacionEnEvento(invitacion)
		invitacion.rechazar()
		Assert.assertEquals(4, reunionChica.cantidadPosiblesAsistentes(), 0)
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

	@Test
	def seisInvitadosSeQuierenInvitarDespuesFechaLimiteSeVerificaQueNoSeCreeLaInvitacion() {
		invitacion = new Invitacion(otroEvento, usuario1, 5)
		otroEvento.registrarInvitacionEnEvento(invitacion)
		otroEvento.crearInvitacionConAcompañantes(usuario2, 3)
		Assert.assertEquals(6, otroEvento.cantidadPosiblesAsistentes(), 0)
	}


//Test para chequear aceptacion y rechazo masivo
	@Test
	def seInvitanAUsuario1_Usuario1haceRechazoMasivoPosiblesAsistentesEs0() {
		invitacion = new Invitacion(otroEvento, usuario1, 5)
		usuario1.radioDeCercania = 0.3
		usuario1.rechazoMasivo()
		Assert.assertEquals(0, otroEvento.cantidadPosiblesAsistentes(), 0)
	}


	@Test
	def seInvitanAUsuario1_con3AcompañantesUsuario1hacerAceptacionMasivaPosiblesAsistentesEs0() {
		invitacion = new Invitacion(otroEvento, usuario1, 3)
		usuario1.radioDeCercania = 3
		usuario1.aceptacionMasiva()
		Assert.assertEquals(0, otroEvento.cantidadPosiblesAsistentes(), 0)
	}
	
		@Test
	def seInvitanAUsuario1_con3AcompañantesUsuario1EsAmigoDelOrganizadorTrue() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		usuario2.agregarAmigoALaLista(usuario1)		
		usuario2.aceptacionMasiva()
		Assert.assertTrue(usuario2.elOrganizadorEsAmigo(invitacion))
	}	
	
		@Test
	def seInvitaAlUsuario2_con3AcompañantesUsuario1EsAmigoDelOrganizadorDebeAceptarMasivamente() {
		invitacion = new Invitacion(reunionChica, usuario2, 3)
		usuario2.radioDeCercania =0
		usuario2.agregarAmigoALaLista(usuario1)		
		usuario2.voyAAceptarla(invitacion)//AceptaPorAmigoOrganizador
		Assert.assertEquals(3, invitacion.cantidadDeAcompañantesConfirmados ,0)
	}	
		@Test
	def seInvitanAUsuario2_con3AcompañantesUsuario2hacerAceptacionMasivaAcompComfirmados3() {
		invitacion = new Invitacion(otroEvento, usuario2, 3)
		usuario2.radioDeCercania = 3000000.00//acepta por radio de cercania
		usuario2.voyAAceptarla(invitacion)
		Assert.assertEquals(3,invitacion.cantidadDeAcompañantesConfirmados,0)
	}
			@Test
	def pruebaDeAceptarInvitacionDirectaPasandoLaInvitacion() {
		invitacion = new Invitacion(otroEvento, usuario2, 3)
		invitacion.aceptar(invitacion.cantidadDeAcompañantes)
		Assert.assertEquals(3,invitacion.cantidadDeAcompañantesConfirmados, 0)
	}
//				@Test
//	def 1amigoMasyAceptaMasivamente() {
//		otroEvento.crearInvitacion(usuario2, 3)
//		invitacion.aceptar(invitacion.cantidadDeAcompañantes)
//		Assert.assertEquals(3,invitacion.cantidadDeAcompañantesConfirmados, 0)
//	}
}			






