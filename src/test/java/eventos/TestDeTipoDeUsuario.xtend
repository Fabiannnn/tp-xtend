package eventos

import org.junit.Before
import java.time.LocalDate
import java.time.Period
import java.time.LocalDateTime
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert

class TestDeTipoDeUsuario {
	EventoCerrado reunionGrande
	EventoCerrado reunionChica
	EventoCerrado otroEvento
	Locacion salon_SM
	Usuario usuario1
	Usuario usuario2
	Invitacion invitacion
	LocalDate today = LocalDate.now()
	LocalDate hoyMasTresDias = today.plus(Period.ofDays(3))
	LocalDateTime hoyMas4Dias = LocalDateTime.of(2018, 04, 20, 8, 20)
	LocalDateTime hoyMas5Dias = LocalDateTime.of(2018, 04, 20, 8, 20)
	LocalDate fechaVencida = today.plus(Period.ofDays(-1))
	UsuarioFree usuarioFree

	@Before
	def void init() {

		salon_SM = new Locacion("San Martin", new Point(35, 45), 16)
		usuario1 = new Usuario("PrimerUsuario", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(40, 50))
		usuario2 = new Usuario("SegundoUsuario", "xx", LocalDate.of(1900, 04, 02), "donde vive", new Point(45, 60))
		reunionChica = new EventoCerrado("Reunion proyecto", usuario1, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10)
		otroEvento = new EventoCerrado("Otra Reunion ", usuario2, salon_SM, LocalDateTime.of(2018, 04, 1, 8, 20),
			LocalDateTime.of(2018, 04, 20, 8, 20), fechaVencida, 50)
		reunionGrande = new EventoCerrado("Reunion proyecto", usuario1, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 20)
		usuarioFree = new UsuarioFree()
		usuario1.setUsuarioFree()
	//	usuario2.eventosOrganizados.add(reunionChica)
	}

	@Test
	def unUsuarioFreeQueNoTieneEventosOrganizadosNoPuedeOrganizarEventoAbierto() {
		Assert.assertFalse(usuario1.tipoDeUsuario.puedoOrganizarElEventoAbierto())
	}

	@Test
	def elUsuario2TipoFreeQueNoTieneEventosOrganizadosPuedeOrganizarUnoCerradoDe50Personas() {
		usuario2.setUsuarioFree()
		Assert.assertTrue(
			usuario2.tipoDeUsuario.puedoOrganizarElEventoCerrado(usuario2, LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)), 50))
	}

	@Test
	def elUsuario2TipoFreeQueNoTieneEventosOrganizadosNoPuedeOrganizarUnoCerradoDe51Personas() {
		usuario2.setUsuarioFree()
		Assert.assertFalse(
			usuario2.tipoDeUsuario.puedoOrganizarElEventoCerrado(usuario2, LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)), 51))
	}

	@Test
	def unUsuarioFreeQueNoTieneEventosOrganizadosPuedeOrganizarUnoCerradoDe50Personas() {
		usuario2.setUsuarioFree()
		Assert.assertTrue(usuarioFree.noSuperaCapacidadTipoUsuario(50))

	}

	@Test
	def unUsuarioFreeQueNoTieneEventosOrganizadosyQuiereOrganizar1CerradoNoSuperaElLimiteDeEventosSimultaneos() {
		usuario2.setUsuarioFree()
		Assert.assertTrue(usuarioFree.noSuperaElLimiteDeEventosSimultaneos(usuario2))

	}

	@Test
	def unUsuarioFreeQueTieneEventoOrganizadosVigenteElementosDelSet() {
		usuario2.setUsuarioFree()
		usuario2.eventosOrganizados.add(otroEvento)
		Assert.assertEquals(1, usuario2.eventosOrganizados.size(), 0)

	}

	@Test
	def unUsuarioFreeQueTieneEventoOrganizadosVigenteyQuiereOrganizar1CerradoNoPuede() {
		usuario2.setUsuarioFree()
		reunionChica.fechaDeInicio = LocalDateTime.of(2018, 04, 1, 8, 20)
		reunionChica.fechaFinalizacion = LocalDateTime.of(2018, 04, 20, 8, 20)
		usuario2.eventosOrganizados.add(reunionChica)
		Assert.assertFalse(usuarioFree.noSuperaElLimiteDeEventosSimultaneos(usuario2))

	}

	@Test
	def unUsuarioFreeQueTieneEventoOrganizadosVigenteyQuiereOrganizar1CerradoNoPuedeDesdeUsuario() {
		usuario2.setUsuarioFree()
		reunionChica.fechaDeInicio = LocalDateTime.of(2018, 04, 1, 8, 20)
		reunionChica.fechaFinalizacion = LocalDateTime.of(2018, 04, 20, 8, 20)
		usuario2.eventosOrganizados.add(reunionChica)
		Assert.assertFalse(
			usuario2.tipoDeUsuario.puedoOrganizarElEventoCerrado(usuario2, LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)), 50))

	}
}
