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
	LocalDate hoyMasTresDias = LocalDate.now().plus(Period.ofDays(3))
	LocalDate fechaVencida = LocalDate.now().plus(Period.ofDays(-1))
	UsuarioFree usuarioFree

	// mis variables para los tests
	Usuario unUsuario
	EventoCerrado primerEvento
	EventoCerrado segundoEvento
	EventoCerrado tercerEvento
	EventoCerrado cuartoEvento
	EventoCerrado quintoEvento
	EventoCerrado sextoEvento

	int cantMaxDeEventos = 20
	int contador

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
		// usuario2.eventosOrganizados.add(reunionChica)
		// mis variables para los tests
		unUsuario = new Usuario("unUsuario", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(40, 50))
		primerEvento = new EventoCerrado("Reunion proyecto", unUsuario, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10)

		segundoEvento = new EventoCerrado("Reunion proyecto", unUsuario, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10)

		tercerEvento = new EventoCerrado("Reunion proyecto", unUsuario, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10)

		cuartoEvento = new EventoCerrado("Reunion proyecto", unUsuario, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10)

		quintoEvento = new EventoCerrado("Reunion proyecto", unUsuario, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10)

		sextoEvento = new EventoCerrado("Reunion proyecto", unUsuario, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10)
	}

	@Test
	def unUsuarioFreeQueNoTieneEventosOrganizadosNoPuedeOrganizarEventoAbierto() {
		Assert.assertFalse(usuarioFree.puedoOrganizarElEventoAbierto)
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

// mis tests
	// Free: No pueden organizar eventos abiertos
	@Test
	def void unUsuarioFreeNoPuedeOrganizarUnEventoAbierto() {
		unUsuario.setUsuarioFree()
		Assert.assertFalse(usuarioFree.puedoOrganizarElEventoAbierto)
	}

	// Free: Pueden invitar hasta 50 personas por evento
	@Test
	def void unUsuarioFreePuedeOrganizarUnEventoCerradoCon50Personas() {
		unUsuario.setUsuarioFree()
		Assert.assertTrue(unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(
			unUsuario,
			LocalDateTime.now().plus(Period.ofDays(3)),
			LocalDateTime.now().plus(Period.ofDays(4)),
			50
		))
	}

	// Free: Pueden invitar hasta 50 personas por evento
	@Test
	def void unUsuarioFreeNoPuedeOrganizarUnEventoCerradoCon51Personas() {
		unUsuario.setUsuarioFree()
		Assert.assertFalse(unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(
			unUsuario,
			LocalDateTime.now().plus(Period.ofDays(3)),
			LocalDateTime.now().plus(Period.ofDays(4)),
			51
		))
	}

	// Free: Solo pueden organizar un evento a la vez
	@Test
	def void unUsuarioFreeNoPuedeOrganizarMasDeUnEventoCerradoEnSimultaneo() {
		unUsuario.setUsuarioFree()
		unUsuario.agregarEventoCerrado(primerEvento)
		Assert.assertFalse(unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(
			unUsuario,
			LocalDateTime.now().plus(Period.ofDays(3)),
			LocalDateTime.now().plus(Period.ofDays(4)),
			50
		))
	}

	// Free: un máximo de 3 eventos mensuales
	@Test
	def void unUsuarioFreePuedeOrganizarTresEventosCerradosPorMes() {
		unUsuario.setUsuarioFree()
		primerEvento.fechaDeInicio = LocalDateTime.of(2018, 04, 1, 8, 20)
		primerEvento.fechaFinalizacion = LocalDateTime.of(2018, 04, 3, 8, 20)
		unUsuario.agregarEventoCerrado(primerEvento)
		segundoEvento.fechaDeInicio = LocalDateTime.of(2018, 04, 4, 8, 20)
		segundoEvento.fechaFinalizacion = LocalDateTime.of(2018, 04, 6, 8, 20)
		unUsuario.agregarEventoCerrado(segundoEvento)
		tercerEvento.fechaDeInicio = LocalDateTime.of(2018, 04, 7, 8, 20)
		tercerEvento.fechaFinalizacion = LocalDateTime.of(2018, 04, 9, 8, 20)
		unUsuario.agregarEventoCerrado(tercerEvento)
		cuartoEvento.fechaDeInicio = LocalDateTime.of(2018, 04, 10, 8, 20)
		cuartoEvento.fechaFinalizacion = LocalDateTime.of(2018, 04, 12, 8, 20)
		Assert.assertFalse(unUsuario.agregarEventoCerrado(cuartoEvento))
	}

	// Free: No puede cancelar eventos
	@Test
	def void unUsuarioFreeNoPuedeCancelarEventos() {
		unUsuario.setUsuarioFree()
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedeCancelarEventos()
		)
	}

	// Free: No puede postergar eventos
	@Test
	def void unUsuarioFreeNoPuedePostergarEventos() {
		unUsuario.setUsuarioFree()
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedePostergarEventos()
		)
	}

	// Amateur:  Pueden organizar hasta 5 eventos eventos en simultáneo
	@Test
	def void unUsuarioAmateurPuedeOrganizarHasta5EventosEnSimultaneo() {
		unUsuario.setUsuarioAmateur()
		unUsuario.agregarEventoCerrado(primerEvento)
		unUsuario.agregarEventoCerrado(segundoEvento)
		unUsuario.agregarEventoCerrado(tercerEvento)
		unUsuario.agregarEventoCerrado(cuartoEvento)
		Assert.assertTrue(
			unUsuario.agregarEventoCerrado(quintoEvento)
		)
	}

	// Amateur:  Pueden organizar hasta 5 eventos eventos en simultáneo
	@Test
	def void unUsuarioAmateurNoPuedeOrganizarMasDe5EventosEnSimultaneo() {
		unUsuario.setUsuarioAmateur()
		unUsuario.agregarEventoCerrado(primerEvento)
		unUsuario.agregarEventoCerrado(segundoEvento)
		unUsuario.agregarEventoCerrado(tercerEvento)
		unUsuario.agregarEventoCerrado(cuartoEvento)
		unUsuario.agregarEventoCerrado(quintoEvento)
		Assert.assertFalse(
			unUsuario.agregarEventoCerrado(sextoEvento)
		)
	}

	// Profesional: Pueden organizar hasta 20 eventos al mes
	@Test
	def void unUsuarioProfesionalPuedeOrganizarHasta20EventosAlMes() {
		unUsuario.setUsuarioProfesional()
		for (contador = 0; contador < cantMaxDeEventos; contador = contador + 1) {
			unUsuario.agregarEventoCerrado(
				new EventoCerrado("Reunion proyecto", unUsuario, salon_SM, LocalDateTime.now().plus(Period.ofDays(3)),
					LocalDateTime.now().plus(Period.ofDays(4)), hoyMasTresDias, 10))
		}
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(unUsuario, LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)), 50))
	}
}
