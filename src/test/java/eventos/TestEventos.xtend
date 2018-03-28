package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import java.time.LocalDateTime
import org.uqbar.geodds.Point

class TestEventos {
	Evento cumple

	@Before
	def void init() {
		cumple = new Evento("Cumple de Algoritmos 2", new Locacion("San Martin", new Point(35, 45)))
		cumple.fechaDeInicio = LocalDateTime.of(2017, 08, 20, 8, 20)
		cumple.fechaFinalizacion = LocalDateTime.of(2017, 08, 20, 9, 50)
	}

	@Test
	def void testDuracionDelCumple300() {
		Assert.assertEquals(1.5, cumple.duracion(), 0)
	}

	@Test
	def void testDistanciaASanMartin() {
		val estoyAca = new Point(35, 45)
		Assert.assertEquals(0.0, cumple.distancia(estoyAca), 0.0)
	}

	@Test
	def void testDistanciaASanMartin_Xmas10_Ymenos10_resultadoAproximado1400() {
		val estoyAca = new Point(45, 35)
		Assert.assertEquals(1400.0, cumple.distancia(estoyAca), 100.0)
	}

}
