package eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import excepciones.EventoException

class TestLocacionBuilder {
	Locacion salon_SM
	Locacion salonIncompleto

	@Before
	def void init() {
		salon_SM = new LocacionBuilder().nombre("San Martin").punto(new Point(35, 45)).superficie(16).build
	}

// Se chequea la determinación de capacidad del evento según sea Evento Cerrado o Abierto
	@Test
	def void validarLocacionSM() {
		Assert.assertEquals(16, salon_SM.superficie, 0)
	}

	@Test(expected=EventoException)
	def void locacionSinUbicacionDaExcepcion() {
		salonIncompleto = new LocacionBuilder().nombre("San Martin").superficie(16).build
	}

	@Test(expected=EventoException)
	def void locacionSinNombreDaExcepcion() {
		salonIncompleto = new LocacionBuilder().punto(new Point(35, 45)).superficie(16).build
	}

}
