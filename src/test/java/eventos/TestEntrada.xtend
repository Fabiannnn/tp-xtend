package eventos

import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test

@Accessors
class TestEntrada extends FixtureTest{
//test devolucion entradas
	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPorcentajeDevolucionIgualA80() {
		Assert.assertEquals(80.0, entradaPrueba.porcentajeDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteIgual160() {
		Assert.assertEquals(160.0, entradaPrueba.getImporteDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteDevuel80() {
		entradaPrueba.devolucionEntrada()
		Assert.assertEquals(160.0, usuario1.saldoCuenta , 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoVigenteFalso() {
		entradaPrueba.devolucionEntrada()
		Assert.assertFalse(entradaPrueba.vigente)
	}

	@Test
	def void devolverEntradaSinAnticipacionNoDebeDevolverDinero() {
		cumple.fechaDeInicio = LocalDateTime.now()
		Assert.assertEquals(0.0, entradaPrueba.getImporteDevolucion(), 0)
	}

}
