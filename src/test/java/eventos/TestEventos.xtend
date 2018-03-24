package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import java.time.LocalDateTime
import org.uqbar.geodds.Point

class TestEventos {
	Evento cumple
	Evento jazz
	Localizacion Local1

	@Before
	def void init() {

		cumple = new Evento()
		cumple.fechaDeInicio = LocalDateTime.of(2017, 08, 20, 8, 20)
		cumple.fechaFinalizacion = LocalDateTime.of(2017, 08, 20, 8, 25)
		jazz = new Evento()
		Local1 = new Localizacion("Local1", new Point(35, 45))
	}

	@Test
	def void testDuracionDelCumple300() {
		Assert.assertEquals(300, cumple.duracion(), 0)
	}

	@Test
	def void testDistanciaALocal1_0() {
		val estoyAca = new Point(35, 45)
		Assert.assertEquals(0.0, Local1.distancia(estoyAca), 0.0)
	}

	@Test
	def void testDistanciaALocal1_Xmas10_Ymenos10_resultadoAproximado1400() {
		val estoyAca = new Point(45, 35)
		Assert.assertEquals(1400.0, Local1.distancia(estoyAca), 100.0)
	}

}