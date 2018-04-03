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
	Invitacion invitacion

	@Before
	def void init() {
		salon_SM = new Locacion("San Martin", new Point(35, 45), 16)
		usuario1 = new Usuario("Organizador1", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(40, 50))
		reunionChica = new EventoCerrado("Reunion proyecto", usuario1, salon_SM, 10)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoSinInvitados() {
		Assert.assertEquals(0, reunionChica.cantidadPosiblesAsistentes(), 0)
	}

	@Test
	def cantidadPosiblesAsistentesEventoCerradoConUnInvitadoConOnceAcompañantes() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.agregarInvitacion(invitacion)
		Assert.assertEquals(6, reunionChica.cantidadPosiblesAsistentes(), 0)
	}
	@Test
	def hayCapacidadDisponibleParaOtroInvitadoConTresAcompañantesEsFalso() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.agregarInvitacion(invitacion)

		Assert.assertTrue(reunionChica.hayCapacidadDisponible(4))
	}
	@Test
	def hayCapacidadDisponibleParaOtroInvitadoConCuatroAcompañantesEsFalso() {
		invitacion = new Invitacion(reunionChica, usuario1, 5)
		reunionChica.agregarInvitacion(invitacion)

		Assert.assertFalse(reunionChica.hayCapacidadDisponible(5))
	}
}
