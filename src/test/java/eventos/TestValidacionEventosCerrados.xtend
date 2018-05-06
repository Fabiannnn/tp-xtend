package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Test
import org.junit.Assert
import excepciones.EventoException
import java.time.LocalDateTime
import java.time.Period

@Accessors
class TestValidacionEventosCerrados extends FixtureTest {
	@Test
	def void unEventoCerradoCompletoSeValidaSuOrganizacion() {
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoCerrado(reunionGrande)
		Assert.assertTrue(reunionGrande.organizador == usuario1)

	}

	@Test(expected=EventoException)
	def void unEventoCerradoSinNombreNoSeValidaSuOrganizacion() {
		reunionGrande.nombre = null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoCerrado(reunionGrande)
	}

	@Test(expected=EventoException)
	def void unEventoAbiertoSinLocacionNoSeValidaSuOrganizacion() {
		reunionAbierta.locacion = null

		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoAbierto(reunionAbierta)
	}

	@Test(expected=EventoException)
	def void unEventoAbiertoSinFechaDeInicioNoSeValidaSuOrganizacion() {
		reunionGrande.fechaDeInicio = null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoCerrado(reunionGrande)
	}

	@Test(expected=EventoException)
	def void unEventoAbiertoSinFechaDeFinalizacionNoSeValidaSuOrganizacion() {
		reunionGrande.fechaFinalizacion = null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoCerrado(reunionGrande)

	}

	@Test(expected=EventoException)
	def void unEventoAbiertoSinFechaDeConfirmacionNoSeValidaSuOrganizacion() {
		reunionGrande.fechaLimiteConfirmacion = null
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoCerrado(reunionGrande)
	}

	@Test(expected=EventoException)
	def void unEventoAbiertoFinalizacionAnteriorAInicioNoSeValidaSuOrganizacion() {
		reunionGrande.fechaFinalizacion = (LocalDateTime.now().plus(Period.ofDays(2)))
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoCerrado(reunionGrande)

	}

	@Test(expected=EventoException)
	def void unEventoAbiertoLimiteConfirmacionMayorAInicioNoSeValidaSuOrganizacion() {
		reunionGrande.fechaDeInicio = (LocalDateTime.now().plus(Period.ofDays(1)))
		usuario1.setUsuarioProfesional()
		usuario1.organizarEventoCerrado(reunionGrande)
	}

}
