package eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.uqbar.geodds.Point
import java.time.LocalDate
import org.junit.Before
import org.junit.Test

class TestEntrada {
	EventoAbierto cumple
	Locacion salon_SM
	Usuario usuario1
	Entrada entradaPrueba

	@Before
	def void init() {
		salon_SM = new Locacion("San Martin", new Point(35, 45), 16)
		usuario1 = new Usuario("Organizador1", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(40, 50))
		cumple = new EventoAbierto("Cumple de Algoritmos 2", usuario1, salon_SM, LocalDate.of(2018, 04, 17), 17, 100)
		cumple.fechaDeInicio = LocalDateTime.of(2017, 04, 20, 8, 20)
		cumple.fechaFinalizacion = LocalDateTime.of(2017, 04, 20, 9, 50)
		entradaPrueba = new Entrada(cumple, usuario1)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPorcentajeDevolucionIgualA80() {

		Assert.assertEquals(80.0, entradaPrueba.porcentajeDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteIgual80() {

		Assert.assertEquals(80.0, entradaPrueba.determinacionImporteDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteDevuel80() {
		entradaPrueba.devolucionEntrada()
		Assert.assertEquals(80.0, entradaPrueba.importeDevuelto, 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoVigenteFalso() {
		entradaPrueba.devolucionEntrada()
		Assert.assertFalse(entradaPrueba.vigente)
	}

	@Test
	def void devolverEntradaSinAnticipacionNoDebeDevolverDinero() {
		cumple.fechaDeInicio = LocalDateTime.of(2017, 04, 04, 8, 20)
		Assert.assertEquals(0.0, entradaPrueba.determinacionImporteDevolucion(), 0)
	}

}
