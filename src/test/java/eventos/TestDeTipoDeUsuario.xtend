package eventos

import org.junit.Before
import java.time.LocalDate
import java.time.Period
import java.time.LocalDateTime
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import excepciones.EventoException
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.Month

@Accessors
class TestDeTipoDeUsuario extends FixtureTest{

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
		Assert.assertFalse(usuario2.tipoDeUsuario.puedoOrganizarElEventoCerrado(usuario2, eventoPrueba))
	}


	// Free: No pueden organizar eventos abiertos
	@Test
	def void unUsuarioFreeNoPuedeOrganizarUnEventoAbierto() {
		unUsuario.setUsuarioFree()
		Assert.assertFalse(
			usuarioFree.puedoOrganizarElEventoAbierto(usuario1, reunionAbierta))
	}

	// Free: Pueden invitar hasta 50 personas por evento
	@Test
	def void unUsuarioFreePuedeOrganizarUnEventoCerradoCon50Personas() {
		unUsuario.setUsuarioFree()
		Assert.assertTrue(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(unUsuario, cuartoEvento)
		)
	}

	// Free: Pueden invitar hasta 50 personas por evento
	@Test
	def void unUsuarioFreeNoPuedeOrganizarUnEventoCerradoCon51Personas() {
		unUsuario.setUsuarioFree()
		eventoPrueba.capacidadMaxima = 51
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(unUsuario, eventoPrueba)
		)
	}

	// Free: Solo pueden organizar un evento a la vez
	@Test
	def void unUsuarioFreeNoPuedeOrganizarMasDeUnEventoCerradoEnSimultaneo() {
		unUsuario.setUsuarioFree()
		unUsuario.organizarEventoCerrado(primerEvento)
		Assert.assertFalse(
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(unUsuario,eventoPrueba))
	}

		@Test(expected=EventoException)
	def void unUsuarioFreeNoPuedeOrganizarCuatroEventosCerradosPorMes() {
		unUsuario.setUsuarioFree()
		primerEvento.fechaDeInicio = LocalDateTime.of(2018, Month.MARCH, 18, 14, 13);
		primerEvento.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(3))
		unUsuario.organizarEventoCerrado(primerEvento)
		segundoEvento.fechaDeInicio = LocalDateTime.of(2018, Month.MARCH, 18, 14, 13);
		segundoEvento.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(5))
		unUsuario.organizarEventoCerrado(segundoEvento)
		tercerEvento.fechaDeInicio = LocalDateTime.of(2018, Month.MARCH, 18, 14, 13);
		tercerEvento.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(10))
		unUsuario.organizarEventoCerrado(tercerEvento)
		cuartoEvento.fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(1))
		cuartoEvento.fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(6))
		unUsuario.organizarEventoCerrado(cuartoEvento)

	}

	// Free: No puede cancelar eventos
	@Test
	def void unUsuarioFreeNoPuedeCancelarEventos() {
		unUsuario.setUsuarioFree()
		Assert.assertFalse(unUsuario.tipoDeUsuario.puedeCancelarEventos())
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
		unUsuario.organizarEventoCerrado(primerEvento)
		unUsuario.organizarEventoCerrado(segundoEvento)
		unUsuario.organizarEventoCerrado(tercerEvento)
		unUsuario.organizarEventoCerrado(cuartoEvento)
		Assert.assertTrue(
			unUsuario.organizarEventoCerrado(quintoEvento)
		)
	}

	// Amateur:  Pueden organizar hasta 5 eventos eventos en simultáneo
	@Test(expected=EventoException)
	def void unUsuarioAmateurNoPuedeOrganizarMasDe5EventosEnSimultaneo() {
		unUsuario.setUsuarioAmateur()
		unUsuario.organizarEventoCerrado(primerEvento)
		unUsuario.organizarEventoCerrado(segundoEvento)
		unUsuario.organizarEventoCerrado(tercerEvento)
		unUsuario.organizarEventoCerrado(cuartoEvento)
		unUsuario.organizarEventoCerrado(quintoEvento)
		unUsuario.organizarEventoCerrado(eventoPrueba)
	}

	// Profesional: Pueden organizar hasta 20 eventos al mes
	@Test
	def void unUsuarioProfesionalPuedeOrganizarHasta20EventosAlMes() {
		unUsuario.setUsuarioProfesional()
		for (contador = 0; contador < cantMaxDeEventos; contador = contador + 1) {
			unUsuario.organizarEventoCerrado(
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
			unUsuario.tipoDeUsuario.puedoOrganizarElEventoCerrado(unUsuario, eventoPrueba))
	}
}

