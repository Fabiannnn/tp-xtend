package eventos

import org.junit.Before
import java.time.LocalDate
import java.time.Period
import java.time.LocalDateTime
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import excepciones.EventoException

class TestDeTipoDeUsuario {
	EventoCerrado reunionGrande
	EventoCerrado reunionChica
	EventoCerrado otroEvento
	Locacion salon_SM
	Usuario usuario1
	Usuario usuario2
	UsuarioFree usuarioFree
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

		salon_SM = new Locacion => [
			nombreLugar = "San Martin"
			punto = new Point(35, 45)
			superficie = 16
		]

		usuario1 = new Usuario => [
			nombreDeUsuario = "PrimerUsuario"
			fechaDeNacimiento = LocalDate.of(2002, 05, 15)
			coordenadasDireccion = new Point(40, 50)
		]

		usuario2 = new Usuario => [
			nombreDeUsuario = "SegundoUssuario"
			fechaDeNacimiento = LocalDate.of(1900, 04, 02)
			coordenadasDireccion = new Point(45, 60)
		]

		reunionChica = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
		otroEvento = new EventoCerrado => [
			nombre = "Otra Reunion "
			organizador = usuario2
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(-1))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(1))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-1))
			capacidadMaxima = 50
		]
		reunionGrande = new EventoCerrado => [
			nombre = "Reunion++ "
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 20
		]
		usuarioFree = new UsuarioFree()
		usuario1.setUsuarioFree()

// mis variables para los tests
		unUsuario = new Usuario => [
			nombreDeUsuario = "Usuario"
			fechaDeNacimiento = LocalDate.of(2002, 05, 15)
			coordenadasDireccion = new Point(40, 50)
		]
		primerEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
		segundoEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
		tercerEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
		cuartoEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(8))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(9))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(8))
			capacidadMaxima = 10
		]

		quintoEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
		sextoEvento = new EventoCerrado => [
			nombre = "Reunion Proyecto"
			organizador = unUsuario
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
			capacidadMaxima = 10
		]
	}

	@Test
	def unUsuarioFreeQueNoTieneEventosOrganizadosNoPuedeOrganizarEventoAbierto() {
		Assert.assertFalse(
			usuarioFree.puedoOrganizarElEventoAbierto(usuario1,	LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(5))))
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
		reunionChica.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(3))
		usuario2.eventosOrganizados.add(reunionChica)
		Assert.assertFalse(usuarioFree.noSuperaElLimiteDeEventosSimultaneos(usuario2))

	}

	@Test
	def unUsuarioFreeQueTieneEventoOrganizadosVigenteyQuiereOrganizar1CerradoNoPuedeDesdeUsuario() {
		usuario2.setUsuarioFree()
		reunionChica.fechaDeInicio = LocalDateTime.of(2018, 04, 1, 8, 20)
		reunionChica.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(3))
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
		Assert.assertFalse(
			usuarioFree.puedoOrganizarElEventoAbierto(usuario1, LocalDateTime.now().plus(Period.ofDays(3)), LocalDateTime.now().plus(Period.ofDays(5))))
	}

	// Free: Pueden invitar hasta 50 personas por evento
	@Test
	def void unUsuarioFreePuedeOrganizarUnEventoCerradoCon50Personas() {
		unUsuario.setUsuarioFree()
		Assert.assertTrue(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(
				unUsuario,
				LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)),
				50
			)
		)
	}

	// Free: Pueden invitar hasta 50 personas por evento
	@Test
	def void unUsuarioFreeNoPuedeOrganizarUnEventoCerradoCon51Personas() {
		unUsuario.setUsuarioFree()
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(
				unUsuario,
				LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)),
				51
			)
		)
	}

	// Free: Solo pueden organizar un evento a la vez
	@Test
	def void unUsuarioFreeNoPuedeOrganizarMasDeUnEventoCerradoEnSimultaneo() {
		unUsuario.setUsuarioFree()
		unUsuario.agregarEventoCerrado(primerEvento)
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(unUsuario, LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)), 50))
	}

	// Free: un máximo de 3 eventos mensuales  dE ACUERDO A LA FECHA PUEDE FALLAR REVISAAR
	@Test(expected=EventoException)
	def void unUsuarioFreeNoPuedeOrganizarCuatroEventosCerradosPorMes() {
		unUsuario.setUsuarioFree()
		primerEvento.fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(-12))
		primerEvento.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(-11))
		unUsuario.agregarEventoCerrado(primerEvento)
		segundoEvento.fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(-9))
		segundoEvento.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(-8))
		unUsuario.agregarEventoCerrado(segundoEvento)
		tercerEvento.fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(-10))
		tercerEvento.fechaFinalizacion =LocalDateTime.now().plus(Period.ofDays(-10))
		unUsuario.agregarEventoCerrado(tercerEvento)
		cuartoEvento.fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(6))
		cuartoEvento.fechaFinalizacion =LocalDateTime.now().plus(Period.ofDays(6))
	unUsuario.agregarEventoCerrado(cuartoEvento)

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
	@Test  (expected=EventoException)
	def void unUsuarioAmateurNoPuedeOrganizarMasDe5EventosEnSimultaneo() {
		unUsuario.setUsuarioAmateur()
		unUsuario.agregarEventoCerrado(primerEvento)
		unUsuario.agregarEventoCerrado(segundoEvento)
		unUsuario.agregarEventoCerrado(tercerEvento)
		unUsuario.agregarEventoCerrado(cuartoEvento)
		unUsuario.agregarEventoCerrado(quintoEvento)
		unUsuario.agregarEventoCerrado(sextoEvento)
	}

	// Profesional: Pueden organizar hasta 20 eventos al mes
	@Test
	def void unUsuarioProfesionalPuedeOrganizarHasta20EventosAlMes() {
		unUsuario.setUsuarioProfesional()
		for (contador = 0; contador < cantMaxDeEventos; contador = contador + 1) {
			unUsuario.agregarEventoCerrado(
				new EventoCerrado => [
					nombre = "Otra Reunion "
					organizador = unUsuario
					locacion = salon_SM
					fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(3))
					fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(4))
					fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))
					capacidadMaxima = 100
				]
			)
		}
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(unUsuario, LocalDateTime.now().plus(Period.ofDays(3)),
				LocalDateTime.now().plus(Period.ofDays(4)), 50))
	}
}
