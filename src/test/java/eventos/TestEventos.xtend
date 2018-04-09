package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import java.time.LocalDateTime
import org.uqbar.geodds.Point
import java.time.LocalDate
import java.time.Period

class TestEventos {
	EventoAbierto cumple
	EventoCerrado reunionTrabajo
	Locacion salon_SM
	Usuario usuario1
	LocalDateTime hoyMasTres = LocalDateTime.now().plus(Period.ofDays(3))
 	LocalDateTime hoyMasCinco = LocalDateTime.now().plus(Period.ofDays(5))
	@Before
	def void init() {
		salon_SM = new Locacion("San Martin", new Point(35, 45), 16)
		usuario1 = new Usuario("Organizador1", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(40, 50))
		cumple = new EventoAbierto("Cumple de Algoritmos 2", usuario1, salon_SM, hoyMasTres, hoyMasCinco,LocalDate.of(2018, 05, 30), 17, 20.5)
		reunionTrabajo = new EventoCerrado("Reunion proyecto", usuario1, salon_SM, hoyMasTres, hoyMasCinco,LocalDate.of(2018, 04, 15), 20)
		cumple.fechaDeInicio = LocalDateTime.of(2017, 08, 20, 8, 20)
		cumple.fechaFinalizacion = LocalDateTime.of(2017, 08, 20, 9, 50)
	}

	@Test
	def void capacidadSanMartinEnEventoCerrado_20persona() {
		Assert.assertEquals(20, reunionTrabajo.capacidadMaxima(), 0)
	}

	@Test
	def void capacidadSanMartinEnEventoAbierto() {
		Assert.assertEquals(12, cumple.capacidadMaxima(), 0)
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
