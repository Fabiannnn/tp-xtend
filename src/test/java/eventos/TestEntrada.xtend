package eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.uqbar.geodds.Point
import java.time.LocalDate
import org.junit.Before
import org.junit.Test
import java.time.Period

class TestEntrada {
	EventoAbierto cumple
	Locacion salon_SM
	Usuario usuario1
	Entrada entradaPrueba

	@Before
	def void init() {
		salon_SM = new Locacion("San Martin", new Point(35, 45), 16)
		usuario1 = new Usuario("Organizador1", "xx", LocalDate.of(2002, 05, 15), "donde vive", new Point(40, 50))
		cumple = new EventoAbierto("Cumple de Algoritmos 2", usuario1, salon_SM,
			LocalDateTime.now().plus(Period.ofDays(25)), LocalDateTime.now().plus(Period.ofDays(26)),
			LocalDate.of(2018, 04, 17), 17, 100)
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
		cumple.fechaDeInicio = LocalDateTime.now()
		Assert.assertEquals(0.0, entradaPrueba.determinacionImporteDevolucion(), 0)
	}

}
