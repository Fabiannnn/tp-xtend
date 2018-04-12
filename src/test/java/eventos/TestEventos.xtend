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

	@Before
	def void init() {
	
		salon_SM = new Locacion=>[
			nombreLugar = "San Martin"
			punto = new Point(35, 45)
			superficie = 16
		]
		usuario1 = new Usuario=>[
			nombreDeUsuario = "Organizador1"
			fechaDeNacimiento = LocalDate.of(2002, 05, 15)
			coordenadasDireccion = new Point(40, 50)
		]
			
		cumple = new EventoAbierto =>[ 
			nombre = "Cumple de Algoritmos 2"
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(5))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(6))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))	
		]
				
		cumple = new EventoAbierto =>[ 
		//	nombre = "Cumple de Algoritmos 2"
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(5))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(6))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(3))	
		]
			
		reunionTrabajo = new EventoCerrado=>[ 
			organizador = usuario1
			locacion = salon_SM
			capacidadMaxima = 20
		]
	}
	
// Se chequea la determinación de capacidad del evento según sea Evento Cerrado o Abierto
	@Test
	def void capacidadSanMartinEnEventoCerrado_20persona() {
		Assert.assertEquals(20, reunionTrabajo.capacidadMaxima(), 0)
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

}
