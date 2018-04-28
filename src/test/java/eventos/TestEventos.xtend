package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException
import java.time.LocalDateTime
import java.time.Period
import java.time.LocalDate

@Accessors
class TestEventos extends FixtureTest {
	//TipoDeUsuario usuarioProfesional

// Se chequea la determinación de capacidad del evento según sea Evento Cerrado o Abierto
	@Test
	def void capacidadSanMartinEnEventoCerrado_10persona() {
		Assert.assertEquals(10, reunionChica.capacidadMaxima(), 0)
	}

	@Test
	def void capacidadSanMartinEnEventoAbierto() {
		Assert.assertEquals(12, cumple.capacidadMaxima(), 0)
	}

// Testeo duración de evento y método de distancia
	@Test
	def void testDuracionDelCumple24horas() {
		Assert.assertEquals(24, cumple.duracion(), 0)
	}

	@Test
	def void testDistanciaASanMartin() {
		val estoyAca = new Point(35, 45)
		Assert.assertEquals(0.0, cumple.distancia(estoyAca), 0.0)
	}

	@Test
	def void testDistanciaASanMartin_Xmas10_Ymenos10_resultadoAproximado1400() {
		val estoyAca = new Point(45, 35)
		Assert.assertEquals(1400.0, cumple.distancia(estoyAca), 10.0)
	}

// testeo de validacion evento Abierto
	@Test(expected=EventoException)
	def void unEventoAbiertoSinNombreNoSeValidaSuOrganizacion() {
		reunionAbierta.nombre= null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}
		@Test(expected=EventoException)
	def void unEventoAbiertoSinLocacionNoSeValidaSuOrganizacion() {
		reunionAbierta.locacion= null

		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}
		@Test(expected=EventoException)
	def void unEventoAbiertoSinFechaDeInicioNoSeValidaSuOrganizacion() {
		reunionAbierta.fechaDeInicio= null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}
		@Test(expected=EventoException)
	def void unEventoAbiertoSinFechaDeFinalizacionNoSeValidaSuOrganizacion() {
		reunionAbierta.fechaFinalizacion= null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}
			@Test(expected=EventoException)
	def void unEventoAbiertoSinFechaDeConfirmacionNoSeValidaSuOrganizacion() {
		reunionAbierta.fechaLimiteConfirmacion= null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}
	
			@Test(expected=EventoException)
	def void unEventoAbiertoFinalizacionAnteriorAInicioNoSeValidaSuOrganizacion() {
		reunionAbierta.fechaFinalizacion=(LocalDateTime.now().plus(Period.ofDays(2)))
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}
	
			@Test(expected=EventoException)
	def void unEventoAbiertoLimiteConfirmacionMayorAInicioNoSeValidaSuOrganizacion() {
		reunionAbierta.fechaDeInicio=(LocalDateTime.now().plus(Period.ofDays(1)))
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}
	// FALTARIA REPETIR ESTOS TEST PARA EVENTOS CERRADOS


}
