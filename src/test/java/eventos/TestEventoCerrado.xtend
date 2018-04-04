package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test

import org.uqbar.geodds.Point
import java.time.LocalDate

class TestEventoCerrado {
	EventoCerrado reunionChica
	Locacion salon_SM
	Usuario usuario1
	Usuario usuario2
	Invitacion invitacion

	@Before
	def void init() {
		salon_SM = new Locacion("San Martin", new Point(35, 45), 16)
		usuario1 = new Usuario("PrimerUsuario", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(40, 50))
		usuario2 = new Usuario("SegundoUsuario", "xx", LocalDate.of(1974, 11, 03), "donde vive", new Point(45, 60))
		reunionChica = new EventoCerrado("Reunion proyecto", usuario1, salon_SM, 10)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoSinInvitados() {
		Assert.assertEquals(0, reunionChica.cantidadPosiblesAsistentes(), 0)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoConUnInvitadoConOnceAcompañantes() {
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
}
